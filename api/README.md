# ABIS API (modernization Phase 2)

A read-first REST **seam** over the legacy ABIS database. ABIS today is a 2-tier
PowerBuilder client that talks straight to the database with no service tier
(see [`../docs/ARCHITECTURE.md`](../docs/ARCHITECTURE.md)). This API is the
missing integration point every later modernization step builds on
([`../docs/MODERNIZATION_ROADMAP.md`](../docs/MODERNIZATION_ROADMAP.md), Phase 2).

> **Scope:** read (GET) endpoints across the core entities, plus a small,
> proven **write** surface — customer master data (POST/PUT) and operational
> partial updates (PATCH) to jobs and coils. Broader writes follow as the seam
> is accepted.

## Stack

- **ASP.NET Core 8** minimal APIs
- **Dapper** for data access (portable SQL across engines)
- **Oracle** in production (`Oracle.ManagedDataAccess.Core`)
- **SQLite** for local dev / CI via a seeded in-process fixture
- **Swagger / OpenAPI** (served at `/swagger` in Development)

## Layout

```
api/
  src/ABIS.Api/
    Program.cs              app wiring (DI, config, Swagger, seeding)
    Endpoints/              minimal-API route definitions
    Models/                 read models (shapes follow docs/DATA_MODEL.md)
    Data/                   connection factory, repository (Dapper), SQLite fixture
  tests/ABIS.Api.Tests/     xUnit: repository + in-process HTTP smoke tests
```

## Run locally

Requires the .NET 8 SDK.

```sh
cd api
dotnet run --project src/ABIS.Api          # Development profile: seeds SQLite
# browse http://localhost:5xxx/swagger          (API explorer)
# browse http://localhost:5xxx/ui/index.html    (order-entry demo UI)
```

The Development profile (`appsettings.Development.json`) uses
`Provider=Sqlite`, `Seed=true`, so the API comes up populated with sample data
and needs no external database.

### Demo UIs

Dependency-free (vanilla JS, no build step) pages under `wwwroot/ui/`, serving as
**Path C greenfield references** (see
[`../docs/PHASE3_PILOT_PLAN.md`](../docs/PHASE3_PILOT_PLAN.md)) and manual test
harnesses. Paste the dev API key (`dev-local-key`) into the header field; the
two pages cross-link.

- **`/ui/index.html`** — order entry: search/filter orders, view header +
  customer + lines, save a new order with line items.
- **`/ui/coils.html`** — coil inventory: filter coils, view a coil + its
  processing history, receive a coil, and an alloy/location weight rollup.
- **`/ui/qa.html`** — QA test results: filter mechanical test results by type,
  position, and date range, with click-to-sort (server-side) column headers.

## Test

```sh
cd api
dotnet test                                # 81 tests: repository + HTTP smoke
```

`api/requests.http` has ready-to-run sample calls (VS Code REST Client / JetBrains).

### OpenAPI contract

The Swagger/OpenAPI document is served at `/swagger/v1/swagger.json` at runtime.
To emit it as a file (e.g. for client codegen) — CI also does this and uploads it
as the `openapi` artifact:

```sh
cd api
dotnet build src/ABIS.Api/ABIS.Api.csproj -c Release
dotnet tool restore
dotnet tool run swagger tofile --output openapi.json src/ABIS.Api/bin/Release/net8.0/ABIS.Api.dll v1
```

## Container

```sh
# build context is the api/ directory
docker build -f api/Dockerfile -t abis-api:latest api
docker run -p 8080:8080 \
  -e Database__Provider=Oracle \
  -e Database__ConnectionString="User Id=abis;Password=...;Data Source=//host:1521/ORCLPDB1" \
  -e ApiKeys__Keys__0="<a-strong-key>" \
  abis-api:latest
# -> http://localhost:8080/   (Kestrel listens on 8080 in the container)
```

CI builds this image on every PR (see `.github/workflows/ci.yml`).

## Endpoints

