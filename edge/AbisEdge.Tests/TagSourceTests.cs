using AbisEdge.Tags;
using Microsoft.Extensions.Logging.Abstractions;
using Xunit;

namespace AbisEdge.Tests;

public class TagSourceTests
{
    [Fact]
    public async Task MockTagSource_returns_a_good_reading_per_requested_tag()
    {
        var src = new MockTagSource();
        var tags = new[] { "ns=2;s=Line1.Status", "ns=2;s=Line1.PartCount", "ns=2;s=Oven.Temp" };
        var readings = await src.ReadAsync(tags, CancellationToken.None);

        Assert.Equal(tags.Length, readings.Count);
        Assert.Equal(tags, readings.Select(r => r.Name));
        Assert.All(readings, r => Assert.Equal("Good", r.Quality));
        Assert.All(readings, r => Assert.NotNull(r.Value));
    }

    [Fact]
    public async Task MockTagSource_simulates_by_tag_name()
    {
        var src = new MockTagSource();
        var r = await src.ReadAsync(new[] { "Line1.Status", "Line1.Count", "Oven.Temp" }, CancellationToken.None);
        Assert.Contains(r[0].Value, new[] { "RUNNING", "DOWN" });
        Assert.True(int.TryParse(r[1].Value, out _));         // count is numeric
        Assert.Contains(".", r[2].Value!);                    // temp is a decimal
    }

    [Fact]
    public async Task MockTagSource_advances_each_read()
    {
        var src = new MockTagSource();
        var a = (await src.ReadAsync(new[] { "X.Count" }, CancellationToken.None))[0].Value;
        var b = (await src.ReadAsync(new[] { "X.Count" }, CancellationToken.None))[0].Value;
        Assert.NotEqual(a, b);
    }

    [Fact]
    public async Task OpcUaTagSource_returns_Bad_readings_when_the_server_is_unreachable()
    {
        // Resilience contract: a failed connect must yield Bad readings (one per tag),
        // not throw — so the tag pump and /health stay up and the fault shows in /tags.
        var pki = Path.Combine(Path.GetTempPath(), "abis_opc_pki_" + Guid.NewGuid().ToString("N"));
        await using var src = new OpcUaTagSource(
            new OpcUaOptions("opc.tcp://127.0.0.1:1") { DiscoveryTimeoutMs = 3000, PkiRoot = pki },
            NullLogger<OpcUaTagSource>.Instance);

        Assert.StartsWith("opc-ua", src.Name);

        var tags = new[] { "ns=2;s=X", "ns=2;s=Y" };
        var readings = await src.ReadAsync(tags, CancellationToken.None);

        Assert.Equal(tags.Length, readings.Count);
        Assert.Equal(tags, readings.Select(r => r.Name));
        Assert.All(readings, r => Assert.Equal("Bad", r.Quality));
        Assert.All(readings, r => Assert.Null(r.Value));

        try { Directory.Delete(pki, true); } catch { /* best effort */ }
    }
}
