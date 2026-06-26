using Opc.Ua;
using Opc.Ua.Client;
using Opc.Ua.Configuration;

namespace AbisEdge.Tags;

/// <summary>Connection settings for <see cref="OpcUaTagSource"/>, from
/// <c>Edge:Opc:*</c>. For the INGEAR-via-UA-wrapper setup, start with
/// <see cref="UseSecurity"/>=false + anonymous (the wrapper is on the trusted plant
/// LAN), then tighten to a signed/encrypted policy + a trusted client cert.</summary>
public sealed record OpcUaOptions(string Endpoint)
{
    public bool UseSecurity { get; init; }
    public bool AcceptUntrusted { get; init; } = true;     // auto-accept the server cert (LAN/dev)
    public string? Username { get; init; }
    public string? Password { get; init; }
    public int SessionTimeoutMs { get; init; } = 60_000;
    public int DiscoveryTimeoutMs { get; init; } = 10_000; // bound the connect/endpoint-select
    public string PkiRoot { get; init; } = "pki";          // where the client's app cert is stored
}

/// <summary>A node discovered by browsing — used by <c>/opc/browse</c> to find the
/// wrapper's tag node ids without hand-mapping them.</summary>
public sealed record BrowsedNode(string NodeId, string DisplayName, string NodeClass);

/// <summary>Browse the server's address space (only the OPC UA source supports it).</summary>
public interface ITagBrowser
{
    Task<IReadOnlyList<BrowsedNode>> BrowseAsync(string? nodeId, CancellationToken ct);
}

/// <summary>OPC UA tag source — the real shop-floor reader. Keeps one connected
/// <see cref="Session"/> (lazily created, re-established on drop) and serves reads
/// from it. Designed for the <b>INGEAR → UA-wrapper</b> path: the wrapper exposes
/// the Classic-DA address space as UA, and this connects over <c>opc.tcp</c>.
///
/// Resilient by design: any connect/read failure yields <c>Bad</c>-quality readings
/// (and a log line) instead of throwing, so the tag pump and <c>/health</c> stay up
/// and the fault is observable in <c>/tags</c>. Select with
/// <c>Edge:Opc:Provider=OpcUa</c> + <c>Edge:Opc:Endpoint=opc.tcp://host:4840</c>.</summary>
public sealed class OpcUaTagSource : ITagSource, ITagBrowser, IAsyncDisposable
{
    private readonly OpcUaOptions _opt;
    private readonly ILogger<OpcUaTagSource> _log;
    private readonly SemaphoreSlim _gate = new(1, 1);
    private ApplicationConfiguration? _config;
    private Session? _session;

    public OpcUaTagSource(OpcUaOptions options, ILogger<OpcUaTagSource> log)
    {
        _opt = options;
        _log = log;
    }

    public string Name => $"opc-ua ({_opt.Endpoint})";

    public async Task<IReadOnlyList<TagReading>> ReadAsync(IReadOnlyList<string> tags, CancellationToken ct)
    {
        Session session;
        try
        {
            session = await EnsureSessionAsync(ct);
        }
        catch (Exception ex)
        {
            _log.LogWarning(ex, "OPC UA connect to {Endpoint} failed; returning Bad readings.", _opt.Endpoint);
            return tags.Select(TagReading.Bad).ToList();
        }

        try
        {
            var nodesToRead = new ReadValueIdCollection(
                tags.Select(t => new ReadValueId { NodeId = ParseNode(t), AttributeId = Attributes.Value }));
            var resp = await session.ReadAsync(null, 0, TimestampsToReturn.Both, nodesToRead, ct);
            var results = resp.Results;

            var readings = new List<TagReading>(tags.Count);
            for (var i = 0; i < tags.Count; i++)
            {
                var dv = i < results.Count ? results[i] : null;
                if (dv is null) { readings.Add(TagReading.Bad(tags[i])); continue; }
                var quality = StatusCode.IsGood(dv.StatusCode) ? "Good"
                            : StatusCode.IsUncertain(dv.StatusCode) ? "Uncertain" : "Bad";
                var at = dv.SourceTimestamp == DateTime.MinValue
                    ? DateTimeOffset.UtcNow
                    : new DateTimeOffset(DateTime.SpecifyKind(dv.SourceTimestamp, DateTimeKind.Utc));
                readings.Add(new TagReading(tags[i], dv.Value?.ToString(), quality) { At = at });
            }
            return readings;
        }
        catch (Exception ex)
        {
            _log.LogWarning(ex, "OPC UA read from {Endpoint} failed; dropping the session.", _opt.Endpoint);
            await DropSessionAsync();
            return tags.Select(TagReading.Bad).ToList();
        }
    }

