using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Data.Sqlite;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// Average LBs per hour — the plant's ALPH report (legacy <c>w_daily_prod_report_alph</c>, opened from the
/// daily-production screen's Shift reports).
///
/// <para><b>What it ports.</b> Per shift: <c>SUM(shift_coil.process_wt)</c> ÷ the shift's hours; then a
/// <b>Daily</b> roll-up per day, with the line's goal (<c>line.avg_lb_per_hr</c> — set per line on <c>.230</c>)
/// and the line's average over the window repeated on every row, as legacy fills its Goal / Avg_All columns.</para>
///
/// <para><b>The deliberate departure.</b> Legacy abandons the entire report when a shift has no usable length
/// ("Invalid Date Info", then it closes the window). On <c>.230</c> 16 of the last year's 830 shifts have no end
/// time — including the most recent — so that is the normal case near "today". Here the shift is reported as
/// <c>open</c> (or <c>invalid</c>) and left out of the averages.</para>
///
/// <para>Each test gets its own database; rows are inserted after the host starts, because startup is what
/// creates and seeds it. Line 777 is this file's own line, so the fixture's lines cannot skew a figure.</para>
/// </summary>
public sealed class LbsPerHourReportTests
{
    private sealed class Factory : WebApplicationFactory<Program>
    {
        public string DbPath { get; } = Path.Combine(Path.GetTempPath(), $"abis_alph_{Guid.NewGuid():N}.db");
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

    /// <summary>
    /// Line 777, goal 900 lb/h. 02 Mar: a 4 h shift at 4,000 lb (1,000/h) and a 6 h shift at 3,000 lb (500/h)
    /// — so the day is 10 h / 7,000 lb = 700/h. 03 Mar: 5 h at 5,000 lb = 1,000/h. Across the window:
    /// 15 h / 12,000 lb = 800/h.
    /// </summary>
    private static HttpClient Client(Factory f, string extraSql = "")
    {
        var c = f.CreateClient();
        c.DefaultRequestHeaders.Add("X-Api-Key", "test-key");
        Exec(f, """
            INSERT INTO line (line_num, line_desc, line_location, avg_lb_per_hr) VALUES (777, 'ALPH test line', NULL, 900);
            INSERT INTO shift (shift_num, start_time, end_time, line_num, schedule_type) VALUES
                (7801, '2026-03-02 05:00:00', '2026-03-02 09:00:00', 777, 1),
                (7802, '2026-03-02 15:00:00', '2026-03-02 21:00:00', 777, 2),
                (7803, '2026-03-03 05:00:00', '2026-03-03 10:00:00', 777, 1);
            INSERT INTO shift_coil (shift_num, coil_run_num, coil_abc_num, ab_job_num, process_wt) VALUES
                (7801, 1, 5001, 1001, 2500), (7801, 2, 5002, 1001, 1500),
                (7802, 1, 5001, 1001, 3000),
                (7803, 1, 5001, 1001, 5000);
            """ + extraSql);
        return c;
    }

    private static async Task<List<JsonElement>> Rows(HttpClient c, string query) =>
        (await c.GetFromJsonAsync<JsonElement>($"/api/reporting/lbs-per-hour?{query}")).EnumerateArray().ToList();

    private const string Window = "from=2026-03-01&to=2026-03-10";

    private static JsonElement Row(List<JsonElement> rows, string day, string shift) =>
        rows.Single(r => r.GetProperty("day").GetString() == day && r.GetProperty("shift").GetString() == shift);

    [Fact]
    public async Task Each_shift_carries_its_own_pounds_per_hour()
    {
        using var f = new Factory();
        var rows = await Rows(Client(f), $"lineNum=777&{Window}");

        Assert.Equal(1000, Row(rows, "2026-03-02", "1st Shift").GetProperty("lbsPerHour").GetDouble());
        Assert.Equal(500, Row(rows, "2026-03-02", "2nd Shift").GetProperty("lbsPerHour").GetDouble());
        Assert.Equal(4, Row(rows, "2026-03-02", "1st Shift").GetProperty("hours").GetDouble());
        Assert.Equal(4000m, Row(rows, "2026-03-02", "1st Shift").GetProperty("processedWt").GetDecimal());
    }

