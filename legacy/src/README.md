# Legacy PowerBuilder source (reference)

PowerBuilder 9 object source exported from the legacy ABIS `.pbl` libraries, for the
modules **not yet rebuilt** as greenfield (Path C) screens. Vendored here so each new
module's API + UI can be built against the **real** tables/columns/SQL instead of
guesses — the embedded DataWindow `retrieve="PBSELECT(...)"` strings name the actual
tables and columns.

File types: `.srw` windows · `.srd` DataWindows (embedded SQL) · `.srm` menus ·
`.sru` user objects · `.srs` structures · `.srf` functions.

> The `silverdome*` / `aaaa` core libraries (~1.1 GB, includes binaries) are **not**
> vendored — only the remaining-area libraries below (8.8 MB of text). Read those in
> place from the export if ever needed.

## Folders → what the subsystem actually is (from the source)

| Folder | Real nature (per the windows/DataWindows) |
|---|---|
| `quotation/` | **CirclePro / SheetPro yield calculator** (`w_circlepro`, `w_quotation_new`) — computational, not table CRUD |
| `accounting/` | **Invoicing** (`w_invoice`) + scrap-type reports (`return_scrap_item`, `scrap_skid`) |
| `quality/` | **Recovery / customer-defect** tracking + per-customer daily reports (`w_recovery`) — not the 863 certs |
| `warehouse/` | Skid **warehouse** entry (`w_wh_business`, `w_wh_detail`, `d_wh_item`) |
| `daily_prod/` | **Daily production reporting** (28 windows, 109 DataWindows) |
| `rpabco/` | **Reporting** — 33 report-template DataWindows, no windows |
| `sales/` | Sales screens |
| `inv_skid/`, `skid_entry/` | Skid inventory / entry |
| `coil_eval/` | Coil evaluation |
| `stacker_110/` | Line #110 stacker |
| `prod-folder/` | Production folder |
| `opc_log/` | **OPC log** (`w_opc_log`) — `opc_log` + `opc_log_details` (host → device → item, value, quality) + `opc_action_log`. The `item_name`/`remote_host` structure is the real OPC tag layout for the edge. |
| `downtime/`, `downtime2/` | Downtime reports + the shift coil-processing windows (`w_finish_coil`, `w_change_coil`, …) — the line-operator workflow |

## How to read the SQL

In a `.srd`, find `retrieve="PBSELECT( VERSION(400) ... TABLE(NAME="t") COLUMN(NAME="t.c") ... )"`.
The `TABLE(NAME=…)` and `COLUMN(NAME=…)` tokens are the real Oracle tables/columns the
screen reads; cross-reference with [`../../docs/data-model/`](../../docs/data-model).
