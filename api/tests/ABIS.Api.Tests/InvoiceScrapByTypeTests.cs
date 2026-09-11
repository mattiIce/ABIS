using System.Net;
using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Data.Sqlite;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// Scrap weight by scrap type on the invoice.
///
/// <para><b>What it ports.</b> The one section legacy nests inside the printed invoice:
/// <c>d_report_invoice_data</c> → <c>d_acct_scrap_type_list</c> (a row per type the job's scrap items reach
/// through their scrap skid) → <c>d_acct_scrap_type_summary</c> (the weight). Live data: 95% of jobs finished in
/// the last 12 months on <c>.230</c> carry typed scrap.</para>
///
/// <para><b>Two deliberate departures, both measured.</b> Legacy's summary sums <c>DISTINCT</c> weights, so two
/// items of equal weight count once — 2,966 job/type groups understated on <c>.230</c>, 8.5M lb all-time.
/// And items on no scrap skid simply vanished from legacy's breakdown, so its rows could add up to less than the
/// Total Scrap Weight printed above them. Here the sum is plain and those items get their own row.</para>
///
/// <para>Each test gets its own database; rows are inserted after the host starts, because startup is what
/// creates and seeds it. The fixture already gives job 1001 one scrap item (6101, 30 lb) on no skid.</para>
/// </summary>
public sealed class InvoiceScrapByTypeTests
{
    private sealed class Factory : WebApplicationFactory<Program>
    {
        public string DbPath { get; } = Path.Combine(Path.GetTempPath(), $"abis_invscrap_{Guid.NewGuid():N}.db");
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

    private static HttpClient Client(WebApplicationFactory<Program> f)
    {
        var c = f.CreateClient();
        c.DefaultRequestHeaders.Add("X-Api-Key", "test-key");
        return c;
    }

    private static void Exec(Factory f, string sql)
    {
        using var conn = new SqliteConnection($"Data Source={f.DbPath}");
        conn.Open();
        using var cmd = conn.CreateCommand();
        cmd.CommandText = sql;
        cmd.ExecuteNonQuery();
    }

    /// <summary>
    /// Job 1001 gains two type-1 items of EQUAL weight (25 lb each) on one skid and a type-9 item (10 lb) on
    /// another. With the fixture's unskidded 30 lb item the job's scrap is 90 lb.
    /// </summary>
    private static void SeedJob1001(Factory f) => Exec(f, """
        INSERT INTO scrap_skid (scrap_skid_num, scrap_ab_job_num, scrap_type, scrap_net_wt, scrap_tare_wt)
        VALUES (69101, '1001', 1, 50, 10), (69102, '1001', 9, 10, 5);
        INSERT INTO return_scrap_item (return_scrap_item_num, ab_job_num, return_item_net_wt)
        VALUES (69001, 1001, 25), (69002, 1001, 25), (69003, 1001, 10);
        INSERT INTO scrap_skid_detail (scrap_skid_num, return_scrap_item_num)
        VALUES (69101, 69001), (69101, 69002), (69102, 69003);
        """);

    private static async Task<JsonElement> Computation(HttpClient c, long job) =>
        await c.GetFromJsonAsync<JsonElement>($"/api/accounting/invoices/{job}/computation");

    [Fact]
    public async Task Scrap_is_broken_down_by_type_and_reconciles_to_the_total()
    {
        using var f = new Factory();
        var c = Client(f);
        SeedJob1001(f);

        var inv = await Computation(c, 1001);
        var rows = inv.GetProperty("scrapByType").EnumerateArray().ToList();

        Assert.Equal(2, rows.Count);
        Assert.Equal(1, rows[0].GetProperty("scrapType").GetInt32());
        Assert.Equal("Rej. Sheet-Mill", rows[0].GetProperty("scrapTypeName").GetString());
        Assert.Equal(2, rows[0].GetProperty("items").GetInt32());
        Assert.Equal(9, rows[1].GetProperty("scrapType").GetInt32());
        Assert.Equal("Scrap Credit", rows[1].GetProperty("scrapTypeName").GetString());
        Assert.Equal(10m, rows[1].GetProperty("netWt").GetDecimal());

        var byType = rows.Sum(r => r.GetProperty("netWt").GetDecimal());
        var notOnSkid = inv.GetProperty("scrapNotOnSkidWt").GetDecimal();
        Assert.Equal(inv.GetProperty("scrapWt").GetDecimal(), byType + notOnSkid);
    }

    /// <summary>The guard against legacy's DISTINCT: two 25 lb items of one type are 50 lb, not 25.</summary>
    [Fact]
    public async Task Two_items_of_equal_weight_both_count()
    {
        using var f = new Factory();
        var c = Client(f);
        SeedJob1001(f);

        var typeOne = (await Computation(c, 1001)).GetProperty("scrapByType").EnumerateArray()
            .Single(r => r.GetProperty("scrapType").GetInt32() == 1);

        Assert.Equal(50m, typeOne.GetProperty("netWt").GetDecimal());
    }

    /// <summary>Scrap on no skid has no type, and legacy dropped it from the breakdown. It gets its own row.</summary>
    [Fact]
    public async Task Scrap_on_no_skid_is_reported_rather_than_dropped()
    {
        using var f = new Factory();
        var c = Client(f);
        SeedJob1001(f);

        Assert.Equal(30m, (await Computation(c, 1001)).GetProperty("scrapNotOnSkidWt").GetDecimal());
    }

    [Fact]
    public async Task The_printed_invoice_carries_the_section()
    {
        using var f = new Factory();
        var c = Client(f);
        SeedJob1001(f);

        var html = await c.GetStringAsync("/api/documents/invoice/1001");

        Assert.Contains("Scrap by type", html);
        Assert.Contains("Rej. Sheet-Mill", html);
        Assert.Contains("50 lb", html);
        Assert.Contains("Scrap Credit", html);
        Assert.Contains("Not on a scrap skid", html);
        Assert.Contains("30 lb", html);
        Assert.Contains("90 lb", html);
    }

    /// <summary>
    /// Legacy's label list stops at 8, so a Scrap Credit (9), Full Sheet (10) or Cut Out (11) skid printed its
    /// Scrap Status with no name. Job 1003's only scrap skid is re-typed to 11.
    /// </summary>
    [Fact]
    public async Task A_scrap_type_above_eight_is_named()
    {
        using var f = new Factory();
        var c = Client(f);
        Exec(f, "UPDATE scrap_skid SET scrap_type = 11 WHERE scrap_skid_num = 8002");

        Assert.Equal("Cut Out", (await Computation(c, 1003)).GetProperty("scrapStatus").GetString());
    }

    /// <summary>Job 1003 has a scrap skid but no scrap items: nothing to break down, so no section at all.</summary>
    [Fact]
    public async Task A_job_with_no_scrap_items_prints_no_section()
    {
        using var f = new Factory();
        var c = Client(f);

        var inv = await Computation(c, 1003);
        Assert.Empty(inv.GetProperty("scrapByType").EnumerateArray());
        Assert.Equal(0m, inv.GetProperty("scrapNotOnSkidWt").GetDecimal());
        Assert.DoesNotContain("Scrap by type", await c.GetStringAsync("/api/documents/invoice/1003"));
    }
}
