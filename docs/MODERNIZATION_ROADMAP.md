# ABIS — Modernization Roadmap

This is a living plan for modernizing ABIS (the PowerBuilder `lion`/silverdome
ERP/MES). It is grounded in the analysis in
[`ARCHITECTURE.md`](ARCHITECTURE.md), [`DATA_MODEL.md`](DATA_MODEL.md), and
[`OBJECT_INVENTORY.md`](OBJECT_INVENTORY.md).

> **Continuing the work?** See [`NEXT_STEPS.md`](NEXT_STEPS.md) for a pickup guide
> (current state, prioritized next steps, environment setup, and the recipe for
> adding a module slice).

## Goals & guiding principles

- **Keep the plant running.** ABIS is operational software for a working
  factory. Nothing in this plan should risk a line stoppage; changes ship
  incrementally and reversibly.
- **De-risk before rewriting.** Recover knowledge (schema, behavior, rules)
  before replacing code.
- **Strangler-fig, not big-bang.** Stand a modern system up *beside* the legacy
  app and migrate one capability at a time behind a stable seam.
- **Preserve the edge.** Serial scales/gauges and OPC/PLC integration are
  physically tied to the shop floor and must keep working throughout.

## Where we are

- ✅ The app was **migrated onto a current, supported Appeon PowerBuilder**
  (Aug 2025) — see `lion_mig.log`. The end-of-life risk is already addressed.
- ✅ **Discovery done** (this effort): reproducible extractors, a partial data
  model, an object inventory, and this roadmap.
- ✅ **Phase 2 seam started**: a read-first ASP.NET Core API over the core
  entities, with tests and CI — see [`../api/`](../api/README.md).
- ⚠️ **Not buildable as committed**: 7 PFE/PFD libraries referenced by the
  target are missing from the repo (see `ARCHITECTURE.md` §build-readiness).
- ❌ **No API / service tier.** The client talks straight to the DB; there is no
  seam to integrate against yet.
- ❌ **No tests, CI, or text-based source control** for the bulk of the code.

## Strategic options considered

| Option | What it is | Pros | Cons |
|---|---|---|---|
| **A. Rehost as-is** | Keep PB; run via Citrix/RDS/app-streaming | Cheapest, fast | Doesn't modernize anything; tech debt frozen in place |
| **B. Appeon PowerServer** | Use Appeon's tooling to turn the existing PB app into an n-tier C# REST API + web/mobile client, reusing DataWindows | Largest code reuse; vendor-supported path | Locks into Appeon; UI stays DataWindow-shaped; needs the Windows PB/PowerServer IDE; not a true re-architecture |
| **C. Incremental greenfield rewrite (strangler-fig)** | Build a new web app + REST API; migrate one module at a time; both run against the same DB during transition | Real modernization; testable; cloud-ready; hire-able stack | Highest effort; must re-derive business rules from compiled code |
| **D. Hybrid (recommended)** | Phase 0–2 below are common to all; *then* pilot **B** for a low-risk module to measure reuse, and **C** for a high-value module, and choose per-module | Keeps options open; lets data (not opinion) pick the path; immediate value | Requires discipline to avoid two parallel stacks long-term |

**Recommendation: D (Hybrid), starting with the foundation phases.** The
foundation work (below) is mandatory under *every* option, delivers value
immediately, and is the only part fully doable in this Linux/CI environment
(the PB-native paths additionally require the Windows PowerBuilder IDE). Defer
the B-vs-C commitment until after a measured pilot.

## Phased plan

### Phase 0 — Stabilize the source of truth  *(this environment)*
- [x] Reproducible analysis tooling (`tools/extract_schema.py`,
      `tools/extract_inventory.py`).
- [x] Architecture, data-model, and inventory docs + this roadmap.
- [ ] Decide how to handle binary `.pbl` files in git (see "Source control"
      below); add `.gitignore`/`.gitattributes` accordingly.
- [ ] Track the **7 missing PFE/PFD libraries** as a blocking issue; locate or
      regenerate them so the app builds.
- [ ] Resolve the **stale backup PBLs** (`*_12032020`, `*_06092022`): archive
      out of the main tree or document why they stay.

### Phase 1 — Recover the full picture  *(needs PB IDE for export)*
- [ ] **Export every PB object to text** from the IDE (`.srw`, `.srd`, `.sru`,
      `.srf`, `.srs`, `.srm`) and commit it, so git diffs become meaningful and
      the extractors can see the *whole* app, not just ~40 DataWindows.
- [ ] **Introspect the real database** (or obtain DDL) and replace the partial
      `DATA_MODEL.md` with full tables/PKs/FKs/indexes; confirm the inferred FKs.
- [ ] Catalog all external integrations precisely (every `WSC32`/Win32 call,
      every OPC tag, every EDI transaction set).

