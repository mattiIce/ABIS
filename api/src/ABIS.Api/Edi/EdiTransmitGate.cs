using Microsoft.Extensions.Logging;

namespace Abis.Api.Edi;

/// <summary>The valve plus every armed partner/type pair — the whole transmit policy in one snapshot.</summary>
/// <param name="ValveOpen">The master switch. False stops everything, whatever is armed.</param>
/// <param name="Armed">The (transactionType, customerId) pairs allowed through when the valve is open.</param>
public sealed record EdiTransmitPolicy(bool ValveOpen, IReadOnlySet<(string Type, long CustomerId)> Armed)
{
    /// <summary>The state this ships in and spends most of its life in.</summary>
    public static EdiTransmitPolicy Closed { get; } =
        new(false, new HashSet<(string, long)>());

    public bool Allows(string transactionType, long? customerId) =>
        ValveOpen
        && customerId is { } id
        && Armed.Contains((transactionType.Trim().ToUpperInvariant(), id));
}

/// <summary>
/// Decides whether a generated document may leave the building.
///
/// <para><b>Two gates, ANDed, because they answer different questions.</b> The valve is the right shape
/// for OFF — one switch, no reasoning about partners, which is what you want in a hurry. Per-partner
/// arming is the right shape for ON, because legacy still transmits Novelis 861, Aleris 861 and Aleris
/// 870: opening the valve globally would send those twice, and trading partners reconcile receipts and
/// invoices off them.</para>
///
/// <para><b>Everything fails closed.</b> An unreadable policy, a missing arm row, a customer we cannot
/// identify — all mean "do not transmit". The cost of a false stop is a document sitting in the
/// database where somebody can see it; the cost of a false go is a duplicate at a trading partner,
/// which cannot be recalled.</para>
/// </summary>
public interface IEdiTransmitGate
{
    Task<EdiTransmitPolicy> GetPolicyAsync(CancellationToken ct);
}

/// <summary>
/// The gate used when nothing has provisioned the policy tables — it refuses everything.
///
/// <para>This is not a placeholder to be filled in later. It is what runs on any schema without
/// migration 011, and refusing is the correct answer there: a database that cannot state a transmit
/// policy has not authorised one.</para>
/// </summary>
public sealed class ClosedEdiTransmitGate(ILogger<ClosedEdiTransmitGate> log) : IEdiTransmitGate
{
    public Task<EdiTransmitPolicy> GetPolicyAsync(CancellationToken ct)
    {
        log.LogDebug("EDI transmit policy unavailable; treating the valve as closed.");
        return Task.FromResult(EdiTransmitPolicy.Closed);
    }
}
