namespace AbisEdge.Scales;

/// <summary>A shop-floor weigh device. Implementations stream readings until the
/// token is cancelled. The transport (serial, mock, …) is hidden behind this so
/// the rest of the edge service is hardware-agnostic and testable.</summary>
public interface IScale
{
    /// <summary>A human label for the device (shown in /health and logs).</summary>
    string Name { get; }

    /// <summary>Stream readings as the device reports them.</summary>
    IAsyncEnumerable<WeightReading> ReadAsync(CancellationToken ct);
}
