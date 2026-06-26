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
- ✅ **Discovery done** (this effort): reproducible extractors, a **full data
  model recovered from the live Oracle schema (412 tables)**, an object
  inventory, and this roadmap.
- ✅ **Phase 2 seam started**: a read-first ASP.NET Core API over the core
  entities, with tests and CI — see [`../api/`](../api/README.md).
- ✅ **Buildable as committed**: the 7 previously-missing PFE/PFD libraries were
  located and committed — all 50 libraries in `lion.pbt`'s LibList are now present.
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
- [x] Decide how to handle binary `.pbl` files in git (see "Source control"
      below); add `.gitignore`/`.gitattributes` accordingly. → `.gitattributes`
      marks `.pbl`/`.pbd`/`.dll` binary and the text exports (`.srd`/`.srw`/…)
      LF-normalized; `.gitignore` excludes build output and generated artifacts.
- [x] Track the **7 missing PFE/PFD libraries** as a blocking issue; locate or
      regenerate them so the app builds. → **Resolved.** All 7 (`PFD_ABC.PBL`,
      `PFE_ABC.PBL`, `pfeapsrv.pbl`, `pfedwsrv.pbl`, `pfemain.pbl`, `pfeutil.pbl`,
      `pfewnsrv.pbl`) were located in a complete build tree whose shared `pfc*`
      libraries are **byte-identical** to the repo's, and committed. **All 50
      libraries in `lion.pbt`'s LibList are now present** — the target builds as
      committed.
- [x] Resolve the **stale backup PBLs** (`*_12032020`, `*_06092022`): removed
      from the tree (not referenced by `lion.pbt`'s LibList; recoverable from git
      history if ever needed).

### Phase 1 — Recover the full picture  *(needs PB IDE for export)*
- [ ] **Export every PB object to text** from the IDE (`.srw`, `.srd`, `.sru`,
      `.srf`, `.srs`, `.srm`) and commit it, so git diffs become meaningful and
      the extractors can see the *whole* app, not just ~40 DataWindows.
      **← remaining blocker: needs the Windows PowerBuilder IDE (can't be done
      in this environment).**
- [x] **Introspect the real database** and replace the partial `DATA_MODEL.md`
      with full tables/PKs/FKs/indexes. → Done: [`DATA_MODEL.md`](DATA_MODEL.md)
      is regenerated from a live `DBO` data-dictionary dump by
      [`../tools/ingest_oracle_schema.py`](../tools/ingest_oracle_schema.py) —
      **412 tables, 335 PKs, 238 FKs, 82 sequences** with row counts
      (machine-readable: `data-model/oracle_schema.json`; full DDL+PL/SQL:
      `data-model/oracle_ddl.sql`). The inferred `order_item` composite key was
      confirmed and corrected (#10).
- [~] Catalog all external integrations precisely (every `WSC32`/Win32 call,
      every OPC tag, every EDI transaction set). → **EDI** catalogued in
      [`INTEGRATIONS.md`](INTEGRATIONS.md) from the X12/EDI schema + the EDI DB
      procedures in `oracle_ddl.sql`. The full per-call **WSC32/OPC** inventory
      still needs the PB source export (blocked, as above); the surface is mapped
      in [`ARCHITECTURE.md`](ARCHITECTURE.md) §Integration surface.

### Phase 2 — Build the seam (the missing API tier)  *(complete)*
- [x] Stand up a **REST API** over the existing database (read-first), starting
      with the core entities (`ab_job`, `coil`, `customer_order`/`order_item`,
      test results). This is the integration point everything else hangs off of.
      → see [`../api/`](../api/README.md): ASP.NET Core 8 + Dapper, Oracle in
      production, a seeded SQLite fixture for dev/CI.
- [x] Add an **automated test harness** (xUnit: repository + in-process HTTP
      smoke tests) and **CI** (`.github/workflows/ci.yml` builds/tests the API
      and runs the discovery extractors).
- [x] **Expand read coverage**: added customers, sheet skids, scrap skids, partial
      skids, and in-progress test results (`temp_test_result`), plus
      `/jobs/{id}/skids`, `/scrap`, and `/partial-skids` relationship endpoints.
      *Ongoing* — more entities as Phase 1's full schema lands.
- [x] **Query ergonomics**: allowlisted, injection-safe **sorting** (`sort`/`dir`
      with a PK tie-breaker) on every paged list (`Data/Sort.cs`), and richer QA
      filtering (`position` + `from`/`to` date range on test results).
- [x] **Readiness probe**: `GET /health/ready` runs `SELECT 1` (503 when the DB is
      unreachable) alongside the dependency-free `GET /health` liveness check.
- [x] **Production hardening**: per-API-key fixed-window rate limiting on `/api`
      (`429` + `Retry-After`) and baseline security headers on every response.
- [x] **Typed contract + client codegen**: every endpoint declares its response
      types (`.Produces<T>()`), so the OpenAPI doc carries real schemas; CI emits a
      typed TypeScript client (NSwag) as the `ts-client` artifact. A `clientapp/`
      demo (`/ui/typed.html`) consumes that client, compiled in CI.
- [x] **Concurrency-safe ids**: the connection factory supplies dialect-specific
      next-id SQL — `MAX+1` on SQLite (dev), sequence `NEXTVAL` on Oracle (prod),
      with a configurable `{table}_seq` convention.
- [x] **Write surface across core entities**: customers, order headers, order
      items, jobs, coils, sheet skids, and scrap skids (POST/PUT, server-assigned
      ids, validation, 201/400/404) plus operational PATCH on jobs and coils —
      all tested against the fixture.
- [x] Shipping / EDI surface. → Done (the full schema landed). **Shipping**:
      shipments (GET/POST/PUT + dispatch PATCH) and receiving BOLs (GET/POST/PUT).
      **EDI** (read): outbound transaction ledger (`GET /api/edi/transactions`
      [+ `/{id}`], filter by customer/transaction-set), transmission log
      (`GET /api/edi/log`), and the `edi-types` / `customer-edi` lookups — all
      validated against the live 87k-row ledger.
- [x] **Observability / audit parity**: `AuditMiddleware` records every mutating
      request into the legacy `opc_action_log`, exposed via `GET /api/audit-log`.
- [x] **Authentication**: API-key auth (`X-Api-Key`) gates the `/api` surface
      (`/health`, `/health/ready` + Swagger stay open); swappable for OAuth/OIDC later.
- [x] **Deployment readiness**: multi-stage `Dockerfile` (built **and smoke-tested**
      in CI — the image must boot and serve `/health` + `/health/ready`), CORS for
      a future SPA, a `/` service-info endpoint, and a `requests.http` collection.
- [x] Validate the **Oracle** data-access path against a real database. → Done:
      the read **and** write/update paths were exercised end-to-end against the
      live non-prod Oracle 11g; three live-only bug classes (ORA-01745 reserved
      binds, ORA-00932 COALESCE typing, opaque-500 input) were found and fixed.
      See [`ORACLE_VALIDATION.md`](ORACLE_VALIDATION.md).

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
