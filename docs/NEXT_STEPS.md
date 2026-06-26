# ABIS Modernization — Next Steps & Handoff

A pickup guide so another session/person can continue without re-discovering
context. Pairs with the strategic [`MODERNIZATION_ROADMAP.md`](MODERNIZATION_ROADMAP.md)
and [`PHASE3_PILOT_PLAN.md`](PHASE3_PILOT_PLAN.md).

## Where things stand (done)

- **Phase 1 – Discovery:** extractors (`tools/`) + docs (architecture, data model,
  inventory, roadmap, pilot plan).
- **Phase 2 – API seam (`api/`):** ASP.NET Core 8 + Dapper. Read/write across the
  core entities; **allowlisted sorting on every list**; API-key auth; audit
  middleware → `opc_action_log`; liveness + **DB-readiness** health probes; CORS;
  ProblemDetails; Swagger; Dockerfile; **fully-typed OpenAPI contract + generated
  TypeScript client**. **82 tests, CI green.**
- **Phase 3 – Pilots:** plan + **three end-to-end vertical slices** with demo UIs
  (`order_entry` → `/ui/index.html`, `inv_coil` → `/ui/coils.html`,
  QA test results → `/ui/qa.html`).

Foundation (Phases 1–3) is PR #1 (branch `claude/lucid-wozniak-wfmcz8`); the
seam-hardening increment — sorting, the readiness probe, and the QA slice —
continues on branch `claude/sharp-newton-rcnobw`.

## Environment notes (read first in a fresh session)

This is an ephemeral Linux container. **No database, no Windows PowerBuilder IDE,
no Docker daemon.** Outbound network + NuGet work.

```sh
# .NET 8 SDK is NOT preinstalled — install it locally:
curl -sSL https://dot.net/v1/dotnet-install.sh | bash -s -- --channel 8.0 --install-dir "$HOME/.dotnet"
export PATH="$HOME/.dotnet:$PATH"

cd api
dotnet test                                   # 103 tests (repository + HTTP)
dotnet run --project src/ABIS.Api             # Dev profile: seeds SQLite, no DB needed
# API key for /api/*: dev-local-key  (header X-Api-Key)
# Demo UIs: http://localhost:5xxx/ui/index.html , /ui/coils.html , /ui/qa.html
```

Seeded fixture ids (handy for manual testing): jobs `1001–1003`, coils
`5001–5004`, orders `9001–9002`, order items `7001–7003`, customers `4001–4002`,
sheet skids `3001–3003`, scrap skids `8001–8002`.

## Next steps, prioritized

