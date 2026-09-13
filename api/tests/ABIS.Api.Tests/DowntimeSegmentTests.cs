using System.Net;
using System.Net.Http.Json;
using System.Text.Json;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc.Testing;
using Xunit;

namespace Abis.Api.Tests;

/// <summary>Downtime cause-segments (dt_instance_detail): the DAS operator logs downtime WITH a
/// reason. Add a segment to an instance, read it back, and the guards (missing instance / cause).
///
/// <para><b>The column trap these pin.</b> On the live schema <c>INSTANCE_ITEM</c> is the segment's
/// position within its instance (PK <c>(instance_num, instance_item)</c>) and <c>ID</c> is the cause
/// (<c>FK_CAUSE_ID</c>) — which is how both legacy writers fill them. The port had them swapped: it
/// minted <c>ID</c> as <c>MAX(id)+1</c> (a cause that does not exist, so Oracle refused every reason)
/// and stored the cause in <c>INSTANCE_ITEM</c> (so the same cause twice on one instance collides).</para>
/// </summary>
public sealed class DowntimeSegmentTests
{
    private sealed class Factory : WebApplicationFactory<Program>
    {
        private readonly string _dbPath = Path.Combine(Path.GetTempPath(), $"abis_dtseg_{Guid.NewGuid():N}.db");
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

    private static async Task<long> NewInstance(HttpClient c)
    {
        var inst = await c.PostAsJsonAsync("/api/downtime", new { abJobNum = 1001, lineNum = 110 });
        return (await inst.Content.ReadFromJsonAsync<JsonElement>()).GetProperty("instanceNum").GetInt64();
    }

    [Fact]
    public async Task Add_a_reason_segment_to_a_downtime_instance()
    {
        using var f = new Factory();
        var c = Client(f);
        var instanceNum = await NewInstance(c);

        // Cause 2 ("Jam") rather than 1, so a cause echoed back as the segment's position cannot pass.
        var add = await c.PostAsJsonAsync($"/api/downtime/{instanceNum}/segments",
            new { causeId = 2, durationSeconds = 300.0, note = "belt jam" });
        Assert.Equal(HttpStatusCode.Created, add.StatusCode);
        var seg = await add.Content.ReadFromJsonAsync<JsonElement>();
        Assert.Equal(2, seg.GetProperty("causeId").GetInt64());
        Assert.Equal("Jam", seg.GetProperty("causeName").GetString());
        Assert.Equal(1, seg.GetProperty("instanceItem").GetInt32());            // first segment of the instance

        var list = await c.GetFromJsonAsync<JsonElement>($"/api/downtime/{instanceNum}/segments");
        Assert.Single(list.EnumerateArray());
        Assert.Equal(300.0, list.EnumerateArray().First().GetProperty("duration").GetDouble());
    }

    /// <summary>Segments are numbered 1..n within their instance, and one instance can carry the same cause
    /// twice (legacy's DAS panel logs one row per cause timer; a stop and a restart of the same reason is two).
    /// With the cause stored in the position column the second add collided on the primary key.</summary>
    [Fact]
    public async Task Segments_are_numbered_within_their_instance_and_a_cause_may_repeat()
    {
        using var f = new Factory();
        var c = Client(f);
        var instanceNum = await NewInstance(c);

        foreach (var (cause, secs) in new[] { (1, 120.0), (1, 60.0), (2, 30.0) })
            Assert.Equal(HttpStatusCode.Created,
                (await c.PostAsJsonAsync($"/api/downtime/{instanceNum}/segments", new { causeId = cause, durationSeconds = secs })).StatusCode);

        var list = (await c.GetFromJsonAsync<JsonElement>($"/api/downtime/{instanceNum}/segments")).EnumerateArray().ToList();
        Assert.Equal([1, 2, 3], list.Select(s => s.GetProperty("instanceItem").GetInt32()).ToList());
        Assert.Equal([1L, 1L, 2L], list.Select(s => s.GetProperty("causeId").GetInt64()).ToList());
        Assert.Equal(["Coil change", "Coil change", "Jam"], list.Select(s => s.GetProperty("causeName").GetString()).ToList());
    }

    /// <summary>On Oracle the cause column carries FK_CAUSE_ID, so an unknown cause must be refused as the
    /// caller's error — SQLite would otherwise store it and Oracle would answer with an ORA-02291.</summary>
    [Fact]
    public async Task An_unknown_cause_is_400()
    {
        using var f = new Factory();
        var c = Client(f);
        var instanceNum = await NewInstance(c);

        var resp = await c.PostAsJsonAsync($"/api/downtime/{instanceNum}/segments", new { causeId = 999, durationSeconds = 60.0 });
        Assert.Equal(HttpStatusCode.BadRequest, resp.StatusCode);
        Assert.Empty((await c.GetFromJsonAsync<JsonElement>($"/api/downtime/{instanceNum}/segments")).EnumerateArray());
    }

    [Fact]
    public async Task Segment_on_a_missing_instance_is_404()
    {
        using var f = new Factory();
        var resp = await Client(f).PostAsJsonAsync("/api/downtime/99999999/segments", new { causeId = 1, durationSeconds = 60.0 });
        Assert.Equal(HttpStatusCode.NotFound, resp.StatusCode);
    }

    [Fact]
    public async Task Segment_without_a_cause_is_400()
    {
        using var f = new Factory();
        var c = Client(f);
        var instanceNum = await NewInstance(c);
        var resp = await c.PostAsJsonAsync($"/api/downtime/{instanceNum}/segments", new { durationSeconds = 60.0 });
        Assert.Equal(HttpStatusCode.BadRequest, resp.StatusCode);
    }
}
