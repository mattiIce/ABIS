using System.Net;
using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Data.Sqlite;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// A coil's history, and the four figures legacy derives from it.
///
/// <para><b>What it ports.</b> The coil-history panel beside legacy's coil list (<c>w_inv_coil</c> →
/// <c>d_coil_history</c>, linked to the selected coil), plus the columns that list computes per row through
/// <c>f_get_coil_duration</c> (days since the last tracked change, 0 once the coil is Done/Shipped),
/// <c>f_get_rejected_date</c> (3), <c>f_get_onhold_date</c> (4) and <c>f_get_rebanded_date</c> (7) — each the
/// FIRST time the coil reached that status.</para>
///
/// <para>Durations are asserted against rows this file writes relative to today; the fixture's own dates are
/// fixed at 2026-01-02, which would make "days since" drift with the calendar.</para>
/// </summary>
public sealed class CoilHistoryTests
{
    private sealed class Factory : WebApplicationFactory<Program>
    {
        public string DbPath { get; } = Path.Combine(Path.GetTempPath(), $"abis_coilhist_{Guid.NewGuid():N}.db");
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

    private static string Ago(int days) => DateTime.Now.Date.AddDays(-days).ToString("yyyy-MM-dd HH:mm:ss");

    /// <summary>
    /// 5777 — on hold 30 days ago, released 20 days ago, held AGAIN 5 days ago (so "first on hold" has a
    /// later row to ignore). 5778 has left the floor (status 10 Shipped) with a 40-day-old change.
    /// 5779 was received 7 days ago and never tracked at all.
    /// </summary>
    private static HttpClient Client(Factory f)
    {
        var c = f.CreateClient();
        c.DefaultRequestHeaders.Add("X-Api-Key", "test-key");
        Exec(f, $"""
            INSERT INTO coil (coil_abc_num, coil_org_num, lot_num, coil_status, customer_id, net_wt, net_wt_balance, date_received)
            VALUES (5777, 'HIST-A', 'LOT-A', 4, 4001, 10000, 10000, '{Ago(60)}'),
                   (5778, 'HIST-B', 'LOT-B', 10, 4001, 9000, 0, '{Ago(90)}'),
                   (5779, 'HIST-C', 'LOT-C', 2, 4001, 8000, 8000, '{Ago(7)}');
            INSERT INTO coil_track (coil_abc_num, coil_track_date, coil_pre_status, coil_cur_status,
                                    coil_pre_netwt, coil_cur_netwt, coil_modified_by, coil_pre_location, coil_cur_location)
            VALUES (5777, '{Ago(30)}', 2, 4, 10000, 10000, 'jsmith', 'Building 1', 'Building 1'),
                   (5777, '{Ago(20)}', 4, 2, 10000, 10000, 'mlee',   'Building 1', 'Building 3'),
                   (5777, '{Ago(5)}',  2, 4,  10000,  9500, 'jsmith', 'Building 3', 'Building 3'),
                   (5778, '{Ago(40)}', 2, 10,  9000,     0, 'mlee',   'Building 2', 'Shipped');
            """);
        return c;
    }

    private static async Task<JsonElement> History(HttpClient c, long coil) =>
        await c.GetFromJsonAsync<JsonElement>($"/api/coils/{coil}/history");

    [Fact]
    public async Task The_changes_come_back_newest_first_with_who_made_them()
    {
        using var f = new Factory();
        var entries = (await History(Client(f), 5777)).GetProperty("entries").EnumerateArray().ToList();

        Assert.Equal(3, entries.Count);
        Assert.Equal(4, entries[0].GetProperty("curStatus").GetInt32());      // newest: held again
        Assert.Equal(9500m, entries[0].GetProperty("curNetWt").GetDecimal());
        Assert.Equal("jsmith", entries[0].GetProperty("modifiedBy").GetString());
        Assert.Equal(2, entries[1].GetProperty("curStatus").GetInt32());      // the release
        Assert.Equal("Building 3", entries[1].GetProperty("curLocation").GetString());
        Assert.Equal(4, entries[2].GetProperty("curStatus").GetInt32());      // oldest: first hold
    }

    /// <summary>Legacy takes MIN(coil_track_date) per status: a coil held twice keeps the FIRST date.</summary>
    [Fact]
    public async Task On_hold_reports_when_it_was_first_held_not_the_latest()
    {
        using var f = new Factory();
        var h = await History(Client(f), 5777);

        Assert.Equal(DateTime.Now.Date.AddDays(-30), h.GetProperty("onHoldDate").GetDateTime().Date);
        Assert.Equal(JsonValueKind.Null, h.GetProperty("rejectedDate").ValueKind);
        Assert.Equal(JsonValueKind.Null, h.GetProperty("rebandedDate").ValueKind);
    }

    /// <summary>Duration is days since the most recent change — 5 here, not 30 from the first.</summary>
    [Fact]
    public async Task Duration_counts_from_the_most_recent_change()
    {
        using var f = new Factory();

        Assert.Equal(5, (await History(Client(f), 5777)).GetProperty("durationDays").GetInt32());
    }

    /// <summary>Legacy's own rule: a coil that has left inventory (0 Done / 10 Shipped) reads 0, so
    /// shipped material never shows up as ageing stock.</summary>
    [Fact]
    public async Task A_shipped_coil_has_no_duration()
    {
        using var f = new Factory();

        Assert.Equal(0, (await History(Client(f), 5778)).GetProperty("durationDays").GetInt32());
    }

    /// <summary>Never tracked: the clock runs from when the coil was received.</summary>
    [Fact]
    public async Task A_coil_with_no_history_counts_from_when_it_was_received()
    {
        using var f = new Factory();
        var h = await History(Client(f), 5779);

        Assert.Empty(h.GetProperty("entries").EnumerateArray());
        Assert.Equal(7, h.GetProperty("durationDays").GetInt32());
    }

    [Fact]
    public async Task An_unknown_coil_is_not_found()
    {
        using var f = new Factory();

        Assert.Equal(HttpStatusCode.NotFound, (await Client(f).GetAsync("/api/coils/999777/history")).StatusCode);
    }
}
