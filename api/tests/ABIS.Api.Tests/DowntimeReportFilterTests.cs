using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Data.Sqlite;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// The two remaining modes of legacy's downtime report screen (<c>w_report_downtime</c>), served as cause
/// and job filters on <c>/reporting/downtime-pivot</c>.
///
/// <para><b>Daily per category</b> (<c>d_report_downtime_daily_per_cat</c>): one cause's minutes per day —
/// <c>groupBy=day&amp;causeId=</c>. <b>Compare two jobs</b> (<c>d_report_downtime_abjob_comp</c>): minutes per
/// cause for a job — <c>groupBy=cause&amp;abJobNum=</c>, called once per job.</para>
///
/// <para>Seeded downtime (all on 2026-01-02): job 1001 on line 110 has two "Coil change" stops (1200s + 300s);
/// job 1003 on line 120 has one "Jam" (600s). Each test adds a 2019 "Jam" on job 1001 — outside the default
/// 365-day window, which a job filter must not apply: legacy's comparison has no date range at all.</para>
/// </summary>
public sealed class DowntimeReportFilterTests
{
    private sealed class Factory : WebApplicationFactory<Program>
    {
        public string DbPath { get; } = Path.Combine(Path.GetTempPath(), $"abis_dtfilter_{Guid.NewGuid():N}.db");
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

    private static HttpClient Client(Factory f)
    {
        var c = f.CreateClient();
        c.DefaultRequestHeaders.Add("X-Api-Key", "test-key");
        using var conn = new SqliteConnection($"Data Source={f.DbPath}");
        conn.Open();
        using var cmd = conn.CreateCommand();
        cmd.CommandText = """
            INSERT INTO dt_instance (instance_num, ab_job_num, line_num, starting_time, ending_time, note, shift_num)
            VALUES (9901, 1001, 110, '2019-05-01 08:00:00', '2019-05-01 08:15:00', 'old jam', NULL);
            INSERT INTO dt_instance_detail (instance_num, instance_item, id, duration, note)
            VALUES (9901, 1, 2, 900, 'old jam');
            """;
        cmd.ExecuteNonQuery();
        return c;
    }

    private static async Task<List<JsonElement>> Pivot(HttpClient c, string query) =>
        (await c.GetFromJsonAsync<JsonElement>($"/api/reporting/downtime-pivot?{query}")).EnumerateArray().ToList();

    [Fact]
    public async Task One_causes_downtime_day_by_day()
    {
        using var f = new Factory();
        var c = Client(f);
        const string window = "from=2026-01-01T00:00:00&to=2027-01-01T00:00:00";

        var coilChange = Assert.Single(await Pivot(c, $"{window}&groupBy=day&causeId=1"));
        Assert.Equal("2026-01-02", coilChange.GetProperty("bucket").GetString());
        Assert.Equal(2, coilChange.GetProperty("occurrences").GetInt32());
        Assert.Equal(25.0, coilChange.GetProperty("downtimeMinutes").GetDouble());

        var jam = Assert.Single(await Pivot(c, $"{window}&groupBy=day&causeId=2"));
        Assert.Equal(10.0, jam.GetProperty("downtimeMinutes").GetDouble());
    }

    [Fact]
    public async Task A_jobs_downtime_by_cause_is_only_that_job()
    {
        using var f = new Factory();
        var c = Client(f);

        var job1003 = Assert.Single(await Pivot(c, "groupBy=cause&abJobNum=1003"));
        Assert.Equal("Jam", job1003.GetProperty("bucket").GetString());
        Assert.Equal(10.0, job1003.GetProperty("downtimeMinutes").GetDouble());
    }

    /// <summary>A job bounds itself: the 2019 stop on job 1001 is part of that job's comparison even with no
    /// date window, where every other pivot falls back to the last 365 days and leaves it out.</summary>
    [Fact]
    public async Task A_job_is_compared_whole_not_through_the_default_window()
    {
        using var f = new Factory();
        var c = Client(f);

        var job1001 = await Pivot(c, "groupBy=cause&abJobNum=1001");
        Assert.Equal(["Coil change", "Jam"], job1001.Select(r => r.GetProperty("bucket").GetString()).ToList());
        Assert.Equal(15.0, job1001.Single(r => r.GetProperty("bucket").GetString() == "Jam").GetProperty("downtimeMinutes").GetDouble());

        // Without a job the default window still applies, so the 2019 stop is not in the all-jobs view.
        var allJobs = await Pivot(c, "groupBy=cause");
        Assert.Equal(10.0, allJobs.Single(r => r.GetProperty("bucket").GetString() == "Jam").GetProperty("downtimeMinutes").GetDouble());
    }

    [Fact]
    public async Task Cause_and_job_filters_combine()
    {
        using var f = new Factory();
        var c = Client(f);

        var only = Assert.Single(await Pivot(c, "groupBy=year&abJobNum=1001&causeId=2"));
        Assert.Equal("2019", only.GetProperty("bucket").GetString());
        Assert.Equal(15.0, only.GetProperty("downtimeMinutes").GetDouble());
    }
}
