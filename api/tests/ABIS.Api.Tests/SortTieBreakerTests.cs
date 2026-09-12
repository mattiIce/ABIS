using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Data.Sqlite;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// Rows that tie on the sort column come back in a defined order — including on the DEFAULT ordering.
///
/// <para><b>What this caught.</b> <c>Sort.TryResolve</c> appended the resource's tie-breaker only when the
/// caller passed an explicit <c>sort</c>; the default ordering was returned untouched. Test results default to
/// <c>created_date DESC</c> and 47,516 of them share just 8,317 timestamps on <c>.230</c>, so the live API
/// returned four results of one timestamp in no particular order — visible only once the endpoint was run
/// against real data, because the repository-level default this project also carries is never reached when an
/// endpoint resolves its own ORDER BY.</para>
///
/// <para>The rows below are inserted in the OPPOSITE order to the tie-breaker, so an unordered query returns
/// them insertion-first and this test fails — which is what makes it worth writing rather than a structural
/// check.</para>
/// </summary>
public sealed class SortTieBreakerTests
{
    private sealed class Factory : WebApplicationFactory<Program>
    {
        public string DbPath { get; } = Path.Combine(Path.GetTempPath(), $"abis_tiebreak_{Guid.NewGuid():N}.db");
        protected override void ConfigureWebHost(IWebHostBuilder builder)
        {
            builder.UseEnvironment("Development");
            builder.UseSetting("Database:Provider", "Sqlite");
            builder.UseSetting("Database:ConnectionString", $"Data Source={DbPath}");
            builder.UseSetting("Database:Seed", "true");
            builder.UseSetting("ApiKeys:Enabled", "true");
            builder.UseSetting("ApiKeys:Keys:0", "test-key");
        }
        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
            SqliteConnection.ClearAllPools();
            try { if (File.Exists(DbPath)) File.Delete(DbPath); } catch { /* best effort */ }
        }
    }

    private static void Exec(Factory f, string sql)
    {
        using var conn = new SqliteConnection($"Data Source={f.DbPath}");
        conn.Open();
        using var cmd = conn.CreateCommand();
        cmd.CommandText = sql;
        cmd.ExecuteNonQuery();
    }

    /// <summary>Four results on one timestamp, written high-coil-first so insertion order is the reverse of
    /// the tie-breaker's (coil, position).</summary>
    private static HttpClient Client(Factory f)
    {
        var c = f.CreateClient();
        c.DefaultRequestHeaders.Add("X-Api-Key", "test-key");
        Exec(f, """
            INSERT INTO pst_test_result (coil_abc_num, position, created_date, source_id, test_type, yts_val)
            VALUES (9002, '21', '2026-04-01 10:00:00', 0, 1, 100),
                   (9002, '11', '2026-04-01 10:00:00', 0, 1, 101),
                   (9001, '21', '2026-04-01 10:00:00', 0, 1, 102),
                   (9001, '11', '2026-04-01 10:00:00', 0, 1, 103);
            """);
        return c;
    }

    private static async Task<List<string>> TiedRows(HttpClient c, string query)
    {
        var page = await c.GetFromJsonAsync<JsonElement>($"/api/test-results?{query}");
        return page.GetProperty("items").EnumerateArray()
            .Where(r => (r.GetProperty("createdDate").GetString() ?? "").StartsWith("2026-04-01", StringComparison.Ordinal))
            .Select(r => $"{r.GetProperty("coilAbcNum").GetInt64()}/{r.GetProperty("position").GetString()}")
            .ToList();
    }

    [Fact]
    public async Task The_default_ordering_breaks_ties_by_the_primary_key()
    {
        using var f = new Factory();

        var rows = await TiedRows(Client(f), "pageSize=50");

        Assert.Equal(["9001/11", "9001/21", "9002/11", "9002/21"], rows);
    }

    [Fact]
    public async Task An_explicit_sort_on_a_tied_column_breaks_ties_the_same_way()
    {
        using var f = new Factory();

        var rows = await TiedRows(Client(f), "pageSize=50&sort=createdDate&dir=desc");

        Assert.Equal(["9001/11", "9001/21", "9002/11", "9002/21"], rows);
    }

    /// <summary>The boundary case the tie-breaker exists for: with four tied rows split across two pages of
    /// two, each row appears exactly once.</summary>
    [Fact]
    public async Task Paging_through_tied_rows_shows_each_of_them_once()
    {
        using var f = new Factory();
        var c = Client(f);

        var seen = new List<string>();
        for (var p = 1; p <= 3; p++) seen.AddRange(await TiedRows(c, $"page={p}&pageSize=2"));

        Assert.Equal(["9001/11", "9001/21", "9002/11", "9002/21"], seen.Distinct().Order().ToList());
        Assert.Equal(4, seen.Count);
    }
}
