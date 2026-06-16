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
- **Node 22** (only for the typed-client demo in `api/clientapp/`).
- **No database needed**: the dev/test profile seeds an in-process SQLite fixture.

```sh
cd api
dotnet test                          # 103 tests (repository + HTTP smoke + units)
dotnet run --project src/ABIS.Api    # Development: seeds SQLite; key dev-local-key
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

The API is deliberately uniform. The full recipe — model, repository SQL (engine-
portable, `:param`, `column AS PascalAlias`), SQLite fixture, endpoint with sorting
via `Data/Sort.cs`, tests, optional demo page — is in
[`docs/NEXT_STEPS.md`](docs/NEXT_STEPS.md) ("Recipe: add a new module slice").

**Don't fabricate schema.** Model only columns recovered in
[`docs/DATA_MODEL.md`](docs/DATA_MODEL.md); widening it needs more DataWindows
exported from the PB IDE.

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
