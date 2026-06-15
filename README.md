# ABIS

ABIS is a desktop **ERP / manufacturing-execution system for an aluminum
coil → sheet processing plant**, built in **PowerBuilder** (internal application
name `lion`; codebase nicknamed "silverdome"). It covers quotation, order entry,
coil receiving, inventory, shop-floor production jobs, QA/mechanical testing and
certification, skid/scrap handling, warehouse, shipping/EDI, and accounting,
plus direct integration with plant-floor hardware (scales/gauges over serial and
PLCs over OPC).

> **This repository is undergoing a modernization effort.**
> - **Phase 1 — discovery & roadmap** is captured under [`docs/`](docs/)
>   (analysis, reproducible tooling, planning; no legacy behavior changed).
> - **Phase 2 — the API seam** is under [`api/`](api/README.md): a read-first
>   ASP.NET Core 8 REST API over the core entities (Oracle in production; a
>   seeded SQLite fixture for local dev / CI).

## Documentation

| Document | What's in it |
|---|---|
| [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) | As-is architecture: stack, 2-tier topology, the two app targets (`lion` + the `da` data-acquisition app), module map, integration surface, the Aug-2025 PB migration, and build-readiness issues. |
| [`docs/DATA_MODEL.md`](docs/DATA_MODEL.md) | Partial database model (20 tables / 140 columns) recovered from the DataWindow sources, with explicit and inferred relationships. |
| [`docs/OBJECT_INVENTORY.md`](docs/OBJECT_INVENTORY.md) | Approximate object inventory (~1,345 DataWindows, ~588 windows, …) recovered from the compiled libraries, per-library and grouped by domain. |
| [`docs/MODERNIZATION_ROADMAP.md`](docs/MODERNIZATION_ROADMAP.md) | Strategic options, a recommended hybrid/strangler-fig approach, and a phased plan with concrete next steps. |

## Reproducing the analysis

The docs are backed by deterministic extractors (Python 3, standard library
only — no dependencies). Re-run them any time the sources change:

```sh
python3 tools/extract_schema.py .      # -> docs/data-model/schema.json + DATA_MODEL tables
python3 tools/extract_inventory.py .   # -> docs/inventory/objects.json
```

- `tools/extract_schema.py` parses the exported DataWindow/query sources
  (`*.srd`, `*.srq`) for `table.column` bindings, types, and joins.
- `tools/extract_inventory.py` scans the compiled `*.pbl` libraries (ANSI **and**
  UTF-16LE, since the live libraries are Unicode after the 2025 migration) for
  object names, grouped by PowerBuilder naming convention.

## Important caveats

- The `.pbl` files are **compiled binaries**; their PowerScript source is not
  recoverable here. The inventory recovers object **names** only, and is
  **approximate** (see the caveats in `OBJECT_INVENTORY.md`).
- The data model is **partial** — only what the ~40 exported DataWindows touch.
  A full model needs a live DB introspection or DDL, and a full text export of
  the remaining objects from the PowerBuilder IDE.
- **The app does not build as committed**: 7 PFE/PFD libraries in the target's
  library list are missing from the repo. See `ARCHITECTURE.md`.

## Repository layout

```
*.pbl                 PowerBuilder libraries (compiled, binary)
*.srd *.srq *.src     Exported DataWindow / query / event sources (text)
da.sra                Exported application object for the "da" data-acq app
abis.pbw  lion.pbt    PowerBuilder workspace / target
lion_mig.log          PowerBuilder migration report (2025-08-26)
docs/                 Modernization discovery & roadmap (this effort)
tools/                Reproducible analysis extractors
```
