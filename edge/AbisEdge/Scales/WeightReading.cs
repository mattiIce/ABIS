namespace AbisEdge.Scales;

/// <summary>One parsed weight reading from a shop-floor scale.</summary>
/// <param name="Value">Numeric weight in <see cref="Unit"/>.</param>
/// <param name="Unit">Unit of measure as reported by the scale (e.g. "LB", "KG").</param>
/// <param name="Stable">True when the scale reports a stable (settled) reading.</param>
/// <param name="Mode">Gross/net mode token if present ("GS"/"NT"), else null.</param>
/// <param name="Raw">The raw line the scale sent (for diagnostics/audit).</param>
public sealed record WeightReading(decimal Value, string Unit, bool Stable, string? Mode, string Raw)
{
    public DateTimeOffset At { get; init; }
}
