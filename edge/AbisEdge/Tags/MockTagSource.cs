namespace AbisEdge.Tags;

/// <summary>A simulated PLC so the edge service's OPC path runs and is testable
/// with no server — returns plausible values keyed off the tag name (status /
/// count / temperature), with a counter that advances each read. Select it with
/// <c>Edge:Opc:Provider=Mock</c> (the default).</summary>
public sealed class MockTagSource : ITagSource
{
    private int _counter;

    public string Name => "mock-opc";

    public Task<IReadOnlyList<TagReading>> ReadAsync(IReadOnlyList<string> tags, CancellationToken ct)
    {
        var now = DateTimeOffset.UtcNow;
        var n = Interlocked.Increment(ref _counter);
        IReadOnlyList<TagReading> readings = tags
            .Select(t => new TagReading(t, Simulate(t, n), "Good") { At = now })
            .ToList();
        return Task.FromResult(readings);
    }

    private static string Simulate(string tag, int n)
    {
        var t = tag.ToLowerInvariant();
        if (t.Contains("status")) return n % 10 == 0 ? "DOWN" : "RUNNING";
        if (t.Contains("count")) return n.ToString();
        if (t.Contains("temp")) return (70 + (n % 8) * 0.5m).ToString("0.0");
        if (t.Contains("speed")) return (100 + (n % 20)).ToString();
        return (n % 2).ToString();
    }
}
