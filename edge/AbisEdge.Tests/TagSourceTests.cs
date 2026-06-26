using AbisEdge.Tags;
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
    public void OpcUaTagSource_is_a_scaffold_until_the_client_is_wired()
    {
        var src = new OpcUaTagSource("opc.tcp://plc.local:4840");
        Assert.StartsWith("opc-ua", src.Name);
        var ex = Assert.ThrowsAsync<NotSupportedException>(() =>
            src.ReadAsync(new[] { "ns=2;s=X" }, CancellationToken.None));
        Assert.Contains("scaffold", ex.Result.Message);
    }
}
