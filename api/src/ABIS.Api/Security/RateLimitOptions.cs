namespace Abis.Api.Security;

/// <summary>Bound from the "RateLimiting" configuration section. Protects the
/// legacy database behind the seam from runaway clients with a fixed-window
/// limiter, partitioned per API key (falling back to remote IP).</summary>
public sealed class RateLimitOptions
{
    public const string SectionName = "RateLimiting";

    /// <summary>The named policy applied to the <c>/api</c> group.</summary>
    public const string PolicyName = "api";

    /// <summary>When false, the limiter middleware is left out of the pipeline.</summary>
    public bool Enabled { get; set; } = true;

    /// <summary>Requests permitted per window per partition. Default is generous;
    /// tune down for production exposure.</summary>
    public int PermitLimit { get; set; } = 1000;

    /// <summary>Window length in seconds.</summary>
    public int WindowSeconds { get; set; } = 10;
}
