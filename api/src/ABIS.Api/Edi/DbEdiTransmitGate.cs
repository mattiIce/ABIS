using Abis.Api.Data;
using Dapper;
using Microsoft.Extensions.Logging;

namespace Abis.Api.Edi;

/// <summary>
/// Reads the transmit policy from <c>ABIS_EDI_TRANSMIT_STATE</c> and <c>ABIS_EDI_TRANSMIT_ARM</c>
/// (migration 011).
///
/// <para><b>Read every time, never cached.</b> Closing the valve has to take effect on the next
/// document, not on the next cache expiry — the whole point of a master switch is that it works when
/// somebody is in a hurry. Documents are generated a handful of times a day, so the read costs nothing
/// worth optimising.</para>
///
/// <para><b>Any failure means closed.</b> Tables absent (no migration 011), database unreachable, row
/// missing, column renamed — all produce <see cref="EdiTransmitPolicy.Closed"/>. An unreadable policy
/// is not an authorisation, and the asymmetry is stark: a false stop leaves a document in the database
/// where somebody can see it and re-send it; a false go puts a duplicate in front of a trading partner,
/// where it cannot be recalled.</para>
/// </summary>
public sealed class DbEdiTransmitGate(IDbConnectionFactory factory, ILogger<DbEdiTransmitGate> log)
    : IEdiTransmitGate
{
    private sealed class StateRow { public int ValveOpen { get; set; } }
    private sealed class ArmRow { public string? TransactionType { get; set; } public long CustomerId { get; set; } }

    public async Task<EdiTransmitPolicy> GetPolicyAsync(CancellationToken ct)
    {
        try
        {
            await using var conn = factory.Create();
            await conn.OpenAsync(ct);

            var state = await conn.QuerySingleOrDefaultAsync<StateRow>(new CommandDefinition(
                "SELECT valve_open AS ValveOpen FROM abis_edi_transmit_state WHERE state_id = 1",
                cancellationToken: ct));

            // No row is not "open by default" — it is a policy that was never stated.
            if (state is null || state.ValveOpen != 1) return EdiTransmitPolicy.Closed;

            var arms = await conn.QueryAsync<ArmRow>(new CommandDefinition(
                "SELECT transaction_type AS TransactionType, customer_id AS CustomerId "
                + "FROM abis_edi_transmit_arm WHERE armed = 1",
                cancellationToken: ct));

            // TRIM + upper: transaction_type is CHAR-padded on Oracle, so a bare comparison against
            // '861' would never match the stored '861       '.
            var set = new HashSet<(string, long)>();
            foreach (var a in arms)
            {
                var t = (a.TransactionType ?? "").Trim().ToUpperInvariant();
                if (t.Length > 0) set.Add((t, a.CustomerId));
            }

            return new EdiTransmitPolicy(true, set);
        }
        catch (Exception ex)
        {
            log.LogError(ex, "Could not read the EDI transmit policy; treating the valve as CLOSED. "
                           + "Nothing will be transmitted until this is readable.");
            return EdiTransmitPolicy.Closed;
        }
    }
}
