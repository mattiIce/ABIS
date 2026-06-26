using System.Globalization;
using System.Text.RegularExpressions;

namespace AbisEdge.Scales;

/// <summary>
/// Parses a line of ASCII a weigh scale emits over serial into a
/// <see cref="WeightReading"/>. Covers the common comma-delimited continuous
/// format used by Toledo/Mettler-style indicators —
/// <c>&lt;status&gt;,&lt;mode&gt;,&lt;signed weight&gt;&lt;unit&gt;</c>,
/// e.g. <c>ST,GS,+00123.4 LB</c> — and the bare <c>+00123.4 LB</c> form.
///
/// This is the pure, hardware-free core of the edge service, so it is fully
/// unit-tested; the serial transport (<see cref="SerialScale"/>) just feeds it
/// lines. Replaces the per-device string fiddling that lived in the legacy
/// PowerBuilder <c>da</c> object's WSC32 reads.
/// </summary>
public static class WeightParser
{
    // A signed/optional-decimal number followed by an alpha unit (LB, KG, G, ...).
    private static readonly Regex WeightUnit = new(
        @"(?<num>[-+]?\d+(?:\.\d+)?)\s*(?<unit>[A-Za-z]+)",
        RegexOptions.Compiled | RegexOptions.CultureInvariant);

    /// <summary>Parses one line; returns null if no weight could be read.</summary>
    public static WeightReading? TryParse(string? line)
    {
        if (string.IsNullOrWhiteSpace(line)) return null;
        var raw = line.Trim();

        bool? stable = null;
        string? mode = null;
        var weightPart = raw;

        // Comma-delimited form: leading status + mode tokens precede the weight.
        var parts = raw.Split(',');
        if (parts.Length >= 3)
        {
            var status = parts[0].Trim().ToUpperInvariant();
            if (status is "ST" or "US") stable = status == "ST";
            var m = parts[1].Trim().ToUpperInvariant();
            if (m is "GS" or "NT") mode = m;
            weightPart = parts[^1];
        }

        var match = WeightUnit.Match(weightPart);
        if (!match.Success) return null;
        if (!decimal.TryParse(match.Groups["num"].Value, NumberStyles.Number,
                CultureInfo.InvariantCulture, out var value))
            return null;

        return new WeightReading(
            value,
            match.Groups["unit"].Value.ToUpperInvariant(),
            stable ?? true,            // bare readings are assumed settled
            mode,
            raw);
    }
}
