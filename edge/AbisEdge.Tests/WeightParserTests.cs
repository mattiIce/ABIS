using AbisEdge.Scales;
using Xunit;

namespace AbisEdge.Tests;

public class WeightParserTests
{
    [Theory]
    [InlineData("ST,GS,+00123.4 LB", 123.4, "LB", true, "GS")]
    [InlineData("US,NT,-0001.50 KG", -1.50, "KG", false, "NT")]
    [InlineData("ST,GS,1234.5 LB", 1234.5, "LB", true, "GS")]
    public void Parses_comma_delimited_continuous_format(string line, decimal value, string unit, bool stable, string mode)
    {
        var r = WeightParser.TryParse(line);
        Assert.NotNull(r);
        Assert.Equal(value, r!.Value);
        Assert.Equal(unit, r.Unit);
        Assert.Equal(stable, r.Stable);
        Assert.Equal(mode, r.Mode);
    }

    [Theory]
    [InlineData("+00123.4 LB", 123.4, "LB")]
    [InlineData("42KG", 42, "KG")]
    [InlineData("  7.25 g ", 7.25, "G")]
    public void Parses_bare_weight_and_assumes_stable(string line, decimal value, string unit)
    {
        var r = WeightParser.TryParse(line);
        Assert.NotNull(r);
        Assert.Equal(value, r!.Value);
        Assert.Equal(unit, r.Unit);
        Assert.True(r.Stable);   // bare readings are treated as settled
        Assert.Null(r.Mode);
    }

    [Theory]
    [InlineData(null)]
    [InlineData("")]
    [InlineData("   ")]
    [InlineData("ST,GS,")]           // no weight
    [InlineData("garbage line")]     // no number+unit
    public void Returns_null_for_unparseable_input(string? line)
    {
        Assert.Null(WeightParser.TryParse(line));
    }

    [Fact]
    public void Preserves_the_raw_line()
    {
        const string line = "ST,GS,+00123.4 LB";
        Assert.Equal(line, WeightParser.TryParse(line)!.Raw);
    }

    [Fact]
    public async Task MockScale_streams_parseable_readings()
    {
        var scale = new MockScale(setpoint: 100m, unit: "LB", intervalMs: 1);
        using var cts = new CancellationTokenSource();
        var count = 0;
        await foreach (var r in scale.ReadAsync(cts.Token))
        {
            Assert.Equal("LB", r.Unit);
            Assert.True(r.Value is > 90m and < 110m);
            if (++count >= 4) cts.Cancel();
        }
        Assert.True(count >= 4);
    }
}