| Method & path | Description |
|---|---|
| `GET /` | Service info (name, version, environment, links) |
| `GET /health` | Liveness probe (process up; no dependencies touched) |
| `GET /health/ready` | Readiness probe (database reachable); 503 when not |
| `GET /api/jobs?page&pageSize&status&sort&dir` | List production jobs (paged, sortable) |
| `GET /api/jobs/{abJobNum}` | One job |
| `GET /api/jobs/{abJobNum}/coils` | Coils processed by a job (joined) |
| `GET /api/jobs/{abJobNum}/skids` | Finished sheet skids for a job |
| `GET /api/jobs/{abJobNum}/scrap` | Scrap skids for a job |
| `POST /api/jobs` | Create a production job → 201 |
| `PATCH /api/jobs/{abJobNum}` | Update job status / notes / men / finish time |
| `GET /api/coils?page&pageSize&status&alloy&location&customerId&sort&dir` | List coils (paged, filterable, sortable) |
| `GET /api/coils/summary?groupBy=alloy\|location` | Inventory weight rollup (count + net wt + balance) |
| `GET /api/coils/{coilAbcNum}` | One coil |
| `GET /api/coils/{coilAbcNum}/processing` | A coil's processing history (consuming jobs) |
| `POST /api/coils` | Create a coil on receipt (requires `coilAlloy2`) → 201 |
| `PATCH /api/coils/{coilAbcNum}` | Update coil status / location / notes |
| `GET /api/orders?page&pageSize&customerId&po&sort&dir` | List customer orders (paged, filterable, sortable) |
| `GET /api/orders/{orderAbcNum}` | One order header |
| `GET /api/orders/{orderAbcNum}/items` | Line items for an order |
| `GET /api/orders/{orderAbcNum}/full` | Order header + customer + items (order-entry read model) |
| `POST /api/orders` | Create an order header (server-assigned id) → 201 |
| `POST /api/orders/with-items` | Create an order + its line items in one transaction → 201 |
| `PUT /api/orders/{orderAbcNum}` | Replace an order header |
| `GET /api/order-items?page&pageSize&alloy&sort&dir` | List order items (paged, sortable) |
| `GET /api/order-items/{orderItemNum}` | One order item |
| `POST /api/order-items` | Create an order item (requires `enduserPartNum`) → 201 |
| `PUT /api/order-items/{orderItemNum}` | Replace an order item |
| `GET /api/customers?page&pageSize&name&sort&dir` | List customers (paged, sortable) |
| `GET /api/customers/{customerId}` | One customer |
| `POST /api/customers` | Create a customer (server-assigned id) → 201 |
| `PUT /api/customers/{customerId}` | Replace a customer |
| `GET /api/sheet-skids?page&pageSize&sort&dir` | List finished sheet skids (paged, sortable) |
| `GET /api/sheet-skids/{sheetSkidNum}` | One sheet skid |
| `POST /api/sheet-skids` | Create a sheet skid (requires `abJobNum`) → 201 |
| `GET /api/scrap-skids?page&pageSize&sort&dir` | List scrap skids (paged, sortable) |
| `GET /api/scrap-skids/{scrapSkidNum}` | One scrap skid |
| `POST /api/scrap-skids` | Create a scrap skid (requires `scrapAbJobNum`) → 201 |
| `GET /api/test-results?page&pageSize&testType&position&from&to&sort&dir` | List mechanical test results (paged, filterable, sortable) |
| `GET /api/lookups/alloys` | Distinct alloys (dropdown reference data) |
| `GET /api/audit-log?page&pageSize&source&sort&dir` | List the action/audit log, newest first (sortable) |

Collections return a paged envelope: `{ items, page, pageSize, totalCount, totalPages }`.

**Sorting.** List endpoints accept `sort` (a field name) and `dir` (`asc`/`desc`,
default `asc`). Sortable fields are **allowlisted per resource** and mapped to
physical columns server-side (so only known columns and a validated direction
reach the SQL — injection-safe); a stable tie-breaker (usually the primary key)
is appended for deterministic paging. An unknown `sort` field or a bad `dir`
returns `400` with a ProblemDetails listing the allowed fields. Without `sort`,
each list keeps its natural default order (e.g. test results and the audit log
default to newest-first).

**Readiness vs liveness.** `GET /health` is a cheap liveness check (the process
is up). `GET /health/ready` opens a database connection and runs `SELECT 1`,
returning `200 {status:"ready"}` or `503 {status:"unavailable"}` — point an
orchestrator's readiness gate here so traffic is held until the data path serves.
Both are anonymous.

**Audit trail.** Every mutating request (POST/PUT/PATCH/DELETE under `/api`) is
recorded in the legacy `opc_action_log` table by `AuditMiddleware` (source =
`"{method} {path}"`, success = HTTP status < 400). Auditing is best-effort and
never fails the request. Read it back via `GET /api/audit-log`.

**Write semantics.** `POST /api/customers` requires `customerName` (else 400) and
returns 201 with a `Location` header. `PATCH` applies a partial update — omitted
(null) fields are left unchanged (so a field cannot be cleared to null via PATCH),
and an unknown id returns 404. The customer id is server-assigned via `MAX+1`
inside a transaction; a production Oracle deployment should back this with a
sequence for concurrency.

## Authentication

All `/api/*` endpoints require an **API key** in the `X-Api-Key` header; `/health`
and Swagger stay anonymous. Endpoints only require an authenticated principal, so
the `ApiKey` scheme can later be replaced by OAuth/OIDC without touching them.

```sh
curl -H "X-Api-Key: dev-local-key" http://localhost:5xxx/api/jobs
```

Configure via the `ApiKeys` section (keys belong in a secret store / environment,
never in source):

```sh
export ApiKeys__Enabled="true"
export ApiKeys__Keys__0="<a-strong-key>"
export ApiKeys__Keys__1="<another-key>"     # multiple keys supported
```

The dev profile ships a throwaway key (`dev-local-key`). Set `ApiKeys__Enabled=false`
only on a trusted internal network. In Swagger UI, use **Authorize** to supply the key.

## Configuration (production / Oracle)

Set the `Database` section — preferably via environment variables so secrets
stay out of source:

```sh
export Database__Provider="Oracle"
export Database__Seed="false"
export Database__ConnectionString="User Id=abis;Password=...;Data Source=//host:1521/ORCLPDB1"
export ASPNETCORE_ENVIRONMENT="Production"
dotnet run --project src/ABIS.Api
```

The repository SQL is engine-portable (`:name` parameters; columns aliased to
model property names; dialect-specific paging supplied by the connection
factory). The Oracle path is wired and compiles, but is **not exercised by CI**
(no Oracle instance available) — validate it against a real database before
relying on it. The model property names and table shapes mirror the *partial*,
recovered data model; reconcile against the real schema (Phase 1) as it is
completed. `order_item.order_item_num` is treated as the PK by inference from
`ab_job.order_item_num`, and `order_item.order_abc_num` is an **inferred FK** to
`customer_order` (order entry requires an order↔item link) — both pending
confirmation against the real schema.
