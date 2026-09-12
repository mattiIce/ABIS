using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.Data.Sqlite;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// The office's customer-quality records for a job, with their codes decoded.
///
/// <para><b>What it ports.</b> Legacy's Customer Quality Report (<c>w_qa_skid_report</c> /
/// <c>d_qa_customer_quality_skid_report</c>), listing what the "Add Defect" button on the office skid-entry
/// screen wrote to <c>qa_customer_quality_skid</c>. Nothing in ABIS read that table: **2,250 records over 267
/// jobs on `.230`**, 42 in the last 12 months, were invisible.</para>
///
/// <para><b>The trap this pins.</b> <c>qa_cust_defect_disposition</c> is keyed by <c>(customer_id, disp_code)</c>
/// — each customer keeps its own list — so decoding on the code alone would show one customer's decision under
/// another's name. Customer 1153's code 3 is "OK to Release for shipment"; 1459 does not define 3 at all.</para>
/// </summary>
public sealed class QaSkidDefectTests
{
    private sealed class Factory : WebApplicationFactory<Program>
    {
        public string DbPath { get; } = Path.Combine(Path.GetTempPath(), $"abis_qadefect_{Guid.NewGuid():N}.db");
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
    /// Job 1001 carries three records: a salt-and-pepper scratch that ABCo sorted and customer 1153 released,
    /// a black-spot record with no customer decision yet, and one whose defect code is not in the plant's list.
    /// Customer 1459's record on job 1002 uses code 3, which 1459 does NOT define — only 1153 does.
    /// </summary>
    private static HttpClient Client(Factory f)
    {
        var c = f.CreateClient();
        c.DefaultRequestHeaders.Add("X-Api-Key", "test-key");
        Exec(f, """
            INSERT INTO qa_customer_quality_skid
                (customer_id, ab_job_num, coil_abc_num, sheet_skid_num, defect_code, albl_disp_code, cust_disp_code, qa_record_date, note, user_id)
            VALUES (1153, 1001, 5001, 3001, 3, 3, 3, '2026-04-02 09:00:00', 'sorted two skids', 'CBEAMER'),
                   (1153, 1001, 5001, 3002, 10, 4, NULL, '2026-04-01 09:00:00', 'awaiting customer', 'CBEAMER'),
                   (1153, 1001, 5002, 3003, 97, NULL, NULL, '2026-03-31 09:00:00', 'code not in the list', 'JLATIMORE'),
                   (1459, 1002, 5001, 3004, 1, 1, 3, '2026-04-03 09:00:00', 'other customer', 'CBEAMER');
            """);
        return c;
    }

    private static async Task<List<JsonElement>> Defects(HttpClient c, long job) =>
        (await c.GetFromJsonAsync<JsonElement>($"/api/quality/skid-defects?abJobNum={job}")).EnumerateArray().ToList();

    [Fact]
    public async Task Each_code_is_decoded_from_the_plants_own_lists()
    {
        using var f = new Factory();
        var rows = await Defects(Client(f), 1001);

        Assert.Equal(3, rows.Count);
        var newest = rows[0];                                   // newest record first
        Assert.Equal("Scratches - salt & pepper", newest.GetProperty("defectDesc").GetString());
        Assert.Equal("Sort defect", newest.GetProperty("alblDispDesc").GetString());
        Assert.Equal("OK to Release for shipment", newest.GetProperty("custDispDesc").GetString());
        Assert.Equal("CBEAMER", newest.GetProperty("userId").GetString());
    }

    /// <summary>Each customer keeps its own disposition list: 1459 never defines code 3, so nothing is shown
    /// for it — showing 1153's "OK to Release for shipment" there would be a different customer's decision.</summary>
    [Fact]
    public async Task A_customer_disposition_is_read_from_that_customers_own_list()
    {
        using var f = new Factory();
        var other = Assert.Single(await Defects(Client(f), 1002));

        Assert.Equal(1459, other.GetProperty("customerId").GetInt64());
        Assert.Equal(3, other.GetProperty("custDispCode").GetInt32());
        Assert.Equal(JsonValueKind.Null, other.GetProperty("custDispDesc").ValueKind);
        // ABCo's own list is shared across customers — and words it differently ("Flip and ship" vs the
        // customer lists' "Flip & ship"), which is itself a check that the two vocabularies are not confused.
        Assert.Equal("Flip and ship", other.GetProperty("alblDispDesc").GetString());
    }

    /// <summary>A defect code the plant does not list keeps its number and gains no invented description —
    /// and the record is still reported rather than dropped by the join.</summary>
    [Fact]
    public async Task An_unlisted_defect_code_is_still_reported_undecoded()
    {
        using var f = new Factory();
        var unlisted = (await Defects(Client(f), 1001)).Single(r => r.GetProperty("defectCode").GetInt32() == 97);

        Assert.Equal(JsonValueKind.Null, unlisted.GetProperty("defectDesc").ValueKind);
        Assert.Equal("code not in the list", unlisted.GetProperty("note").GetString());
    }

    [Fact]
    public async Task A_job_with_no_records_reports_none()
    {
        using var f = new Factory();

        Assert.Empty(await Defects(Client(f), 1003));
    }
}
