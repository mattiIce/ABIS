# ABIS — Architecture (as-is)

This describes the **current** ABIS system as recovered from the repository. It
is the baseline for the modernization effort
([`MODERNIZATION_ROADMAP.md`](MODERNIZATION_ROADMAP.md)).

## What ABIS is

ABIS is a desktop **manufacturing / ERP system for an aluminum coil → sheet
processing plant** (internal app name **`lion`**; the codebase is nicknamed
"silverdome"). It spans the full operational flow:

> quotation → order entry → coil receiving → inventory → production jobs on the
> shop floor (slitting/cut-to-length lines) → QA/mechanical testing &
> certification → skid/scrap handling → warehouse → shipping/EDI → accounting

with supporting modules for dies/tooling, maintenance, downtime tracking,
barcode scanning, security, and reporting. The data model
([`DATA_MODEL.md`](DATA_MODEL.md)) confirms this shape, centered on the
`ab_job` (production job) and `coil` entities.

## Technology stack

| Layer | Technology |
|---|--:|
| Language / runtime | **PowerBuilder** (PowerScript), recently migrated to a current Unicode Appeon PowerBuilder — see "Migration" below |
| Application framework | **PFC** (PowerBuilder Foundation Classes) + a PFE/PFD extension layer |
| UI | PowerBuilder windows + **DataWindows** (~1,345 DataWindows, ~588 windows) |
| Data access | DataWindows over a native DB transaction (`n_tr`/`SQLCA`); SQL is embedded in DataWindow objects |
| Database | A relational DB (server brand not determinable from these sources; the schema in `DATA_MODEL.md` is DB-agnostic) |
| Hardware I/O | Win32 serial via `WSC32.DLL`; Win32 `user32.dll`; OPC (OLE for Process Control) |

### Runtime topology (classic 2-tier client/server)

```
 ┌──────────────────────────────┐         ┌───────────────────┐
 │  Windows desktop client       │  SQL    │                   │
 │  ───────────────────────────  │◀───────▶│   Database server │
 │  lion.exe (PowerBuilder + PFC)│         │                   │
 │   DataWindows ── SQLCA (n_tr) │         └───────────────────┘
 └───────┬───────────────┬───────┘
         │ serial (WSC32) │ OPC
         ▼                ▼
  scales / gauges    PLCs / line equipment
 (data-acq app "da")  (opc_log)
```

The client talks **directly to the database** (DataWindows issue SQL via the
`SQLCA` transaction object declared in the application object). There is no
application/service tier — business logic lives in window/DataWindow event
scripts and NVO classes inside the client. This is the single most important
fact for modernization: **there is no API to build on; one must be created.**

## Two application targets

The workspace (`abis.pbw`) ships one target (`lion.pbt`), but the sources reveal
**two** PowerBuilder applications:

1. **`lion`** — the main ERP/MES client. Application object in `silverdome.pbl`;
   ~50-library `LibList` (see below).
2. **`da`** — a **data-acquisition** companion app (application object exported
   as `da.sra`, libraries `da.pbl` / `da_offline.pbl`). It declares ~29 `WSC32.DLL`
   serial functions and singleton-guards itself via a `FindWindow("DAS")` check,
   i.e. it runs on shop-floor PCs reading **scales/gauges over serial COM ports**.
   An `_offline` variant exists for disconnected operation.

## Module map

Libraries grouped by domain (counts in [`OBJECT_INVENTORY.md`](OBJECT_INVENTORY.md)):

- **App shell + core logic** — `silverdome.pbl` (+ `silverdome1..7.pbl`). The
  bulk of the application; `silverdome3.pbl` (18 MB, ~245 DataWindows) is the
  largest single library.
- **Commercial** — `order_entry`, `quotation`, `Sales`, `part_num`.
- **Receiving** — `receiving`, `coil_receiving`.
- **Inventory** — `inv_coil`, `inv_skid`, `warehouse`.
- **Production / shop floor** — `daily_prod`, `downtime`/`downtime2`,
  `coil_eval`, `skid_entry`, `stacker_110` (a specific line, #110),
  `prod-folder`, `scan` (barcode).
- **Quality** — `qa`, `quality` (mechanical/chemical certs — the `863` cert
  DataWindows and `pst_test_result`/`temp_test_result` tables).
- **Shipping / EDI** — `edi` (e.g. `f_edi_856` Advance Ship Notice; DUNS
  cross-reference; `inbound_shipment.edi_file_id`).
- **Equipment integration** — `da`/`da_offline` (serial), `opc_log`
  (OPC → PLC/SCADA; the `opc_action_log` table is its audit trail).
- **Support** — `die_tool`, `maintenance`, `accounting`, `security`, `rpabco`
  (reporting).
- **Vendor framework** — `pfc*` (PFC).

## Integration surface (modernization risk hot-spots)

> Precise inventory (transaction sets, the 29 `WSC32` serial calls, EDI tables
> and trading partners) is catalogued in [`INTEGRATIONS.md`](INTEGRATIONS.md).

These external couplings cannot simply be "moved to the cloud" and need explicit
plans:

1. **Serial hardware (`WSC32.DLL`)** — scales/gauges read over COM ports by the
   `da` app. Requires an on-premise/edge component in any modern architecture.
2. **OPC (PLC/SCADA)** — line equipment integration (`opc_log`). Also edge-bound.
3. **EDI** — X12 856 (ASN) and related transactions with trading partners.
4. **Win32 API calls** — `FindWindow`/`SetForegroundWindow` and friends; Windows-
   specific behaviors to replicate.

## Migration already performed (Aug 2025)

`lion_mig.log` records a PowerBuilder version migration on **2025-08-26**. It is
full of the standard upgrade advisories:

- ANSI→Unicode string function swaps (`Left`→`LeftA`, `Mid`→`MidA`,
  `Pos`→`PosA`, `Char`→`CharA`, …), confirming the live libraries are now
  **Unicode** (UTF-16) — which is why object names had to be scanned as UTF-16LE.
- `Append ALIAS FOR clause to external function …` advisories for the `WSC32.DLL`
  and `user32.dll`/Win32 externals.

So the app was **recently brought onto a modern Appeon PowerBuilder**. That is a
prerequisite the team has already cleared — modernization can build on a current,
supported PB rather than an end-of-life one.

## Repository / build-readiness issues found

1. ~~**Missing libraries — will not build as committed.**~~ **Resolved.**
   `lion.pbt`'s `LibList` names **50** libraries; the 7 previously-absent PFE/PFD
   extension libraries (`PFD_ABC.PBL`, `PFE_ABC.PBL`, `pfeapsrv.pbl`,
   `pfedwsrv.pbl`, `pfemain.pbl`, `pfeutil.pbl`, `pfewnsrv.pbl`) were located in a
   complete build tree (shared `pfc*` libraries byte-identical to the repo's) and
   committed. **All 50 are now present** — the target builds as committed.
2. ~~**Stale backup copies committed.**~~ **Resolved.** `daily_prod_12032020.pbl`
   and `silverdome2_06092022.pbl` (dated snapshots not referenced by the target)
   were removed from the tree (recoverable from git history).
3. **Binary sources under git.** The `.pbl` libraries are binary blobs; git
   cannot diff or merge them. Meaningful version control requires exporting
   PowerBuilder objects to text (the `.srd`/`.sra`/`.srq`/`.src` files already in
   the repo are examples of that export format — but only a few dozen exist).
4. **Flat layout.** Everything sits in the repo root; there is no project
   structure, build script, CI, or README (the latter two are added by this
   effort).
