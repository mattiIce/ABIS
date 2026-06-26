using System.Collections.Concurrent;
using System.IO.Ports;
using AbisEdge.Scales;
using AbisEdge.Tags;

// ABIS Edge — a small shop-floor service that reads weigh scales/gauges over
// serial AND line equipment over OPC, and exposes the latest values over HTTP,
// so the modern web stack can consume hardware the central API can't reach. It
// replaces the legacy `da` (WSC32 serial) + OPC integration. See docs/EDGE_SERVICE.md.

var builder = WebApplication.CreateBuilder(args);

// --- Configure the device from Edge:Scale:* (env or appsettings) ---------------
var scaleCfg = builder.Configuration.GetSection("Edge:Scale");
var provider = scaleCfg.GetValue("Provider", "Mock")!;

builder.Services.AddSingleton<IScale>(_ => provider.ToLowerInvariant() switch
{
    "serial" => new SerialScale(
        scaleCfg.GetValue<string>("Port") ?? throw new InvalidOperationException("Edge:Scale:Port is required for the serial provider."),
        scaleCfg.GetValue("BaudRate", 9600),
        Enum.Parse<Parity>(scaleCfg.GetValue("Parity", "None")!, ignoreCase: true),
        scaleCfg.GetValue("DataBits", 8),
        Enum.Parse<StopBits>(scaleCfg.GetValue("StopBits", "One")!, ignoreCase: true)),
    _ => new MockScale(scaleCfg.GetValue("Setpoint", 1234.5m), scaleCfg.GetValue("Unit", "LB")!),
});

builder.Services.AddSingleton<LatestReading>();
builder.Services.AddHostedService<ReadingPump>();

// --- Configure the OPC source from Edge:Opc:* ---------------------------------
var opcCfg = builder.Configuration.GetSection("Edge:Opc");
var opcProvider = opcCfg.GetValue("Provider", "Mock")!;
var opcTags = opcCfg.GetSection("Tags").Get<string[]>() ?? Array.Empty<string>();

builder.Services.AddSingleton<ITagSource>(_ => opcProvider.ToLowerInvariant() switch
{
    "opcua" => new OpcUaTagSource(
        opcCfg.GetValue<string>("Endpoint") ?? throw new InvalidOperationException("Edge:Opc:Endpoint is required for the opcua provider.")),
    _ => new MockTagSource(),
});
builder.Services.AddSingleton(new TagSet(opcTags));
builder.Services.AddSingleton<LatestTags>();
builder.Services.AddHostedService<TagPump>();

var app = builder.Build();

// Liveness + which devices are wired up.
app.MapGet("/health", (IScale scale, ITagSource tags) =>
    Results.Ok(new { status = "ok", scale = scale.Name, opc = tags.Name }));

// The latest weight reading (503 until the device has produced one).
app.MapGet("/reading", (LatestReading latest) =>
    latest.Value is { } r ? Results.Ok(r) : Results.Json(new { status = "no-reading-yet" }, statusCode: 503));

// The latest OPC tag values (the configured Edge:Opc:Tags), and one by name.
app.MapGet("/tags", (LatestTags tags) => Results.Ok(tags.All()));
app.MapGet("/tags/{name}", (string name, LatestTags tags) =>
    tags.Get(name) is { } t ? Results.Ok(t) : Results.NotFound(new { tag = name, status = "no-value-yet" }));

app.Run();

/// <summary>The configured set of OPC tags to poll (from Edge:Opc:Tags).</summary>
public sealed record TagSet(IReadOnlyList<string> Tags);

/// <summary>Thread-safe holder for the most recent reading.</summary>
public sealed class LatestReading
{
    private volatile WeightReading? _value;
    public WeightReading? Value { get => _value; set => _value = value; }
}

/// <summary>Background pump: streams the scale into <see cref="LatestReading"/>,
/// reconnecting with backoff if the device drops.</summary>
public sealed class ReadingPump(IScale scale, LatestReading latest, ILogger<ReadingPump> log) : BackgroundService
{
    protected override async Task ExecuteAsync(CancellationToken ct)
    {
        log.LogInformation("Edge reading pump started for {Device}", scale.Name);
        while (!ct.IsCancellationRequested)
        {
            try
            {
                await foreach (var reading in scale.ReadAsync(ct))
                    latest.Value = reading;
            }
            catch (OperationCanceledException) { break; }
            catch (Exception ex)
            {
                log.LogWarning(ex, "Scale {Device} read failed; retrying in 5s", scale.Name);
                try { await Task.Delay(TimeSpan.FromSeconds(5), ct); } catch (OperationCanceledException) { break; }
            }
        }
    }
}

/// <summary>Thread-safe cache of the latest value per OPC tag.</summary>
public sealed class LatestTags
{
    private readonly ConcurrentDictionary<string, TagReading> _byName = new();
    public void Set(TagReading r) => _byName[r.Name] = r;
    public TagReading? Get(string name) => _byName.TryGetValue(name, out var r) ? r : null;
    public IReadOnlyCollection<TagReading> All() => _byName.Values.ToList();
}

/// <summary>Background pump: polls the configured OPC tags into <see cref="LatestTags"/>
/// on an interval, reconnecting with backoff on failure. No-op when no tags are
/// configured (so the mock/scaffold doesn't spin needlessly).</summary>
public sealed class TagPump(ITagSource source, TagSet set, LatestTags latest, ILogger<TagPump> log) : BackgroundService
{
    protected override async Task ExecuteAsync(CancellationToken ct)
    {
        if (set.Tags.Count == 0) { log.LogInformation("No OPC tags configured; tag pump idle."); return; }
        log.LogInformation("Edge tag pump started for {Source} ({Count} tags)", source.Name, set.Tags.Count);
        while (!ct.IsCancellationRequested)
        {
            try
            {
                foreach (var reading in await source.ReadAsync(set.Tags, ct))
                    latest.Set(reading);
                await Task.Delay(TimeSpan.FromSeconds(2), ct);
            }
            catch (OperationCanceledException) { break; }
            catch (Exception ex)
            {
                log.LogWarning(ex, "OPC {Source} read failed; retrying in 5s", source.Name);
                try { await Task.Delay(TimeSpan.FromSeconds(5), ct); } catch (OperationCanceledException) { break; }
            }
        }
    }
}
