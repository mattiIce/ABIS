# ABIS Modernization — Next Steps & Handoff

A pickup guide so another session/person can continue without re-discovering
context. Pairs with the strategic [`MODERNIZATION_ROADMAP.md`](MODERNIZATION_ROADMAP.md)
and [`PHASE3_PILOT_PLAN.md`](PHASE3_PILOT_PLAN.md).

## Where things stand (done)

- **Phase 1 – Discovery:** extractors (`tools/`) + docs (architecture, data model,
  inventory, roadmap, pilot plan).
- **Phase 2 – API seam (`api/`):** ASP.NET Core 8 + Dapper. Read/write across the
  core entities; API-key auth; audit middleware → `opc_action_log`; CORS;
  ProblemDetails; Swagger; Dockerfile; OpenAPI artifact. **67 tests, CI green.**
- **Phase 3 – Pilots:** plan + **two end-to-end vertical slices** with demo UIs
  (`order_entry` → `/ui/index.html`, `inv_coil` → `/ui/coils.html`).

All on PR #1 (branch `claude/lucid-wozniak-wfmcz8`).

## Environment notes (read first in a fresh session)

This is an ephemeral Linux container. **No database, no Windows PowerBuilder IDE,
no Docker daemon.** Outbound network + NuGet work.

```sh
# .NET 8 SDK is NOT preinstalled — install it locally:
curl -sSL https://dot.net/v1/dotnet-install.sh | bash -s -- --channel 8.0 --install-dir "$HOME/.dotnet"
export PATH="$HOME/.dotnet:$PATH"

cd api
dotnet test                                   # 67 tests (repository + HTTP)
dotnet run --project src/ABIS.Api             # Dev profile: seeds SQLite, no DB needed
# API key for /api/*: dev-local-key  (header X-Api-Key)
# Demo UIs: http://localhost:5xxx/ui/index.html  and  /ui/coils.html
```

Seeded fixture ids (handy for manual testing): jobs `1001–1003`, coils
`5001–5004`, orders `9001–9002`, order items `7001–7003`, customers `4001–4002`,
sheet skids `3001–3003`, scrap skids `8001–8002`.

## Next steps, prioritized

### Blocked on environment (highest leverage — need the user)
1. **Get DB access (connection string) or a DDL dump.** Unblocks:
   - Validate the **Oracle** data path (CI only exercises SQLite today).
   - Replace the **partial/inferred schema** with the real one; confirm the
     inferred `order_item.order_abc_num` FK and the `order_item_num` PK.
   - Point the Phase-3 pilots at real data.
2. **Locate/regenerate the 7 missing PFE/PFD libraries** (`PFE_ABC.PBL`,
   `pfemain.pbl`, …) so the legacy app builds — prerequisite for the PowerServer
   pilot. See [`ARCHITECTURE.md`](ARCHITECTURE.md) §build-readiness.
3. **Run the Phase-3 pilots** (needs the Windows PB IDE + PowerServer license):
   Path B on `quotation`, Path C greenfield on `order_entry`/`inv_coil` using the
   API + demo UIs as the starting point. Score with the rubric in the pilot plan.

### Doable now without a DB (to keep momentum)
- **More module slices** following the recipe below. Best-supported next:
  **QA / test results** (`pst_test_result` + `temp_test_result` are in the
  schema) — keep standalone, as the coil/job linkage is not in the extract
  (don't fabricate it).
- **List sorting** across the paged grids (allowlisted `sort`/`dir` per resource).
- **Typed client codegen** from the OpenAPI artifact (e.g. NSwag/openapi-generator).
- **Write hardening:** optimistic concurrency (rowversion/ETag), a soft-delete
  policy decision, and replacing the `MAX+1` id assignment with **Oracle
  sequences** once the DB is known (search `NextIdAsync`).
- **Expand the recovered data model** by exporting more DataWindows to text and
  re-running `tools/extract_schema.py`.

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
  client sends `X-Api-Key`. `/health`, `/`, `/swagger`, and `/ui/*` are anonymous.

## Pointers

| Doc | For |
|---|---|
| [`MODERNIZATION_ROADMAP.md`](MODERNIZATION_ROADMAP.md) | Strategy + phased checklist |
| [`PHASE3_PILOT_PLAN.md`](PHASE3_PILOT_PLAN.md) | The PowerServer-vs-greenfield bake-off |
| [`ARCHITECTURE.md`](ARCHITECTURE.md) | As-is system, integration surface, build-readiness |
| [`DATA_MODEL.md`](DATA_MODEL.md) | Recovered schema + inferred relationships |
| [`../api/README.md`](../api/README.md) | Run/test/auth, demo UIs, OpenAPI |
