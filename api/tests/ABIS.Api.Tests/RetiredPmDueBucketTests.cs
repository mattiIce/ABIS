using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// A retired PM is never overdue.
///
/// <para><b>What went wrong.</b> On 2026-08-21 the 77 pre-KeepTrak PM definitions were retired
/// (<c>pm_status = 0</c>) precisely so they would stop demanding attention — their due dates are from
/// 2010 and they would otherwise show as ~5,800 days overdue, swamping the 144 real ones. The retire
/// worked. But <c>StampDue</c> computed the bucket from <c>nextduedate</c> alone, so the PM list went
/// on painting them <b>overdue</b> against their 2010 dates.</para>
///
/// <para>A user saw that and reasonably concluded the retire had not worked. It had; the label was
/// lying — the same family as the 403 that read "an unexpected server error" and the certificate
/// failure that read "wrong password". <b>The system knew the truth and reported something else.</b></para>
///
/// <para>Fixed at the source rather than in the page, so the due board, the PM list and the export
/// cannot disagree about the same row — which is why this test drives the API, not a formatter.</para>
/// </summary>
public sealed class RetiredPmDueBucketTests
{
    private sealed class Factory : WebApplicationFactory<Program>
    {
        private readonly string _dbPath = Path.Combine(Path.GetTempPath(), $"abis_retpm_{Guid.NewGuid():N}.db");
        protected override void ConfigureWebHost(IWebHostBuilder builder)
        {
            builder.UseEnvironment("Development");
            builder.UseSetting("Database:Provider", "Sqlite");
            builder.UseSetting("Database:ConnectionString", $"Data Source={_dbPath}");
            builder.UseSetting("Database:Seed", "true");
            builder.UseSetting("ApiKeys:Enabled", "true");
            builder.UseSetting("ApiKeys:Keys:0", "test-key");
        }
        protected override void Dispose(bool disposing)
        {
            base.Dispose(disposing);
            try { if (File.Exists(_dbPath)) File.Delete(_dbPath); } catch { /* best effort */ }
        }
    }

    private static HttpClient Client(WebApplicationFactory<Program> f)
    {
        var c = f.CreateClient();
        c.DefaultRequestHeaders.Add("X-Api-Key", "test-key");
        return c;
    }

    private static async Task<List<(long PmId, int Status, string Bucket)>> PmsAsync(HttpClient c, string query = "")
    {
        var body = await c.GetFromJsonAsync<JsonElement>($"/api/pms?pageSize=200{query}");
        var rows = new List<(long, int, string)>();
        foreach (var p in body.GetProperty("items").EnumerateArray())
        {
            rows.Add((
                p.GetProperty("pmId").GetInt64(),
                p.TryGetProperty("pmStatus", out var st) && st.ValueKind == JsonValueKind.Number ? st.GetInt32() : -1,
                p.TryGetProperty("dueBucket", out var b) ? b.GetString() ?? "" : ""));
        }
        return rows;
    }

    /// <summary>The exact defect: a retired PM with a long-past due date must not read as overdue.</summary>
    [Fact]
    public async Task A_retired_PM_is_never_bucketed_overdue()
    {
        using var f = new Factory();
        var retired = (await PmsAsync(Client(f))).Where(r => r.Status == 0).ToList();

        Assert.NotEmpty(retired);   // otherwise this test proves nothing
        Assert.DoesNotContain(retired, r => r.Bucket == "overdue");
    }

    /// <summary>It says what it IS, rather than falling back to a vague blank.</summary>
    [Fact]
    public async Task A_retired_PM_is_bucketed_retired()
    {
        using var f = new Factory();
        var retired = (await PmsAsync(Client(f))).Where(r => r.Status == 0).ToList();

        Assert.NotEmpty(retired);
        Assert.All(retired, r => Assert.Equal("retired", r.Bucket));
    }

    /// <summary>
    /// The fix must not silence a genuinely overdue ACTIVE PM — that is the whole point of the board.
    /// </summary>
    [Fact]
    public async Task An_active_PM_still_reports_its_real_due_state()
    {
        using var f = new Factory();
        var active = (await PmsAsync(Client(f))).Where(r => r.Status != 0).ToList();

        Assert.NotEmpty(active);
        Assert.All(active, r => Assert.NotEqual("retired", r.Bucket));
        // and the ordinary vocabulary is still in use
        Assert.All(active, r => Assert.Contains(r.Bucket, new[] { "overdue", "due", "scheduled", "undated" }));
    }

    /// <summary>
    /// Filtering by status must still work — the PM list now defaults to active, and that default is
    /// worthless if the filter does not actually exclude the retired rows.
    /// </summary>
    [Fact]
    public async Task Filtering_to_active_excludes_the_retired_ones()
    {
        using var f = new Factory();
        var activeOnly = await PmsAsync(Client(f), "&pmStatus=1");

        Assert.NotEmpty(activeOnly);
        Assert.DoesNotContain(activeOnly, r => r.Status == 0);
        Assert.DoesNotContain(activeOnly, r => r.Bucket == "retired");
    }
}