### Blocked on environment (highest leverage — need the user)
1. ~~**Get DB access (connection string) or a DDL dump.**~~ **Done** — a live
   non-prod Oracle 11g (`abc11`) connection was provided. This unblocked:
   - ✅ **Oracle data path validated** — read *and* write/update paths exercised
     live; three live-only bug classes found and fixed (see
     [`ORACLE_VALIDATION.md`](ORACLE_VALIDATION.md)). A secret-gated `oracle-smoke`
     CI job is still available via the `ORACLE_CONNECTION_STRING` secret.
   - ✅ **Real schema recovered** — `DATA_MODEL.md` regenerated from the live
     `DBO` dictionary (412 tables); the `order_item` composite key confirmed (#10).
   - ⏳ Point the Phase-3 pilots at real data (Phase 3 — still ahead).
2. **Locate/regenerate the 7 missing PFE/PFD libraries** (`PFE_ABC.PBL`,
   `pfemain.pbl`, …) so the legacy app builds — prerequisite for the PowerServer
   pilot. See [`ARCHITECTURE.md`](ARCHITECTURE.md) §build-readiness.
3. **Run the Phase-3 pilots** (needs the Windows PB IDE + PowerServer license):
   Path B on `quotation`, Path C greenfield on `order_entry`/`inv_coil` using the
   API + demo UIs as the starting point. Score with the rubric in the pilot plan.

### Doable now without a DB (to keep momentum)
- ✅ **List sorting** across the paged grids — done: allowlisted `sort`/`dir` per
  resource with a PK tie-breaker (`Data/Sort.cs`); invalid input → 400.
- ✅ **QA / test-results slice** — done (standalone): `position` + `from`/`to`
  date-range filters, sorting, and a demo page (`/ui/qa.html`); `temp_test_result`
  added later (see below). The coil/job linkage is still **not** in the extract —
  left unfabricated.
- ✅ **Readiness probe** — done: `GET /health/ready` runs `SELECT 1` (503 when the
  DB is unreachable); liveness stays at `GET /health`.
- ✅ **Production hardening** — done: fixed-window **rate limiting** on `/api`
  (per-API-key partition, `429` + `Retry-After`, tunable via `RateLimiting`) and
  baseline **security headers** (`nosniff`, `DENY`, `no-referrer`) on every response.
- ✅ **Typed contract + client codegen** — done: every endpoint declares response
  types via `.Produces<T>()` / `.ProducesValidationProblem()` (+ a group-wide
  `401`), so the OpenAPI doc carries real schemas. CI generates a typed
  TypeScript client with NSwag and uploads it as the `ts-client` artifact.
- ✅ **Demo UI on the generated client** — done: `clientapp/` is a TypeScript demo
  that imports the generated client, compiled by `tsc` to ES modules under
  `/ui/app/`; `/ui/typed.html` drives the coil screen and a typed create-order
  write. CI compiles it **and** runs an e2e (`clientapp/e2e/run.mjs`) against a
  live API, so a contract break fails the build.
- ✅ **Multi-language codegen** — done: CI also emits a **Python** client
  (`openapi-generator`, `python-client` artifact) from the same contract. Next:
  migrate a real legacy module onto a generated client.
- ✅ **ID generation hardened** — done: ids come from the connection factory's
  dialect-specific next-id SQL — `MAX+1` on SQLite (dev), a sequence `NEXTVAL` on
  Oracle (concurrency-safe), names via the `{table}_seq` convention with per-table
  overrides (`Database:Sequences`). Real sequence names still need DB confirmation.
- ✅ **Read caching** — done: weak `ETag` on `/api` GETs + `If-None-Match` → `304`
  (`ETagMiddleware`). Also a correlation id (`X-Request-Id`) echoed on responses,
  in ProblemDetails, and in the audit notes.
- **Write hardening (remaining):** `If-Match` optimistic concurrency (the read
  ETags are the foundation) and a soft-delete policy. True concurrency needs a
  rowversion column the recovered schema doesn't have — confirm against the real
  schema before adding one. The audit-log insert still uses `MAX+1` (append-only).
- ✅ **More slices from the recovered schema** — added `temp_test_result`
  (in-progress QA, `GET /api/temp-test-results`) and `process_partial_skid`
  (`GET /api/partial-skids` + `GET /api/jobs/{id}/partial-skids`). Remaining
  extracted tables are either too thin to model faithfully
  (`inbound_shipment`/`shipment`/`die`/`return_scrap_item`, 1–2 cols) or
  out-of-API-scope (`abis_ini`, `security_application`).
- ✅ **Contract & onboarding polish** — done: per-operation OpenAPI
  `.WithSummary(...)` (flows into generated-client doc comments); a committed
  `api/openapi.snapshot.json` with a CI drift-check; a root `CONTRIBUTING.md`; and
  the Oracle-validation runbook + gated CI job above.
- **Expand the recovered data model** by exporting *more* DataWindows to text and
  re-running `tools/extract_schema.py` — **needs the PB IDE** (can't export new
  `.srd` here). Bigger modules (`quotation`, `daily_prod`, shipping/EDI) unlock
  once their tables/columns are recovered; don't fabricate columns before then.

## Recipe: add a new module slice

The codebase is deliberately uniform. To add a resource:

1. **Model** → `api/src/ABIS.Api/Models/Entities.cs`; **write DTOs** →
   `Models/Requests.cs`.
2. **Repository** → `Data/IAbisRepository.cs` + `Data/AbisRepository.cs`:
   - SQL uses `:param` placeholders and `column AS PascalAlias` (portable across
     SQLite-via-Dapper and Oracle; Dapper matches case-insensitively).
   - For optional filters, build **only the params you use** via
     `DynamicParameters` (see `GetOrdersAsync`/`GetCoilsAsync`) — keeps Oracle
     positional binding correct.
   - Server-assign ids with `NextIdAsync` inside a transaction.
3. **Fixture** → `Data/SqliteFixture.cs`: add the table + seed rows. **Declare
   decimal columns as `REAL`** (see gotcha below) and dates as `TEXT`.
4. **Endpoints** → `Endpoints/ApiEndpoints.cs` under the authed `/api` group;
   validate with the `Validate(...)` helpers; return `201/400/404` appropriately.
   For a list endpoint, register the resource's sortable fields in `Data/Sort.cs`
   and resolve `sort`/`dir` via `Sort.TryResolve(...)` (→ 400 on a bad field/dir).
5. **Tests** → `tests/ABIS.Api.Tests/` (repository against an isolated fixture +
   HTTP via `WebApplicationFactory`).
6. Optional **demo page** → `src/ABIS.Api/wwwroot/ui/*.html` (vanilla JS).
7. Update `api/README.md` (endpoint table + test count) and the roadmap.

## Gotchas already solved (don't rediscover these)

- **SQLite decimal affinity:** `NUMERIC` columns collapse whole-number decimals to
  INTEGER, giving a column *mixed* storage types across rows, which breaks Dapper's
  compiled deserializer. The fixture uses **`REAL`** for all decimal columns.
- **PBL inventory encoding:** the post-2025-migration libraries store object names
  as **UTF-16LE**, invisible to a plain ASCII scan. `extract_inventory.py` scans
  both ANSI and UTF-16LE; menu/`m_` and structure/`s_` counts are unreliable
  (conflated with menu items) and excluded from headline numbers.
- **Oracle parameter binding:** keep each `:param` used once and let Dapper add
  params in SQL order; avoid passing unreferenced params (use conditional
  `DynamicParameters`). The whole Oracle path is **untested** — verify on a real DB.
- **Auth in tests:** the test factory sets `ApiKeys__Keys__0=test-key` and the
  client sends `X-Api-Key`. `/health`, `/health/ready`, `/`, `/swagger`, and
  `/ui/*` are anonymous.

## Pointers

| Doc | For |
|---|---|
| [`MODERNIZATION_ROADMAP.md`](MODERNIZATION_ROADMAP.md) | Strategy + phased checklist |
| [`PHASE3_PILOT_PLAN.md`](PHASE3_PILOT_PLAN.md) | The PowerServer-vs-greenfield bake-off |
| [`ARCHITECTURE.md`](ARCHITECTURE.md) | As-is system, integration surface, build-readiness |
| [`INTEGRATIONS.md`](INTEGRATIONS.md) | External integration catalog (EDI, serial/WSC32, OPC) |
| [`DATA_MODEL.md`](DATA_MODEL.md) | Full recovered schema (live Oracle, 412 tables) |
| [`../api/README.md`](../api/README.md) | Run/test/auth, demo UIs, OpenAPI |
