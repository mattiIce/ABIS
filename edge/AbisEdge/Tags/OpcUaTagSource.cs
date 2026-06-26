namespace AbisEdge.Tags;

/// <summary>
/// OPC UA tag source — the real shop-floor PLC reader. **Scaffold:** the shape,
/// lifecycle, and integration point are here; the actual OPC UA client call is
/// the one piece that needs the OPC Foundation library + a live server's address
/// space, so it is intentionally not pulled in yet (it would add a large,
/// security/certificate-heavy dependency that can't be exercised without a
/// server). Wire it where <see cref="ReadAsync"/> notes — the rest of the edge
/// service already treats this exactly like the mock.
///
/// To finish (per docs/EDGE_SERVICE.md):
///   1. Add the package: <c>OPCFoundation.NetStandard.Opc.Ua.Client</c>.
///   2. Build an <c>ApplicationConfiguration</c> (app cert, security policy) and
///      keep a connected <c>Session</c> to <see cref="_endpoint"/> (reconnect on drop).
///   3. In ReadAsync, issue <c>session.Read</c> for the requested <c>NodeId</c>s and
///      map each <c>DataValue</c> → <see cref="TagReading"/> (Value, StatusCode→quality).
/// </summary>
public sealed class OpcUaTagSource : ITagSource
{
    private readonly string _endpoint;

    public OpcUaTagSource(string endpoint) => _endpoint = endpoint;

    public string Name => $"opc-ua ({_endpoint})";

    public Task<IReadOnlyList<TagReading>> ReadAsync(IReadOnlyList<string> tags, CancellationToken ct)
    {
        // ── Wire the real OPC UA read here ──────────────────────────────────
        // using Opc.Ua; using Opc.Ua.Client;
        // var nodeIds = tags.Select(t => new ReadValueId { NodeId = t, AttributeId = Attributes.Value });
        // session.Read(null, 0, TimestampsToReturn.Both, new ReadValueIdCollection(nodeIds),
        //              out DataValueCollection results, out _);
        // return results.Select((dv, i) => new TagReading(
        //     tags[i], dv.Value?.ToString(),
        //     StatusCode.IsGood(dv.StatusCode) ? "Good" : "Bad") { At = dv.SourceTimestamp }).ToList();
        // ────────────────────────────────────────────────────────────────────
        return Task.FromException<IReadOnlyList<TagReading>>(new NotSupportedException(
            "OPC UA source is a scaffold: add the OPCFoundation.NetStandard.Opc.Ua.Client package " +
            "and implement the session read in OpcUaTagSource.ReadAsync (see the comments / " +
            "docs/EDGE_SERVICE.md). Use Edge:Opc:Provider=Mock until then."));
    }
}
