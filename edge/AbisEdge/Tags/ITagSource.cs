namespace AbisEdge.Tags;

/// <summary>A source of PLC/line-equipment tag values (OPC, or a mock). Hidden
/// behind this interface so the rest of the edge service is OPC-library- and
/// hardware-agnostic, and so the mock can drive tests with no server.</summary>
public interface ITagSource
{
    /// <summary>A human label for the source (shown in /health and logs).</summary>
    string Name { get; }

    /// <summary>Read the current value of each requested tag. Implementations
    /// return a <see cref="TagReading"/> per requested tag (with <c>Bad</c>
    /// quality for any that couldn't be read), in the same order.</summary>
    Task<IReadOnlyList<TagReading>> ReadAsync(IReadOnlyList<string> tags, CancellationToken ct);
}