    /// <summary>The day's own row is the day's weight over the day's hours — not the mean of its shifts
    /// (7,000/10 = 700, where averaging 1,000 and 500 would say 750).</summary>
    [Fact]
    public async Task The_daily_row_divides_the_days_weight_by_the_days_hours()
    {
        using var f = new Factory();
        var rows = await Rows(Client(f), $"lineNum=777&{Window}");

        var daily = Row(rows, "2026-03-02", "Daily");
        Assert.True(daily.GetProperty("isDailyTotal").GetBoolean());
        Assert.Equal(700, daily.GetProperty("lbsPerHour").GetDouble());
        Assert.Equal(10, daily.GetProperty("hours").GetDouble());
        Assert.Equal(7000m, daily.GetProperty("processedWt").GetDecimal());
    }

    [Fact]
    public async Task Every_row_carries_the_lines_goal_and_its_window_average()
    {
        using var f = new Factory();
        var rows = await Rows(Client(f), $"lineNum=777&{Window}");

        Assert.All(rows, r =>
        {
            Assert.Equal(900m, r.GetProperty("goal").GetDecimal());
            Assert.Equal(800, r.GetProperty("rangeAverage").GetDouble());
        });
        Assert.Equal(1000, Row(rows, "2026-03-03", "Daily").GetProperty("lbsPerHour").GetDouble());
    }

    /// <summary>A shift still open has no hours to divide by. Legacy abandons the whole report; here the row
    /// says "open", keeps its weight, and stays out of the Daily and window averages.</summary>
    [Fact]
    public async Task An_open_shift_is_reported_rather_than_killing_the_report()
    {
        using var f = new Factory();
        var c = Client(f, """
            INSERT INTO shift (shift_num, start_time, end_time, line_num, schedule_type) VALUES
                (7804, '2026-03-04 05:00:00', NULL, 777, 1);
            INSERT INTO shift_coil (shift_num, coil_run_num, coil_abc_num, ab_job_num, process_wt) VALUES (7804, 1, 5001, 1001, 2000);
            """);

        var rows = await Rows(c, $"lineNum=777&{Window}");
        var open = Row(rows, "2026-03-04", "1st Shift");

        Assert.Equal("open", open.GetProperty("status").GetString());
        Assert.Equal(JsonValueKind.Null, open.GetProperty("hours").ValueKind);
        Assert.Equal(JsonValueKind.Null, open.GetProperty("lbsPerHour").ValueKind);
        Assert.Equal(2000m, open.GetProperty("processedWt").GetDecimal());
        // Its 2,000 lb are not folded into any average.
        Assert.Equal(800, open.GetProperty("rangeAverage").GetDouble());
        Assert.Equal(JsonValueKind.Null, Row(rows, "2026-03-04", "Daily").GetProperty("lbsPerHour").ValueKind);
    }

    /// <summary>An end that is not after the start is "invalid" — and never a division by zero.</summary>
    [Fact]
    public async Task A_shift_whose_end_is_not_after_its_start_is_invalid()
    {
        using var f = new Factory();
        var c = Client(f, """
            INSERT INTO shift (shift_num, start_time, end_time, line_num, schedule_type) VALUES
                (7805, '2026-03-05 05:00:00', '2026-03-05 05:00:00', 777, 1);
            INSERT INTO shift_coil (shift_num, coil_run_num, coil_abc_num, ab_job_num, process_wt) VALUES (7805, 1, 5001, 1001, 900);
            """);

        var bad = Row(await Rows(c, $"lineNum=777&{Window}"), "2026-03-05", "1st Shift");

        Assert.Equal("invalid", bad.GetProperty("status").GetString());
        Assert.Equal(JsonValueKind.Null, bad.GetProperty("lbsPerHour").ValueKind);
    }

    [Fact]
    public async Task A_line_with_no_goal_set_reports_none()
    {
        using var f = new Factory();
        var c = Client(f);

        // The fixture's line 120 deliberately carries no avg_lb_per_hr.
        var rows = await Rows(c, "lineNum=120");

        Assert.NotEmpty(rows);
        Assert.All(rows, r => Assert.Equal(JsonValueKind.Null, r.GetProperty("goal").ValueKind));
    }

    [Fact]
    public async Task The_line_filter_keeps_other_lines_out()
    {
        using var f = new Factory();
        var c = Client(f);

        var oneLine = await Rows(c, $"lineNum=777&{Window}");
        // No window: the default (last 365 days) covers both this line's March shifts and the fixture's own.
        var allLines = await Rows(c, "");

        Assert.All(oneLine, r => Assert.Equal(777, r.GetProperty("lineNum").GetInt64()));
        Assert.Contains(allLines, r => r.GetProperty("lineNum").GetInt64() != 777);
    }
}
