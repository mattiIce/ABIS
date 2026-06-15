# ABIS API (modernization Phase 2)

A read-first REST **seam** over the legacy ABIS database. ABIS today is a 2-tier
PowerBuilder client that talks straight to the database with no service tier
(see [`../docs/ARCHITECTURE.md`](../docs/ARCHITECTURE.md)). This API is the
missing integration point every later modernization step builds on
([`../docs/MODERNIZATION_ROADMAP.md`](../docs/MODERNIZATION_ROADMAP.md), Phase 2).

> **Scope:** read-only (GET) endpoints for the core entities. Writes are
> deliberately deferred until the seam is proven in production.

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
dotnet test                                # 16 tests: repository + HTTP smoke
```

## Endpoints

| Method & path | Description |
|---|---|
| `GET /health` | Liveness probe |
| `GET /api/jobs?page&pageSize&status` | List production jobs (paged) |
| `GET /api/jobs/{abJobNum}` | One job |
| `GET /api/jobs/{abJobNum}/coils` | Coils processed by a job (joined) |
| `GET /api/coils?page&pageSize&status` | List coils (paged) |
| `GET /api/coils/{coilAbcNum}` | One coil |
| `GET /api/orders?page&pageSize` | List customer orders (paged) |
| `GET /api/orders/{orderAbcNum}` | One order |
| `GET /api/order-items?page&pageSize&alloy` | List order items (paged) |
| `GET /api/order-items/{orderItemNum}` | One order item |
| `GET /api/test-results?page&pageSize&testType` | List mechanical test results (paged) |

Collections return a paged envelope: `{ items, page, pageSize, totalCount, totalPages }`.

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
