# ABIS — Phase 3 Pilot Log (the bake-off, in progress)

The execution + scoring record for the [Phase 3 plan](PHASE3_PILOT_PLAN.md): we
pilot **Path B (Appeon PowerServer)** and **Path C (greenfield on the Phase-2
API)** on real modules and let measured scores decide the modernization path
**per module**. This file is the living result; it is updated as each pilot
advances.

## Status at a glance

| Path | Pilot module | State | Blocker |
|---|---|---|---|
| **C — greenfield** | `order_entry` | **Executed against live Oracle** ✅ | — |
| **C — greenfield** | `inv_coil` | Artifact exists (demo UI), not yet measured | — |
| **B — PowerServer** | `quotation` | **Not started** | Needs the Windows PB IDE + a PowerServer license (user-side) |

Prerequisites (from the plan) — current state:

- ✅ **DB access** — a live non-prod Oracle 11g (`abc11`) connection is available;
  Path C was run against real data (below).
- ✅ **7 missing PFE/PFD libraries** — located and committed (Phase 0), so the
  legacy app builds — a Path B prerequisite is now cleared.
- ❌ **Windows PB IDE + PowerServer license** — still required for Path B; not
  available in this environment.

## Path C — `order_entry` pilot (greenfield on the Phase-2 API)

**Artifacts.** The greenfield order-entry module runs on the Phase-2 seam: the
read/write endpoints (`/api/orders`, `/api/orders/{id}/full`,
`/api/orders/with-items`, `/api/lookups/alloys`) and a dedicated **typed SPA**
([`wwwroot/ui/order-entry.html`](../api/src/ABIS.Api/wwwroot/ui/order-entry.html),
source `clientapp/src/order-entry.ts`) — search → detail → transactional
create-with-items, driven entirely by the NSwag-generated, compiler-checked
client. Built with `tsc` (no framework), covered by the clientapp e2e.

> **Path-C decision (2026-06-26):** the team committed to Path C and **dropped
> PowerServer** (no Appeon license / lock-in). See
> [`MODERNIZATION_ROADMAP.md`](MODERNIZATION_ROADMAP.md) §Strategic options. The
> Path B column below is therefore retired, not merely pending.

**Pilot run (live Oracle, 2026-06-26).** The full order-entry flow was exercised
against the real database (≈48k orders), through the API the greenfield UI uses:

| Step | Operation | Result | Latency |
|---|---|---|---:|
| Search | `GET /api/orders?pageSize=5` | 48,273 orders; first `#2000` | 169 ms |
| Detail | `GET /api/orders/2000/full` | header + customer ("NOVELIS ROLLED PRODUCTS CO.-WARREN") + 1 line | 198 ms |
| Save | `POST /api/orders/with-items` | new order `#52150` created transactionally (header + line in one tx) | 867 ms |

The transactional save and the composite-key `order_item` model (recovered in
Phase 1, #10) both behave correctly on real data; the test order was removed
afterward. This is a working Path C pilot on production-shaped data — what
remains is **measuring it against the legacy screen** (UX/perf parity) once a
side-by-side is possible.

## Scoring rubric (1–5; Path B pending its prerequisites)

Path C scores below are grounded in the executed pilot + the Phase-2 work; Path B
is left blank until it can run.

| Dimension | Path C (greenfield) | Evidence | Path B (PowerServer) |
|---|:--:|---|:--:|
| **Reuse / effort** | 3 | Order-entry slice already built on the seam; per-module rebuild cost is real but bounded | _pending_ |
| **Maintainability** | 5 | 160 automated tests, typed OpenAPI contract + generated clients, CI green | _pending_ |
| **UX / reach** | 4 | Plain web (any browser/mobile); not yet UX-compared to the legacy DataWindow | _pending_ |
| **Operability** | 5 | Auth, rate-limit, health probes, ETag/If-Match, Docker, audit — fits the Phase-2 seam by construction | _pending_ |
| **Performance** | 4 | Sub-200 ms reads, ~0.9 s transactional write on the live 48k-order DB | _pending_ |
| **Risk** | 4 | Additive, read-mostly; writes share the API's validation + optimistic concurrency | _pending_ |
| **Licensing / cost** | 5 | No proprietary runtime/licensing | _pending_ (PowerServer license) |

> A fair bake-off needs **both** columns. Path B can't be scored here — it needs
> the PB IDE + PowerServer — so no per-module decision is finalized yet.

## What completes the bake-off (and who)

1. **Run the Path B `quotation` pilot** — needs the Windows PB IDE + a PowerServer
   license (user-side). Score it on the same rubric.
2. **UX/perf parity check for Path C `order_entry`** — put the greenfield screen
   beside the legacy window for the same tasks and record real operator timings.
3. **Decide per module** from the filled-in table → feeds Phase 4 (module-by-module
   strangler-fig migration in dependency order).

Until Path B can run, the evidence points to **Path C as the default for
high-churn, high-value modules** (order entry, coil inventory) — but that's a
recommendation, not the measured per-module decision the plan calls for.
