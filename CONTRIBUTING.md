# Contributing to ABIS

ABIS is a legacy **PowerBuilder** ERP/MES (the `.pbl`/`.srd`/`.pbt` files at the
repo root) plus a modern **API seam** under [`api/`](api/) that is gradually
modernizing it (see [`docs/MODERNIZATION_ROADMAP.md`](docs/MODERNIZATION_ROADMAP.md)).
Most contributions today land in `api/`; the PowerBuilder app needs the Windows
PB IDE and is not built here.

## Dev environment

- **.NET 8 SDK** (the API). Not preinstalled in CI containers? Install locally:
  ```sh
  curl -sSL https://dot.net/v1/dotnet-install.sh | bash -s -- --channel 8.0 --install-dir "$HOME/.dotnet"
  export PATH="$HOME/.dotnet:$PATH"
  ```
- **Node 22** (for the typed web modules + e2e in `api/clientapp/`).
- **No database needed**: the dev/test profile seeds an in-process SQLite fixture.

```sh
cd api
dotnet test                          # ~1,200 tests (repository + HTTP + units; a full run is ~13 min)
dotnet run --project src/ABIS.Api    # Development: seeds SQLite; key dev-local-key
npm --prefix clientapp test          # client unit tests (vitest)
# typed-client e2e against a running API (~60 tests):
#   ABIS_BASE=http://127.0.0.1:5xxx ABIS_KEY=dev-local-key npm --prefix clientapp run e2e
```

## Branches & PRs

- Branch off `main`; keep PRs focused and green.
- CI (`.github/workflows/ci.yml`) must pass: build + tests, discovery extractors,
  the Docker image build & smoke, the typed-client compile + live e2e, and the
  **OpenAPI snapshot** check (below).
- Don't commit generated artifacts — `openapi.json`, `abis-client.ts`,
  `python-client/`, `clientapp/node_modules`, `clientapp/src/generated` are
  git-ignored. The compiled demo under `wwwroot/ui/app/` **is** committed (it is
  served at runtime).

## Adding an API resource (module slice)

The API is deliberately uniform. To add a resource:

1. **Model** → `api/src/ABIS.Api/Models/Entities.cs`; **write DTOs** → `Models/Requests.cs`.
2. **Repository** → `Data/IAbisRepository.cs` + `Data/AbisRepository.cs`:
   - SQL uses `:param` placeholders and `column AS PascalAlias`, which is portable across
     SQLite-via-Dapper and Oracle (Dapper matches case-insensitively).
   - For optional filters, add only the parameters you use, via `DynamicParameters`
     (see `GetOrdersAsync` / `GetCoilsAsync`).
   - Server-assign ids with `NextIdAsync` inside a transaction, and put the public create method
     behind `RetryOnDuplicateKeyAsync` — a structural test fails if a minting path is not.
3. **Fixture** → `Data/SqliteFixture.cs`: add the table + seed rows. Declare decimal columns as
   `REAL` (see below) and dates as `TEXT`.
4. **Endpoint** → `Endpoints/ApiEndpoints.cs` under the authed `/api` group. Validate with the
   `Validate(...)` helpers and return `201/400/404` appropriately. For a list endpoint, register the
   sortable fields in `Data/Sort.cs` and resolve `sort`/`dir` via `Sort.TryResolve(...)` (→ 400 on
   a bad field or direction). Declare the response type with `.Produces<T>()` — without it the
   generated client returns `Promise<void>` and throws the payload away.
5. **Tests** → `tests/ABIS.Api.Tests/` (repository against an isolated fixture, HTTP via
   `WebApplicationFactory`).
6. **Contract** → refresh `api/openapi.snapshot.json` and regenerate the client (below).

**Don't fabricate schema — and check the data, not just the table.** Model only columns that exist
in [`docs/DATA_MODEL.md`](docs/DATA_MODEL.md) (the live Oracle dictionary). Before building a screen
over a table, check its *recency*: several tables that look populated are dead loads (`PARTS` is a
single 2010 insert; `SHIFT_SCHEDULE` stops in 2009). And before porting a legacy control, find its
*call*, not just its definition — a number of vendored PowerBuilder functions are never invoked.

## Gotchas already solved

- **SQLite decimal affinity.** `NUMERIC` columns collapse whole-number decimals to INTEGER, giving a
  column mixed storage types across rows, which breaks Dapper's compiled deserializer. The fixture
  uses `REAL` for all decimal columns.
- **Oracle-only defects SQLite hides.** A reserved word cannot be a bind name (`:like` →
  `ORA-01745`; CI guards this). PL/SQL resolves static SQL at compile time, so a block cannot
  statically reference a table it creates. The recorded list is
  [`docs/ORACLE_DEFECT_SWEEP.md`](docs/ORACLE_DEFECT_SWEEP.md). Parameters bind by name; an earlier
  belief that ODP.NET was binding positionally was disproven (#324).
- **NSwag arity.** Adding a parameter to a client-exposed GET shifts every positional caller of the
  generated method. Declare new parameters last and check the `clientapp` callers.
- **Page modules have import-time side effects.** `clientapp/src/<page>.ts` bootstraps its page when
  imported, so logic you want to unit-test goes in its own module (see `skid-weight.ts`,
  `edi-transmit-banner.ts`).
- **The API key bypasses RBAC.** Tests and e2e authenticate with `X-Api-Key`, so a green run does not
  prove a signed-in user holds the feature. `/health`, `/health/ready`, `/`, `/swagger` and `/ui/*`
  are anonymous.
- **PBL inventory encoding.** The post-2025 libraries store object names as UTF-16LE;
  `tools/extract_inventory.py` scans both encodings.

## The OpenAPI contract & clients

Every endpoint declares its response types (`.Produces<T>()`) and a short
`.WithSummary(...)`, so the generated clients carry real models and doc comments.

- A reference contract is committed at [`api/openapi.snapshot.json`](api/openapi.snapshot.json).
  CI regenerates the contract and **fails if it drifts** from the snapshot. When a
  change is intended, refresh it:
  ```sh
  cd api
  dotnet build src/ABIS.Api/ABIS.Api.csproj -c Release
  dotnet tool restore
  dotnet tool run swagger tofile --output openapi.snapshot.json src/ABIS.Api/bin/Release/net8.0/ABIS.Api.dll v1
  ```
- Regenerate the typed clients (TS demo + Python) — see
  [`api/README.md`](api/README.md) → *OpenAPI contract & client codegen*.

## Validating the Oracle path

CI exercises only the SQLite fixture. To validate the production Oracle data path,
see [`docs/ORACLE_VALIDATION.md`](docs/ORACLE_VALIDATION.md) (runbook + a
secret-gated CI smoke job).
