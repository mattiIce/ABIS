# ABIS — Shop-floor Edge Service (`edge/AbisEdge`)

The one piece of ABIS that **can't** live in the central API: the hardware on the
shop floor. The legacy `da` data-acquisition app reads weigh scales and gauges
over RS-232 using ~29 `WSC32.DLL` `Sio*` calls, and line equipment integrates
over OPC (see [`INTEGRATIONS.md`](INTEGRATIONS.md)). Those couplings are
physically tied to the plant — so in the Path-C architecture they move to a
small **edge service** that runs on the shop-floor PC, talks to the devices
locally, and exposes them to the modern stack over HTTP.

> This is the **Phase-4 "edge" prerequisite** from the roadmap: replace serial/OPC
> integration with a small, well-tested edge service. This repo ships a working,
> tested **skeleton**; the device-specific parsing and OPC address space need real
> hardware to finish (flagged below).

## Topology

```
 shop-floor PC (Windows, has the COM ports)         server (Linux)
 ┌───────────────────────────────────────┐         ┌──────────────────────┐
 │  AbisEdge  (this service)              │  HTTP   │  ABIS API + web UIs   │
 │  scale ⟶ WeightParser ⟶ /reading  │◀───────▶│  (docker compose)     │
 │  RS-232 (System.IO.Ports)             │         │  ⟶ Oracle             │
 └──────────┬────────────────────────────┘         └──────────────────────┘
            │ serial / OPC
            ▼
   scales · gauges · PLCs
```

The edge service sits **next to the devices**; the central API/UI never touches a
COM port. The web screens (or the API) consume readings over HTTP on the LAN.

## What it does today

- **Serial scales** — `SerialScale` reads a COM port via `System.IO.Ports` (the
  modern, cross-platform replacement for the WSC32 P/Invoke surface). Each line
  is parsed by `WeightParser` (the comma-delimited `ST,GS,+00123.4 LB` continuous
  format, plus the bare `+00123.4 LB` form) into a typed `WeightReading`.
- **No-hardware mode** — `MockScale` emits a settling weight, so the service runs
  and is testable on any machine (the default `Edge:Scale:Provider=Mock`).
- **HTTP surface**
  - `GET /health` → `{ status, device }`
  - `GET /reading` → the latest `WeightReading` (`503` until one arrives)
- **Resilience** — a background pump reconnects with backoff if a device drops.

## Configuration (`Edge:Scale:*`, env or appsettings)

| Setting | Values | Notes |
|---|---|---|
| `Provider` | `Mock` (default) / `Serial` | which device source |
| `Port` | e.g. `COM3` | required for `Serial` |
| `BaudRate` / `Parity` / `DataBits` / `StopBits` | per the indicator's manual | defaults 9600/None/8/One |
| `Setpoint` / `Unit` | mock only | the simulated weight |

```sh
# mock (any machine)
dotnet run --project edge/AbisEdge
# real scale on COM3
Edge__Scale__Provider=Serial Edge__Scale__Port=COM3 dotnet run --project edge/AbisEdge
```

## How it integrates with ABIS

Pull model (today): the web UI / API reads `GET /reading` on the LAN when an
operator captures a weight (e.g. on a skid). A push model is a small addition —
the pump can `POST` settled readings to an ingest endpoint (e.g. a scan event or
a sheet-skid weight) using an API key; that contract is intentionally left for
when a concrete capture workflow is wired up, to avoid fabricating one.

## Deployment

Runs **on the shop-floor PC** as a console app or a Windows Service (`sc create`
/ NSSM), bound to the LAN so the web stack can reach it. It is **not**
containerized — it needs direct COM-port access, which serial-passthrough to
containers makes brittle. Keep it on a current .NET 8 runtime; no Oracle access
needed (it talks only to devices + the API).

## Testing

- `WeightParser` is **fully unit-tested** (`edge/AbisEdge.Tests`, 13 tests):
  continuous + bare formats, sign, units, stable/unstable, and unparseable input.
- `MockScale` lets the whole service run + be smoke-tested with no hardware
  (verified: `/health` → `ok`, `/reading` → a parsed `WeightReading`).

## What still needs real hardware (⛔)

- **Per-device formats.** Real indicators vary (Toledo, Mettler, Cardinal, …);
  confirm each device's framing/units against the actual stream and extend
  `WeightParser` if needed. The legacy `da` object's exact parsing is recoverable
  from the PB source if exported.
- **OPC / PLC.** Line equipment over OPC is the second edge source. It plugs in as
  another `IScale`-style provider, but needs the **OPC server's address space**
  (tag names/types) and an OPC client library — both hardware/site-specific.
