using System.IO.Ports;
using AbisEdge.Scales;

// ABIS Edge — a small shop-floor service that reads weigh scales/gauges over
// serial and exposes the latest reading over HTTP, so the modern web stack can
// consume hardware the central API can't reach. It replaces the legacy `da`
// data-acquisition app's WSC32 serial reads. OPC/PLC support plugs in the same
// way (a future IScale-style source). See docs/EDGE_SERVICE.md.

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

var app = builder.Build();

// Liveness + which device is wired up.
app.MapGet("/health", (IScale scale) => Results.Ok(new { status = "ok", device = scale.Name }));

// The latest weight reading (503 until the device has produced one).
app.MapGet("/reading", (LatestReading latest) =>
    latest.Value is { } r ? Results.Ok(r) : Results.Json(new { status = "no-reading-yet" }, statusCode: 503));

app.Run();

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
