using System.Net;
using System.Net.Http.Json;
using System.Text.Json;
using Abis.Api.Data.WinSpc;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.AspNetCore.TestHost;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.DependencyInjection.Extensions;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>
/// A dimensional check must carry a verdict — from the inspector or from WinSPC.
///
/// <para><b>The hole.</b> <c>in_spec</c> is NOT NULL, and the repository filled an omitted value with
/// 1. So a check posted without a verdict was stored as a PASS that nobody recorded. The UI always sends
/// one; any other caller could not.</para>
///
/// <para><b>Why the check sits after the WinSPC gate.</b> When WinSPC is configured and holds spec limits
/// for the skid's job, the gate decides <c>in_spec</c> itself. Requiring the client to send a verdict up
/// front would reject every check WinSPC was about to decide. These tests pin that placement: moving the
/// check before the gate turns <see cref="A_check_WinSPC_can_decide_needs_no_inspector_verdict"/> red,
/// while the no-verdict case in <c>ApiSmokeTests</c> would still pass — so it could not catch it alone.</para>
///
/// <para><b>Legacy never computed the verdict.</b> <c>in_spec</c> is a plain checkbox in both vendored
/// DataWindows, with no tolerance expression; all 275 checks on <c>.230</c> are recorded as pass. WinSPC
/// is the only source of a computed verdict in either system.</para>
/// </summary>
public sealed class DimensionCheckVerdictTests
{
    private const string Url = "/api/coil-eval/skids/3001/dimension-checks";   // seeded skid 3001 → job 1001

    /// <summary>WinSPC with one characteristic: width, spec [48, 49], for job 1001 only.</summary>
    private sealed class FakeWinSpc : IWinSpcRepository
    {
        public bool Enabled => true;
        public Task<string?> CheckAsync(CancellationToken ct) => Task.FromResult<string?>(null);
        public Task<WinSpcQc?> GetCoilQcAsync(string coilNumber, CancellationToken ct) => Task.FromResult<WinSpcQc?>(null);
        public Task<WinSpcQc?> GetJobQcAsync(string jobNumber, CancellationToken ct) =>
            Task.FromResult<WinSpcQc?>(jobNumber != "1001" ? null : new WinSpcQc
            {
                Key = jobNumber,
                KeyKind = "job",
                TotalReadings = 1,
                Readings = [new WinSpcReading { Characteristic = "Width", Dimension = "width", Reading = 48.5, Lsl = 48, Usl = 49 }],
            });
    }

    private sealed class Factory : WebApplicationFactory<Program>
    {
        private readonly string _dbPath = Path.Combine(Path.GetTempPath(), $"abis_dimcheck_{Guid.NewGuid():N}.db");
        protected override void ConfigureWebHost(IWebHostBuilder builder)
        {
            builder.UseEnvironment("Development");
            builder.UseSetting("Database:Provider", "Sqlite");
            builder.UseSetting("Database:ConnectionString", $"Data Source={_dbPath}");
            builder.UseSetting("Database:Seed", "true");
            builder.UseSetting("ApiKeys:Enabled", "true");
            builder.UseSetting("ApiKeys:Keys:0", "test-key");
            builder.ConfigureTestServices(s =>
            {
                s.RemoveAll<IWinSpcRepository>();
                s.AddScoped<IWinSpcRepository, FakeWinSpc>();
            });
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

    [Fact]
    public async Task A_check_WinSPC_can_decide_needs_no_inspector_verdict()
    {
        using var f = new Factory();
        var c = Client(f);

        var r = await c.PostAsJsonAsync(Url, new { checkedBy = "qc", pcNumber = 7, width = 48.5 });

        Assert.Equal(HttpStatusCode.Created, r.StatusCode);
        var body = await r.Content.ReadFromJsonAsync<JsonElement>();
        Assert.Equal(1, body.GetProperty("inSpec").GetInt32());
        Assert.Contains("WinSPC", body.GetProperty("note").GetString());
    }

    /// <summary>The decided verdict is honoured in both directions — a fail is not softened to a pass.</summary>
    [Fact]
    public async Task WinSPC_out_of_spec_is_recorded_as_a_fail()
    {
        using var f = new Factory();
        var c = Client(f);

        var r = await c.PostAsJsonAsync(Url, new { checkedBy = "qc", pcNumber = 8, width = 50.0 });

        Assert.Equal(HttpStatusCode.Created, r.StatusCode);
        var body = await r.Content.ReadFromJsonAsync<JsonElement>();
        Assert.Equal(0, body.GetProperty("inSpec").GetInt32());
    }

    /// <summary>
    /// WinSPC is on and has readings for the job, but nothing that was measured is a characteristic it
    /// holds limits for — so it cannot decide, and the inspector still must. This is the case that proves
    /// "WinSPC is configured" is not treated as "a verdict exists".
    /// </summary>
    [Fact]
    public async Task A_check_WinSPC_cannot_decide_still_needs_a_verdict()
    {
        using var f = new Factory();
        var c = Client(f);

        var r = await c.PostAsJsonAsync(Url, new { checkedBy = "qc", pcNumber = 9, gauge = 0.125 });

        Assert.Equal(HttpStatusCode.BadRequest, r.StatusCode);
        Assert.Contains("inSpec", await r.Content.ReadAsStringAsync());
    }
}
