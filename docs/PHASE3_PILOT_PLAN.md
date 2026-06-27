# ABIS — Phase 3 Pilot Plan (modernization path bake-off)

> **Status (concluded):** the bake-off resolved to **Path C (greenfield)** — Path B
> (Appeon PowerServer) was dropped (2026-06-26), so it was never piloted. The
> greenfield rebuild was then carried across **every** business module (see
> [`MODERNIZATION_ROADMAP.md`](MODERNIZATION_ROADMAP.md) Phase 3/4 and
> [`NEXT_STEPS.md`](NEXT_STEPS.md)). This plan is retained for its scoring rubric
> and the historical decision record.

Phase 2 delivered the missing API seam ([`../api/`](../api/README.md)). Phase 3
**decides, with evidence, how each ABIS module should be modernized** — rather
than betting the whole rewrite on one approach. We pilot both candidate paths on
real modules, measure them against the same rubric, and let the numbers choose
per-module. This realizes the **hybrid** recommendation in
[`MODERNIZATION_ROADMAP.md`](MODERNIZATION_ROADMAP.md).

## The two paths under test

- **Path B — Appeon PowerServer**: run the *existing* PowerBuilder app through
  Appeon's tooling to generate an n-tier C# REST API + web/mobile client,
  reusing the DataWindows. Maximizes reuse; UI stays DataWindow-shaped.
- **Path C — Greenfield on the Phase-2 API**: build a new web UI (and any
  needed endpoints) against the ASP.NET Core seam, re-deriving the module's
  behavior. Maximizes modernity/testability; higher build cost.

## Prerequisites (mostly outside this Linux environment)

1. **Windows + PowerBuilder IDE** (current Appeon PB) and a **PowerServer**
   license for Path B.
2. The **7 missing PFE/PFD libraries** located/regenerated so the app builds
   (see [`ARCHITECTURE.md`](ARCHITECTURE.md) §build-readiness).
3. **Database access** (or a sanitized copy) so the Phase-2 API and both pilots
   run against real data — also unblocks the deferred Oracle validation.
4. A **non-production environment** mirroring the plant DB for safe piloting.

## Candidate modules

Selection criteria: self-contained (few cross-module dependencies), meaningful
but bounded, and representative. Using the inventory
([`OBJECT_INVENTORY.md`](OBJECT_INVENTORY.md)):

| Pilot | Goal | Recommended candidate | Why |
|---|---|---|---|
| **B (PowerServer)** | Measure *reuse* on a low-risk module | **`quotation`** (~9 DWs, 5 windows) | Small, commercial (not shop-floor/hardware), low blast radius if it misbehaves |
| **C (Greenfield)** | Measure *rewrite cost & ceiling* on a high-value module | **`order_entry`** or **`inv_coil`** | High-churn, high-value, already partly covered by the Phase-2 API (`orders`, `order-items`, `coils`) |

Explicitly **not** first pilots: anything touching serial/OPC hardware
(`da`, `opc_log`, `stacker_110`) or the giant `silverdome3` core — too risky and
entangled for a first measurement.

## What each pilot produces

- **Path B pilot:** the `quotation` module deployed via PowerServer; notes on
  what converted cleanly vs. needed manual fixes; the resulting client UX.
- **Path C pilot:** a small SPA (or server-rendered page) for `order_entry`
  built on the Phase-2 API, plus any new endpoints it required.

Both run **beside** the legacy app against the same database (read-mostly during
the pilot) — never replacing it.

## Scoring rubric (decide per module)

Score each path 1–5 on every dimension; weight by local priorities.

| Dimension | What we measure |
|---|---|
| **Reuse / effort** | Person-days to reach feature parity for the module |
| **Maintainability** | Test coverage achievable, code clarity, hiring pool for the stack |
| **UX** | Usability vs. the legacy screen; mobile/web reach |
| **Operability** | Deploy/observability/auth story; fits the Phase-2 seam? |
| **Performance** | Screen load + key transactions vs. legacy |
| **Risk** | Blast radius, data-integrity exposure, rollback ease |
| **Licensing/cost** | Ongoing tooling/runtime cost (e.g., PowerServer) |

A worked scoring table is filled in per module as pilots complete.

## Decision & exit criteria

- Pilots are "done" when each candidate reaches feature parity for the chosen
  module **or** hits a clear blocker.
- Decide **per module** (not globally): some modules may favor PowerServer
  (high reuse, low change), others greenfield (high value, high churn).
- Output: a per-domain modernization decision feeding **Phase 4** (module-by-
  module strangler-fig migration in dependency order).

## Risks & guardrails

- **Keep the plant running** — pilots are additive and read-mostly; no cutover.
- **Data integrity** — writes during pilots go through the API/PowerServer with
  the same validation; prefer a non-prod DB copy.
- **Avoid two permanent stacks** — the hybrid is a *transition* tactic; converge
  over time, don't institutionalize divergence.

## How this environment can help before prerequisites land

Even without the PB IDE / DB, work that advances Phase 3 and is doable here.
**Executed results live in [`PHASE3_PILOT_LOG.md`](PHASE3_PILOT_LOG.md)** — the
Path C `order_entry` pilot has now been run against the live Oracle DB.
- [x] Extend the Phase-2 API with the endpoints the **Path C** `order_entry`
  pilot needs (against the SQLite fixture): order search filters
  (`customerId`/`po`), the order→line-items relationship, an order-entry read
  model (`GET /api/orders/{id}/full` = header + customer + items), a
  transactional save (`POST /api/orders/with-items`), and dropdown reference
  data (`GET /api/lookups/alloys`). The greenfield UI pilot can start against
  these the moment DB access exists. Dependency-free **demo UIs** already
  exercise the full flow end-to-end as Path C references (no framework lock-in):
  `wwwroot/ui/index.html` (order entry) and `wwwroot/ui/coils.html` (coil
  inventory: filter, processing history, receive, weight rollup).
- [ ] Flesh out the data model ([`DATA_MODEL.md`](DATA_MODEL.md)) for the
  candidate modules from additional DataWindow exports.
