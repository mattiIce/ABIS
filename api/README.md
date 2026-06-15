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
# browse http://localhost:5xxx/swagger
```

The Development profile (`appsettings.Development.json`) uses
`Provider=Sqlite`, `Seed=true`, so the API comes up populated with sample data
and needs no external database.

## Test

```sh
cd api
dotnet test                                # 48 tests: repository + HTTP smoke
```

## Endpoints

| Method & path | Description |
|---|---|
| `GET /health` | Liveness probe |
| `GET /api/jobs?page&pageSize&status` | List production jobs (paged) |
| `GET /api/jobs/{abJobNum}` | One job |
| `GET /api/jobs/{abJobNum}/coils` | Coils processed by a job (joined) |
| `GET /api/jobs/{abJobNum}/skids` | Finished sheet skids for a job |
| `GET /api/jobs/{abJobNum}/scrap` | Scrap skids for a job |
| `POST /api/jobs` | Create a production job → 201 |
| `PATCH /api/jobs/{abJobNum}` | Update job status / notes / men / finish time |
| `GET /api/coils?page&pageSize&status` | List coils (paged) |
| `GET /api/coils/{coilAbcNum}` | One coil |
| `POST /api/coils` | Create a coil on receipt (requires `coilAlloy2`) → 201 |
| `PATCH /api/coils/{coilAbcNum}` | Update coil status / location / notes |
| `GET /api/orders?page&pageSize` | List customer orders (paged) |
| `GET /api/orders/{orderAbcNum}` | One order |
| `POST /api/orders` | Create an order header (server-assigned id) → 201 |
| `PUT /api/orders/{orderAbcNum}` | Replace an order header |
| `GET /api/order-items?page&pageSize&alloy` | List order items (paged) |
| `GET /api/order-items/{orderItemNum}` | One order item |
| `POST /api/order-items` | Create an order item (requires `enduserPartNum`) → 201 |
| `PUT /api/order-items/{orderItemNum}` | Replace an order item |
| `GET /api/customers?page&pageSize&name` | List customers (paged) |
| `GET /api/customers/{customerId}` | One customer |
| `POST /api/customers` | Create a customer (server-assigned id) → 201 |
| `PUT /api/customers/{customerId}` | Replace a customer |
| `GET /api/sheet-skids?page&pageSize` | List finished sheet skids (paged) |
| `GET /api/sheet-skids/{sheetSkidNum}` | One sheet skid |
| `POST /api/sheet-skids` | Create a sheet skid (requires `abJobNum`) → 201 |
| `GET /api/scrap-skids?page&pageSize` | List scrap skids (paged) |
| `GET /api/scrap-skids/{scrapSkidNum}` | One scrap skid |
| `POST /api/scrap-skids` | Create a scrap skid (requires `scrapAbJobNum`) → 201 |
| `GET /api/test-results?page&pageSize&testType` | List mechanical test results (paged) |
| `GET /api/audit-log?page&pageSize&source` | List the action/audit log, newest first |

Collections return a paged envelope: `{ items, page, pageSize, totalCount, totalPages }`.

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
`ab_job.order_item_num`.