### Phase 2 — Build the seam (the missing API tier)  *(in progress)*
- [x] Stand up a **REST API** over the existing database (read-first), starting
      with the core entities (`ab_job`, `coil`, `customer_order`/`order_item`,
      test results). This is the integration point everything else hangs off of.
      → see [`../api/`](../api/README.md): ASP.NET Core 8 + Dapper, Oracle in
      production, a seeded SQLite fixture for dev/CI.
- [x] Add an **automated test harness** (xUnit: repository + in-process HTTP
      smoke tests) and **CI** (`.github/workflows/ci.yml` builds/tests the API
      and runs the discovery extractors).
- [x] **Expand read coverage**: added customers, sheet skids, and scrap skids
      (plus `/jobs/{id}/skids` and `/jobs/{id}/scrap` relationship endpoints).
      *Ongoing* — more entities as Phase 1's full schema lands.
- [x] **Query ergonomics**: allowlisted, injection-safe **sorting** (`sort`/`dir`
      with a PK tie-breaker) on every paged list (`Data/Sort.cs`), and richer QA
      filtering (`position` + `from`/`to` date range on test results).
- [x] **Readiness probe**: `GET /health/ready` runs `SELECT 1` (503 when the DB is
      unreachable) alongside the dependency-free `GET /health` liveness check.
- [x] **Typed contract + client codegen**: every endpoint declares its response
      types (`.Produces<T>()`), so the OpenAPI doc carries real schemas; CI emits a
      typed TypeScript client (NSwag) as the `ts-client` artifact.
- [x] **Write surface across core entities**: customers, order headers, order
      items, jobs, coils, sheet skids, and scrap skids (POST/PUT, server-assigned
      ids, validation, 201/400/404) plus operational PATCH on jobs and coils —
      all tested against the fixture.
- [ ] Shipping / EDI surface (`inbound_shipment`, `shipment`) — deferred until
      Phase 1's full schema lands (these tables are too thinly represented in the
      recovered model to build faithfully).
- [x] **Observability / audit parity**: `AuditMiddleware` records every mutating
      request into the legacy `opc_action_log`, exposed via `GET /api/audit-log`.
- [x] **Authentication**: API-key auth (`X-Api-Key`) gates the `/api` surface
      (`/health`, `/health/ready` + Swagger stay open); swappable for OAuth/OIDC later.
- [x] **Deployment readiness**: multi-stage `Dockerfile` (built in CI), CORS for
      a future SPA, a `/` service-info endpoint, and a `requests.http` collection.
- [ ] Validate the **Oracle** data-access path against a real database (CI only
      exercises the SQLite fixture today).

### Phase 3 — Pilot both modernization paths on real modules

> Detailed plan: [`PHASE3_PILOT_PLAN.md`](PHASE3_PILOT_PLAN.md) — candidate
> modules, scoring rubric, prerequisites, and decision/exit criteria.

- [ ] **Path B pilot:** run a self-contained, low-risk module (candidate:
      `quotation` or a reporting screen) through Appeon PowerServer; measure
      reuse %, UX, and operability.
- [ ] **Path C pilot:** rebuild a high-value, high-churn module greenfield
      against the Phase-2 API (candidate: `order_entry` or `inv_coil`); measure
      effort and the quality ceiling.
- [ ] **Decide** the per-module strategy from measured results, not opinion.

### Phase 4 — Migrate module-by-module (strangler-fig)
- [ ] Roll modules over behind the API seam in dependency order, oldest/most
      painful first; keep legacy and new running against one DB until cutover.
- [ ] Replace serial/OPC integration with a small, well-tested **edge service**
      on the shop floor exposing those devices to the API.
- [ ] Decommission each legacy module only after its replacement is proven in
      production.

### Phase 5 — Decommission legacy
- [ ] Retire `lion.exe`/PB once all modules are migrated and the edge service
      owns hardware I/O.

## Source control strategy (decide in Phase 0)

The `.pbl` binaries can't be diffed or merged. Options:
1. **Commit text exports as the source of truth** (recommended); keep `.pbl` out
   of git or store via Git LFS for convenience. Requires the PB IDE export step.
2. Keep `.pbl` in git as opaque blobs (status quo) — simplest but gives up real
   version control. Acceptable only until Phase 1 export lands.

## Immediate next steps (what can be done now, here)

1. Add `.gitignore`/`.gitattributes` and a short `CONTRIBUTING`/build note.
2. File the **missing-PFE-libraries** and **stale-backup-PBL** items as tracked
   issues so they aren't lost.
3. When a database connection or a DDL dump is available, extend
   `tools/extract_schema.py` to ingest it and produce the full data model.
4. Prototype the **Phase-2 API skeleton** (read-only endpoints for `ab_job` /
   `coil`) against a stub or the real DB — the seam everything else needs.

> **Pick the next concrete deliverable** and this roadmap will be advanced
> accordingly. The recommended next move is Phase 2's API skeleton, because it
> unblocks every later phase; but locating the missing PFE libraries (Phase 0)
> may be more urgent if a clean PB build is needed first.