    public async Task<IReadOnlyList<BrowsedNode>> BrowseAsync(string? nodeId, CancellationToken ct)
    {
        var session = await EnsureSessionAsync(ct);
        var start = string.IsNullOrWhiteSpace(nodeId) ? ObjectIds.ObjectsFolder : ParseNode(nodeId);
        session.Browse(null, null, start, 0u, BrowseDirection.Forward,
            ReferenceTypeIds.HierarchicalReferences, true,
            (uint)(NodeClass.Object | NodeClass.Variable | NodeClass.Method),
            out _, out var refs);
        return refs.Select(r => new BrowsedNode(
            r.NodeId.ToString(), r.DisplayName?.Text ?? "", r.NodeClass.ToString())).ToList();
    }

    private static NodeId ParseNode(string tag) => NodeId.Parse(tag);

    private async Task<Session> EnsureSessionAsync(CancellationToken ct)
    {
        if (_session is { Connected: true } s) return s;
        await _gate.WaitAsync(ct);
        try
        {
            if (_session is { Connected: true } s2) return s2;
            await DropSessionAsync();

            var config = _config ??= await BuildConfigAsync();
            var useSecurity = _opt.UseSecurity;
            var description = CoreClientUtils.SelectEndpoint(config, _opt.Endpoint, useSecurity, _opt.DiscoveryTimeoutMs);
            var endpoint = new ConfiguredEndpoint(null, description, EndpointConfiguration.Create(config));
            var identity = string.IsNullOrEmpty(_opt.Username)
                ? new UserIdentity()
                : new UserIdentity(_opt.Username, _opt.Password ?? "");

            _session = await Session.Create(config, endpoint, false, "ABIS Edge",
                (uint)_opt.SessionTimeoutMs, identity, null);
            _log.LogInformation("OPC UA session established to {Endpoint} (security: {Sec}).",
                _opt.Endpoint, useSecurity ? description.SecurityPolicyUri : "None");
            return _session;
        }
        finally
        {
            _gate.Release();
        }
    }

    private async Task<ApplicationConfiguration> BuildConfigAsync()
    {
        var application = new ApplicationInstance
        {
            ApplicationName = "ABIS Edge",
            ApplicationType = ApplicationType.Client,
        };
        var config = await application
            .Build("urn:abis:edge:client", "https://abis/edge")
            .AsClient()
            .AddSecurityConfiguration("CN=ABIS Edge, O=ABIS", _opt.PkiRoot)
            .SetAutoAcceptUntrustedCertificates(_opt.AcceptUntrusted)
            .Create();

        if (_opt.AcceptUntrusted)
            config.CertificateValidator.CertificateValidation += (_, e) =>
            {
                if (e.Error.StatusCode == Opc.Ua.StatusCodes.BadCertificateUntrusted) e.Accept = true;
            };

        application.ApplicationConfiguration = config;
        await application.CheckApplicationInstanceCertificate(false, CertificateFactory.DefaultKeySize);
        return config;
    }

    private async Task DropSessionAsync()
    {
        if (_session is null) return;
        try { await _session.CloseAsync(); } catch { /* best effort */ }
        _session.Dispose();
        _session = null;
    }

    public async ValueTask DisposeAsync()
    {
        await DropSessionAsync();
        _gate.Dispose();
    }
}
