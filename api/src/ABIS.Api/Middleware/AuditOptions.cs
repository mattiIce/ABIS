namespace Abis.Api.Middleware;

/// <summary>Bound from the "Audit" configuration section.</summary>
public sealed class AuditOptions
{
    public const string SectionName = "Audit";

    /// <summary>When true (default), mutating requests are recorded to the audit
    /// table. Set false when the target database has no compatible audit table
    /// (e.g. the live ABIS/DBO schema has no <c>opc_action_log</c> — see
    /// docs/ORACLE_VALIDATION.md), to avoid a per-request write attempt.</summary>
    public bool Enabled { get; set; } = true;
}
