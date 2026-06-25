# Validating the Oracle data path

CI only exercises the seeded **SQLite** fixture, so the production **Oracle** path
(driver, dialect SQL, sequences) is unverified until run against a real database.
This is the top user-blocked item in [`NEXT_STEPS.md`](NEXT_STEPS.md). This runbook
makes that validation turnkey once you can provide a connection.

> Use a **non-production** Oracle (a test/staging copy of the ABIS schema). The API
> issues real SQL; point it at prod only with explicit sign-off.

## Validation results — run against Oracle 11g (2026-06-25)

The seam was run against the live ABIS database (**Oracle 11g**, SID `abc11`).
Summary: the **read path is fully validated**; the **write path surfaced two
schema mismatches** and is deferred (the API is read-first).

**Passed**

- Connectivity / readiness probe (`/health/ready` → `ready`).
- List + paging **bind order** (`/api/coils?pageSize=2&page=2` returns the true
  second page, not a repeat of page 1).
- Sorting + PK tie-breaker (`/api/jobs?sort=jobStatus&dir=desc`).
- Filters (`/api/coils?alloy=…`) and aggregation rollups (`/api/coils/summary`),
  against real data (~149k coils).

**Bugs found and fixed** (only a live 11g exposed these; CI runs SQLite)

- `ORA-00933` — the Oracle paging clause used the 12c+ `OFFSET … FETCH NEXT`
  syntax, invalid on 11g. Replaced with the `ROWNUM` inline-view form (PR #4).
- `ORA-00911` — that ROWNUM view used the alias `__p`; Oracle rejects unquoted
  identifiers starting with `_`. Renamed to `pg` (PR #5).

**Open write-path findings (deferred — need schema/DBA input)**

- **Sequences don't exist.** `POST /api/customers` → `ORA-02289: sequence does
  not exist` for `customer_seq`. The `{table}_seq` convention does not match the
  schema. Before enabling writes, confirm how ABIS assigns ids (the legacy PB9
  app likely uses `MAX+1`, or sequences under other names) and either switch the
  Oracle `NextIdQuery` to `MAX+1` or map real names via `Database__Sequences__<table>`.
- **Audit table missing.** Every request's audit write → `ORA-00942: table or
  view does not exist` for `opc_action_log` (swallowed as a warning, so requests
  still succeed — auditing silently no-ops). Confirm the real audit/log table
  name and `GRANT`s, or make the audit no-op explicit when the table is absent.

> Note: the read tests above were run with a temporary, read-only DB account.
> Write validation needs an account with INSERT + sequence privileges.

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
