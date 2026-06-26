namespace AbisEdge.Tags;

/// <summary>One value read from a PLC/line-equipment tag via OPC.</summary>
/// <param name="Name">The tag/node id (e.g. <c>ns=2;s=Line1.Status</c>).</param>
/// <param name="Value">The value as a string (OPC values are loosely typed; the
/// caller knows the tag's meaning). Null when the read failed.</param>
/// <param name="Quality">OPC quality: <c>Good</c> / <c>Bad</c> / <c>Uncertain</c>.</param>
public sealed record TagReading(string Name, string? Value, string Quality)
{
    public DateTimeOffset At { get; init; }

    public static TagReading Bad(string name) => new(name, null, "Bad") { At = DateTimeOffset.UtcNow };
}
