# ABIS Modernization — Next Steps & Handoff

A pickup guide so another session/person can continue without re-discovering
context. Pairs with the strategic [`MODERNIZATION_ROADMAP.md`](MODERNIZATION_ROADMAP.md)
and [`PHASE3_PILOT_PLAN.md`](PHASE3_PILOT_PLAN.md).

## Where things stand (done)

- **Phase 1 – Discovery:** extractors (`tools/`) + docs (architecture, full data
  model, inventory, roadmap). The remaining-area PB source is exported and vendored
  under [`../legacy/src/`](../legacy/src/README.md).
- **Phase 2 – API seam (`api/`):** ASP.NET Core 8 + Dapper, ~160 endpoints over 31
  tags; allowlisted sorting; API-key **and** OIDC/JWT auth; audit → `opc_action_log`;
  liveness + DB-readiness probes; rate limiting; ETag/If-Match; CORS; Swagger;
  Dockerfile; **typed OpenAPI contract + generated TS/Python clients**. **167 xUnit
  tests + 58 typed e2e, CI green.** Oracle data path validated live.
- **Phase 3/4 – Greenfield modules (feature-complete):** every business library in
  `lion.pbt`'s LibList is rebuilt as a typed web module (~34 screens) on the API,
  each from the vendored real source and cross-checked against the Oracle columns
  ([`data-model/BACKCHECK.md`](data-model/BACKCHECK.md)). Thin modules first built
  from docs were widened to full schemas; security authorization enforcement and
  receiving coil-minting are in. **Remaining is production rollout, not features.**

## Environment notes (read first in a fresh session)

This is an ephemeral Linux container. **No database, no Windows PowerBuilder IDE,
no Docker daemon.** Outbound network + NuGet work.

```sh
# .NET 8 SDK is NOT preinstalled — install it locally:
curl -sSL https://dot.net/v1/dotnet-install.sh | bash -s -- --channel 8.0 --install-dir "$HOME/.dotnet"
export PATH="$HOME/.dotnet:$PATH"

cd api
dotnet test                                   # 167 tests (repository + HTTP)
dotnet run --project src/ABIS.Api             # Dev profile: seeds SQLite, no DB needed
# API key for /api/*: dev-local-key  (header X-Api-Key)
# Web modules: http://localhost:5xxx/ui/order-entry.html , /ui/reporting.html , /ui/security.html , … (~34 pages)
# Typed e2e against a running API: ABIS_BASE=… ABIS_KEY=… npm --prefix clientapp run e2e   (58 tests)
```

Seeded fixture ids (handy for manual testing): jobs `1001–1003`, coils
`5001–5004`, orders `9001–9002`, order items `7001–7003`, customers `4001–4002`,
sheet skids `3001–3003`, scrap skids `8001–8002`.

## Next steps, prioritized

The greenfield build is feature-complete; remaining work is **production rollout**.

### 1. Oracle non-prod validation sweep  *(highest leverage)*
The original `order_entry` pilot ran live, but the modules built since have only been
exercised on the SQLite fixture + e2e (plus the gated `oracle-smoke` job). Point the API
at non-prod Oracle (`abc11`) and exercise the newer read/write paths to flush any
live-only issues — the recurring traps are ORA-01745 (reserved-word binds), ORA-00932
(CHAR-null COALESCE), and Int64→numeric unboxing (all coded against, none CI-proven on
the new SQL). See [`ORACLE_VALIDATION.md`](ORACLE_VALIDATION.md).

### 2. OIDC rollout
Register the provider (browser `Auth:Oidc` + API `Auth:Jwt`, see
[`../api/README.md`](../api/README.md)); map the OIDC login → `security_user.login_id`;
then broaden the per-feature **enforcement** (`RequireFeatureAsync`, already on the
security-admin writes) to other mutating routes per a rollout policy.

### 3. Wire the 861 EDI
`POST /api/receiving-bols/{id}/generate-861` is a documented stub; wire it to the
per-customer Oracle functions (`f_edi_*_861`) gated on `customer.create_861_at_receiving`.

### 4. Edge / OPC
The edge service skeleton ([`EDGE_SERVICE.md`](EDGE_SERVICE.md)) needs the Softing DA→UA
bridge + per-device serial formats (needs shop-floor hardware).

### 5. Per-module production cutover (Phase 4)
Roll modules over against the live DB in dependency order (read-only first), legacy + new
on one DB until each is proven, then decommission. See [`PHASE4_CUTOVER_PLAN.md`](PHASE4_CUTOVER_PLAN.md).

### Housekeeping
- `SqliteFixture` drop-list idempotency: dev-only re-seed across schema changes can hit
  "table already exists" (CI is always fresh) — make the drop block cover every created table.
- Low-value reference lookups not yet modeled (alloy heat-treatment, metal density,
  yield strength) — add if a screen needs them.


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
  `DynamicParameters`). The Oracle path was validated live for the original modules;
  re-verify newer modules' write paths on a real DB (see prioritized step 1).
- **Auth in tests:** the test factory sets `ApiKeys__Keys__0=test-key` and the
  client sends `X-Api-Key`. `/health`, `/health/ready`, `/`, `/swagger`, and
  `/ui/*` are anonymous.

## Pointers

| Doc | For |
|---|---|
| [`MODERNIZATION_ROADMAP.md`](MODERNIZATION_ROADMAP.md) | Strategy + phased checklist |
| [`PHASE3_PILOT_PLAN.md`](PHASE3_PILOT_PLAN.md) | The PowerServer-vs-greenfield bake-off |
| [`PHASE3_PILOT_LOG.md`](PHASE3_PILOT_LOG.md) | Live pilot results + scoring (Path C executed; Path B blocked) |
| [`PHASE4_CUTOVER_PLAN.md`](PHASE4_CUTOVER_PLAN.md) | Module-by-module migration: sequencing, procedure, rollback |
| [`ARCHITECTURE.md`](ARCHITECTURE.md) | As-is system, integration surface, build-readiness |
| [`INTEGRATIONS.md`](INTEGRATIONS.md) | External integration catalog (EDI, serial/WSC32, OPC) |
| [`EDGE_SERVICE.md`](EDGE_SERVICE.md) | Shop-floor edge service (serial scales/gauges → HTTP) |
| [`DATA_MODEL.md`](DATA_MODEL.md) | Full recovered schema (live Oracle, 412 tables) |
| [`../api/README.md`](../api/README.md) | Run/test/auth, demo UIs, OpenAPI |
| [`DEPLOY.md`](DEPLOY.md) | Run the API + greenfield UIs on a server (Docker Compose) |
