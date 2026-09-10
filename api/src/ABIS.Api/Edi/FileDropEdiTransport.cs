using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;

namespace Abis.Api.Edi;

/// <summary>Where a document is dropped for the VAN, and nothing else.</summary>
public sealed class EdiOutboxOptions
{
    /// <summary>
    /// The directory <c>GXS.ksh</c> collects from — legacy's is
    /// <c>/templar/templar/incoming/senddata/</c> on the DB host, so on a separate app host this is a
    /// mount of it. Empty (the default) means no outbox is configured and nothing can be written.
    /// </summary>
    public string Path { get; set; } = "";
}

/// <summary>
/// Hands a generated interchange to legacy's existing VAN transport by writing it into the outbox
/// directory — and <b>deliberately does not speak SFTP</b>.
///
/// <para><b>Why a file and not a client.</b> Legacy's transmit is directory-driven: <c>GXS.ksh</c> runs
/// an SFTP batch that does <c>lcd /templar/templar/incoming/senddata/</c> then <c>mput S*.edi</c>, and
/// on success moves what it sent to <c>ToVan_Bkup/</c>. Writing a file into that directory is therefore
/// a complete transmit path. Three things follow, all of them safety properties:</para>
/// <list type="bullet">
///   <item>The VAN login (<c>412992496</c>) and its key stay on the DB host. ABIS never holds a
///   credential that can reach a trading partner.</item>
///   <item>Transmission stays SINGLE-OWNER. Exactly one process opens an SFTP session to Inovis, which
///   is the property the no-live-firing rule exists to protect.</item>
///   <item>It is reversible for as long as the cron has not run. A file can be deleted from a
///   directory; an interchange cannot be recalled from a VAN.</item>
/// </list>
///
/// <para><b>The directory must already exist.</b> If the outbox is a mount and the mount is down,
/// creating it would silently accumulate documents in a local directory nobody collects — the failure
/// would look like success for as long as it took someone to notice a partner had stopped receiving.
/// So a missing directory is refused, never created.</para>
/// </summary>
public sealed class FileDropEdiTransport(
    IEdiTransmitGate gate,
    IOptions<EdiOutboxOptions> options,
    ILogger<FileDropEdiTransport> log) : IEdiTransport
{
    public async Task<EdiTransportResult> SendAsync(
        string fileName, string partner, string payload, CancellationToken ct) =>
        await SendAsync(fileName, partner, payload, transactionType: "", customerId: null, ct);

    /// <summary>
    /// The real entry point. <paramref name="transactionType"/> and <paramref name="customerId"/> are
    /// what the gate decides on — a caller that cannot supply them cannot be authorised, which is why
    /// the interface overload above always refuses.
    /// </summary>
    public async Task<EdiTransportResult> SendAsync(
        string fileName, string partner, string payload,
        string transactionType, long? customerId, CancellationToken ct)
    {
        var policy = await gate.GetPolicyAsync(ct);

        if (!policy.ValveOpen)
        {
            log.LogInformation(
                "EDI generated, NOT transmitted (valve closed): {File} → {Partner}, {Bytes} bytes.",
                fileName, partner, payload.Length);
            return new EdiTransportResult(false,
                $"Generated {payload.Length} bytes for {partner} — held. EDI transmission is switched off.");
        }

        if (!policy.Allows(transactionType, customerId))
        {
            // The valve is open but this pair is not armed. Worth saying precisely which pair, because
            // the usual cause is somebody expecting one switch to cover every partner.
            log.LogInformation(
                "EDI generated, NOT transmitted (not armed): {Type} for customer {Customer} ({Partner}), {File}.",
                transactionType, customerId, partner, fileName);
            return new EdiTransportResult(false,
                $"Generated {payload.Length} bytes for {partner} — held. Transmission is on, but "
                + $"{(string.IsNullOrWhiteSpace(transactionType) ? "this document" : transactionType)} "
                + $"is not armed for this customer.");
        }

        var dir = options.Value.Path?.Trim() ?? "";
        if (dir.Length == 0)
        {
            log.LogError("EDI transmit is armed for {Type}/{Customer} but no outbox is configured "
                       + "(Edi:Outbox:Path); refusing to transmit.", transactionType, customerId);
            return new EdiTransportResult(false,
                $"Generated {payload.Length} bytes for {partner} — held. Transmission is armed but no VAN "
                + "outbox directory is configured.");
        }

        if (!Directory.Exists(dir))
        {
            // Never create it. See the class note: a down mount would turn a transmit into a silent
            // local pile-up that looks like success.
            log.LogError("EDI outbox {Dir} does not exist; refusing to transmit {File}. If it is a mount, "
                       + "it is probably down — documents are held, not lost.", dir, fileName);
            return new EdiTransportResult(false,
                $"Generated {payload.Length} bytes for {partner} — held. The VAN outbox directory is not "
                + "reachable.");
        }

        var safe = SafeFileName(fileName);
        var full = Path.Combine(dir, safe);
        if (File.Exists(full))
        {
            // The cron moves what it sends, so a name still present is one it has not collected. Writing
            // over it would replace a document that is on its way out.
            log.LogWarning("EDI outbox already holds {File}; refusing to overwrite an uncollected document.", safe);
            return new EdiTransportResult(false,
                $"Held — the VAN outbox already contains {safe}, which has not been collected yet.");
        }

        await File.WriteAllTextAsync(full, payload, ct);
        log.LogWarning(
            "EDI TRANSMITTED: wrote {File} ({Bytes} bytes) to the VAN outbox for {Partner} ({Type}/{Customer}). "
            + "The legacy GXS cron will collect it.", safe, payload.Length, partner, transactionType, customerId);
        return new EdiTransportResult(true,
            $"Written to the VAN outbox as {safe} ({payload.Length} bytes). The GXS cron transmits it.");
    }

    /// <summary>
    /// Keep the name to a bare `S*.edi` — that pattern is what <c>GXS.ksh</c>'s <c>mput</c> matches and
    /// what its backup step moves, so a name outside it would be written and then never collected or
    /// cleaned up. Any path separator is stripped rather than escaped: a generated name should never be
    /// steering where the file lands.
    /// </summary>
    internal static string SafeFileName(string fileName)
    {
        var name = Path.GetFileName(fileName?.Trim() ?? "");
        foreach (var c in Path.GetInvalidFileNameChars()) name = name.Replace(c, '_');
        if (name.Length == 0) name = "S_unnamed.edi";
        if (!name.StartsWith('S')) name = "S" + name;
        if (!name.EndsWith(".edi", StringComparison.OrdinalIgnoreCase)) name += ".edi";
        return name;
    }
}
