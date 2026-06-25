# Validating the Oracle data path

CI only exercises the seeded **SQLite** fixture, so the production **Oracle** path
(driver, dialect SQL, sequences) is unverified until run against a real database.
This is the top user-blocked item in [`NEXT_STEPS.md`](NEXT_STEPS.md). This runbook
makes that validation turnkey once you can provide a connection.

> Use a **non-production** Oracle (a test/staging copy of the ABIS schema). The API
> issues real SQL; point it at prod only with explicit sign-off.

## 1. Connectivity smoke (no schema needed)

Confirms the driver connects and the dialect probe works (`SELECT 1 FROM dual`):

```sh
cd api
dotnet build src/ABIS.Api/ABIS.Api.csproj -c Release
Database__Provider=Oracle \
Database__Seed=false \
Database__ConnectionString="User Id=abis;Password=...;Data Source=//host:1521/ORCLPDB1" \
ASPNETCORE_ENVIRONMENT=Production \
ASPNETCORE_URLS=http://127.0.0.1:5230 \
dotnet run --project src/ABIS.Api -c Release --no-build &
curl -fsS http://127.0.0.1:5230/health        # liveness
curl -fsS http://127.0.0.1:5230/health/ready   # -> {"status":"ready"} means Oracle is reachable
```

A `503 {status:"unavailable"}` means the connection or the probe failed — check the
connection string and network reachability.

### Gated CI job

`.github/workflows/ci.yml` has an **`oracle-smoke`** job that runs this readiness
check automatically **when (and only when) the `ORACLE_CONNECTION_STRING` repo
secret is set** (otherwise it is a no-op). Set the secret to a non-prod Oracle that
the runner can reach (GitHub-hosted runners may need network access or a
self-hosted runner inside your network).

## 2. Functional validation (needs the ABIS schema)

Against an Oracle carrying the ABIS tables, exercise the API and check the
behaviours that differ from SQLite and so are **not** covered by CI:

| Check | How | What to confirm |
|---|---|---|
| **Paging bind order** | `GET /api/coils?pageSize=2&page=2&sort=coilAbcNum` | Returns the *second* page (not empty / not page 1). Guards the Oracle ROWNUM pagination (`:maxRow`/`:minRow`) positional binding. 11g-compatible — the 12c `OFFSET … FETCH NEXT` clause raises ORA-00933 on 11g. |
| **Sorting** | `GET /api/jobs?sort=jobStatus&dir=desc` | Rows ordered by status desc, with the PK tie-breaker. |
| **Server-assigned ids (sequences)** | `POST /api/customers` | Returns `201` with a new id. Requires the table's sequence to exist — default name `{table}_seq`; override via `Database__Sequences__<table>` (see `api/README.md`). |
| **Filters** | `GET /api/coils?alloy=3003` | Only matching rows. |
| **Readiness** | `GET /api/coils/summary?groupBy=alloy` | Aggregations return real rollups. |

### Reconcile the inferred schema

The API introduces two **inferred** relationships (flagged in
[`DATA_MODEL.md`](DATA_MODEL.md) and `api/README.md`):

- `order_item.order_item_num` treated as the PK,
- `order_item.order_abc_num` as the FK to `customer_order`.

Confirm these against the real schema; if they differ, adjust
`Models/Entities.cs` / `Data/AbisRepository.cs` and the seed fixture accordingly.

## 3. Replace the partial schema

Once a DDL dump or live connection is available, extend
[`../tools/extract_schema.py`](../tools/extract_schema.py) to ingest it and
regenerate [`DATA_MODEL.md`](DATA_MODEL.md) with full tables/PKs/FKs/indexes,
replacing the partial model recovered from DataWindows.
