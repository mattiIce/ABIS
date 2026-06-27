# ABIS

ABIS is a desktop **ERP / manufacturing-execution system for an aluminum
coil → sheet processing plant**, built in **PowerBuilder** (internal application
name `lion`; codebase nicknamed "silverdome"). It covers quotation, order entry,
coil receiving, inventory, shop-floor production jobs, QA/mechanical testing and
certification, skid/scrap handling, warehouse, shipping/EDI, and accounting,
plus direct integration with plant-floor hardware (scales/gauges over serial and
PLCs over OPC).

> **This repository is undergoing a modernization effort (greenfield, strangler-fig).**
> - **Phase 1 — discovery & roadmap** under [`docs/`](docs/): analysis, reproducible
>   tooling, the full recovered data model, and the plan.
> - **Phase 2 — the API seam** under [`api/`](api/README.md): an ASP.NET Core 8 REST
>   API over the database (Oracle in production; a seeded SQLite fixture for dev/CI),
>   with a fully-typed OpenAPI contract + generated TypeScript client.
> - **Phase 3/4 — greenfield modules (in progress, far along):** every business
>   library in the legacy target is now rebuilt as a typed web module on that API —
>   order entry, jobs, coil inventory & ownership transfer, skids/warehouse, sales,
>   quotation, QA & coil-evaluation, recovery, accounting, EDI, OPC log, downtime,
>   maintenance, scan, dies, parts, receiving (with coil-minting), shifts, shipping,
>   sketches, security/authorization, the DAS & stacker shop-floor consoles, the
>   production folder, and a production/customer/inventory/QA **reporting** suite.
>   The legacy PowerBuilder source for these areas is vendored under
>   [`legacy/src/`](legacy/src/README.md) so each was built against the **real**
>   tables/columns. Remaining work is production rollout (Oracle cutover, OIDC
>   rollout, the edge/OPC hardware bridge) — see [`docs/NEXT_STEPS.md`](docs/NEXT_STEPS.md).

## Documentation

| Document | What's in it |
|---|---|
| [`docs/NEXT_STEPS.md`](docs/NEXT_STEPS.md) | **Start here to continue** — handoff guide: current state, prioritized next steps, environment notes, the module-slice recipe, and solved gotchas. |
| [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) | As-is architecture: stack, 2-tier topology, the two app targets (`lion` + the `da` data-acquisition app), module map, integration surface, the Aug-2025 PB migration, and build-readiness issues. |
| [`docs/DATA_MODEL.md`](docs/DATA_MODEL.md) | **Full database model (412 tables)** recovered from a live Oracle data-dictionary dump of the `DBO` schema — real columns, PKs, FKs, indexes, and sequences. Supersedes the earlier partial DataWindow-inferred model. |
| [`docs/OBJECT_INVENTORY.md`](docs/OBJECT_INVENTORY.md) | Approximate object inventory (~1,345 DataWindows, ~588 windows, …) recovered from the compiled libraries, per-library and grouped by domain. |
| [`docs/MODERNIZATION_ROADMAP.md`](docs/MODERNIZATION_ROADMAP.md) | Strategic options, the greenfield/strangler-fig approach, and the phased plan with status. |
| [`docs/data-model/BACKCHECK.md`](docs/data-model/BACKCHECK.md) | Verification of each built module's schema against the real DataWindow/Oracle columns. |
| [`docs/ORACLE_VALIDATION.md`](docs/ORACLE_VALIDATION.md) | Oracle data-path validation runbook + the live-only bug classes found and fixed. |
| [`docs/INTEGRATIONS.md`](docs/INTEGRATIONS.md) · [`docs/EDGE_SERVICE.md`](docs/EDGE_SERVICE.md) | External integrations (EDI/serial/OPC) and the shop-floor edge service. |
| [`docs/INSTALL.md`](docs/INSTALL.md) | **One-command native install** on Ubuntu — systemd service + nginx + HTTPS (Let's Encrypt). The Docker-free path. |
| [`docs/DEPLOY.md`](docs/DEPLOY.md) | Run the API + greenfield UIs on a server (Docker Compose). |
| [`legacy/src/README.md`](legacy/src/README.md) | The vendored legacy PB source per area + which greenfield module each maps to. |

## Reproducing the analysis

The docs are backed by deterministic extractors (Python 3, standard library
only — no dependencies). Re-run them any time the sources change:

```sh
python3 tools/ingest_oracle_schema.py  # live Oracle dump -> docs/data-model/oracle_schema.json + docs/DATA_MODEL.md
python3 tools/extract_schema.py .      # DataWindow cross-check -> docs/data-model/schema.json
python3 tools/extract_inventory.py .   # -> docs/inventory/objects.json
```

- `tools/ingest_oracle_schema.py` parses a live Oracle data-dictionary dump
  (`docs/data-model/oracle_schema.txt`, produced by `tools/oracle_introspect.sql`)
  into the full schema — this is the **authoritative** source for `DATA_MODEL.md`.
- `tools/extract_schema.py` parses the exported DataWindow/query sources
  (`*.srd`, `*.srq`) for `table.column` bindings, types, and joins (now a partial
  cross-check; superseded by the live model above).
- `tools/extract_inventory.py` scans the compiled `*.pbl` libraries (ANSI **and**
  UTF-16LE, since the live libraries are Unicode after the 2025 migration) for
  object names, grouped by PowerBuilder naming convention.

## Important caveats

- The root `.pbl` files are **compiled binaries**; the original PowerScript event
  bodies aren't recovered. The greenfield modules are rebuilt from the **exported
  text source** (DataWindows/windows) vendored under [`legacy/src/`](legacy/src/README.md)
  and the authoritative Oracle DDL — not from guesses.
- The data model is **complete**: `docs/DATA_MODEL.md` is regenerated from a live
  Oracle data-dictionary dump (412 tables, PKs/FKs/indexes/sequences).
- **The legacy target builds as committed**: all 50 libraries in `lion.pbt`'s
  LibList are present (the 7 previously-missing PFE/PFD libraries were located and
  committed).
- The one piece that stays DB-side by design is the per-customer **861 EDI**
  generation (Oracle PL/SQL functions) — the greenfield API exposes the trigger
  point and documents the wiring.

## Repository layout

```
*.pbl                 PowerBuilder libraries (compiled, binary; legacy)
*.srd *.srq *.src     Exported DataWindow / query / event sources (text)
abis.pbw  lion.pbt    PowerBuilder workspace / target (legacy)
lion_mig.log          PowerBuilder migration report (2025-08-26)
api/                  Greenfield ASP.NET Core API + typed web modules (clientapp/)
edge/                 Shop-floor edge service (serial scales/gauges → HTTP)
deploy/               Native Ubuntu installer (systemd unit, install/uninstall, nginx)
legacy/src/           Vendored PB text source for the rebuilt areas (reference)
docs/                 Modernization discovery, data model & roadmap
tools/                Reproducible analysis extractors
```
