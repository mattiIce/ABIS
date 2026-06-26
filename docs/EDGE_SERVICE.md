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
- **OPC / PLC tags** — `ITagSource` reads named PLC tags; a background pump polls
  the configured `Edge:Opc:Tags` into a per-tag cache. `OpcUaTagSource` is the
  real OPC UA reader (a **scaffold** — the connection/read is the one piece that
  needs the OPC Foundation library + a live server's address space; see its
  source + below). `MockTagSource` simulates a PLC so the path runs without one.
- **No-hardware mode** — `MockScale` + `MockTagSource` let the whole service run
  and be tested on any machine (the defaults `Edge:Scale:Provider=Mock`,
  `Edge:Opc:Provider=Mock`).
- **HTTP surface**
  - `GET /health` → `{ status, scale, opc }`
  - `GET /reading` → the latest `WeightReading` (`503` until one arrives)
  - `GET /tags` → the latest value of each configured OPC tag
  - `GET /tags/{name}` → one tag's latest value (`404` until polled)
- **Resilience** — background pumps reconnect with backoff if a device drops.

## Configuration (`Edge:Scale:*`, env or appsettings)

| Setting | Values | Notes |
|---|---|---|
| `Provider` | `Mock` (default) / `Serial` | which device source |
| `Port` | e.g. `COM3` | required for `Serial` |
| `BaudRate` / `Parity` / `DataBits` / `StopBits` | per the indicator's manual | defaults 9600/None/8/One |
| `Setpoint` / `Unit` | mock only | the simulated weight |
| `Edge:Opc:Provider` | `Mock` (default) / `OpcUa` | which tag source |
| `Edge:Opc:Endpoint` | e.g. `opc.tcp://plc.local:4840` | required for `OpcUa` |
| `Edge:Opc:Tags` | array of node ids | the PLC tags to poll |

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

- `WeightParser` + the tag sources are **unit-tested** (`edge/AbisEdge.Tests`,
  17 tests): scale continuous/bare formats, sign, units, stable/unstable,
  unparseable input; OPC tag readings per request, simulation, and that the OPC UA
  source faults clearly until its client is wired.
- `MockScale` + `MockTagSource` let the whole service run + be smoke-tested with no
  hardware (verified: `/health` → both sources, `/reading` → a `WeightReading`,
  `/tags` → the configured tags' simulated values).

## What still needs real hardware (⛔)

- **Per-device formats.** Real indicators vary (Toledo, Mettler, Cardinal, …);
  confirm each device's framing/units against the actual stream and extend
  `WeightParser` if needed. The legacy `da` object's exact parsing is recoverable
  from the PB source if exported.
- **OPC / PLC.** The `ITagSource` abstraction, the poll pump, the `/tags` surface,
  and a tested mock are **built**. Finishing `OpcUaTagSource` needs the **OPC
  Foundation client package** + the **server's address space** (the real node
  ids/types) — both hardware/site-specific. The source file marks exactly where
  `session.Read` goes.
