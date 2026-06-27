# ABIS — External Integration Catalog

Precise inventory of ABIS's external integrations — the **modernization
risk hot-spots** flagged in [`ARCHITECTURE.md`](ARCHITECTURE.md) §Integration
surface and [`MODERNIZATION_ROADMAP.md`](MODERNIZATION_ROADMAP.md) Phase 1.
These are the couplings that a strangler-fig migration must preserve or
re-home; they don't move behind the [API seam](../api/README.md) for free.

> **Sources.** Grounded in artifacts in this repo: the live schema
> ([`DATA_MODEL.md`](DATA_MODEL.md) / `data-model/oracle_schema.json`), the
> PL/SQL in `data-model/oracle_ddl.sql`, and the vendored PowerBuilder text source
> for the rebuilt areas ([`../legacy/src/`](../legacy/src/README.md), incl. `edi/`,
> `da/`, `opc_log/`). The remaining ⛔ items live in the un-vendored `silverdome*`
> core libraries (read in place from the export). The real OPC tag structure
> (host → device → item) is now known from the `opc_log` data and seeded
> ([`../api/`](../api/README.md) `/opc-log`); per-device serial formats still need
> the shop-floor hardware.

## Summary

| Integration | Transport | Where the logic lives | Catalog status | Migration target |
|---|---|---|---|---|
| **EDI** (X12) | Files (ISA/GS/ST envelopes) exchanged via VAN/GXS | DB PL/SQL procedures (recoverable) + `edi.pbl` orchestration ⛔ | **Precise** (sets, versions, partners, tables) | API/back-office service |
| **Serial scales/gauges** | RS-232 over COM via `WSC32.DLL` | `da`/`da_offline` (`da.sra`, in repo) | **Precise** (29 `Sio*` calls) | Shop-floor **edge service** |
| **OPC (PLC/SCADA)** | OPC (OLE for Process Control) | PB OPC objects ⛔ + `opc_log` table | **Surface only** (tags blocked) | Shop-floor **edge service** |

---

## 1. EDI (X12 electronic data interchange)

ABIS exchanges X12 transactions with automotive trading partners. Logic is
**split**: per-partner/per-transaction **PL/SQL procedures** in the database
(dozens, e.g. `EDI_ALCAN_870`, `EDI_ALCAN_FORD_856_X12`, `EDI_ARCONIC_861_TEST`)
build the payloads, and the PB `edi.pbl` orchestrates send/receive and file I/O.
The DB procedures are **recoverable today** from `data-model/oracle_ddl.sql`; the
PB orchestration is **⛔ needs PB export**.

### Transaction sets in use

| Set | Direction | Purpose | Evidence |
|---|---|---|---|
| **856** (ASN) | Outbound | Advance Ship Notice to the customer when material ships | `EDI_TYPE` rows; `EDI_*_856_X12` procs; `f_edi_856` (PB) |
| **856** | Inbound | Receiving notice for incoming coils | `EDI_INBOUND_856` table (coil id/alloy/temper/gauge/width) |
| **870** | Outbound | Order/coil status report (per job / per skid) | `EDI_TYPE` rows; `EDI_*_870*` procs; `EDI_870_COIL_STATUS` |
| **861** | (Receiving advice) | Material receipt confirmation | `EDI_ARCONIC_861_TEST` proc |
| **863** | Outbound | Report of test/inspection results (cert data) | `EDI_FILE_863` table (20,805 rows, per coil) |
| **997 / FA** | Inbound | Functional Acknowledgment of sent transactions | `EDI_FA` table (27,805 rows); `fa_receive_status` on outbound |

### Map / versions (from live `EDI_TYPE`)

- **856** — versions `2002FORD` (Ford), `2040GM` (GM), `3030` (generic X12 v3030)
- **870** — version `3030`

### Trading partners (from live `CUSTOMER_EDI`)

Ford — Chicago, Cleveland, Woodhaven, Maumee (`2002FORD`); GM — Grand Rapids,
Pontiac (`2040GM`); Kaiser (`3030`); IDS, WSDC; plus Alcan→Ford / Alcan→GM ASN
routes. (The plant runs EDI on behalf of several aluminum suppliers — hence the
`EDI_ALCAN_*`, `EDI_ARCONIC_*`, `EDI_ALERIS_*`, `EDI_ALCOA_*` procedure families.)

### Key tables

| Table | Rows | Role |
|---|--:|---|
| `OUTBOUND_EDI_TRANSACTION` | 87,412 | Outbound ledger: `duns_from/to`, ISA/GS control numbers, `transaction_type_id`, `fa_receive_status`, raw file |
| `EDI_FA` | 27,805 | Functional-acknowledgment tracking (GS#, send/receive time, status) |
| `EDI_FILE_863` | 20,805 | 863 cert files queued/sent per coil |
| `EDI_870_COIL_STATUS` | 861 | 870 status history per coil |
| `EDI_LOG` / `EDI_OUT_FILE` | 944 / 838 | Transmission log + outbound file staging |
| `EDI_INBOUND_856` | 0 | Inbound ASN landing (coil attributes) |
| `EDI_TYPE`, `CUSTOMER_EDI`, `CUSTOMER_CUSTOMER_EDI_CODE` | 4 / 12 / 4 | Type + trading-partner config |

**Modernization note.** Because the heavy lifting is in DB PL/SQL, an API-tier
EDI service can call or port those procedures incrementally without the PB app.
The PB `edi.pbl` layer (scheduling, VAN file transfer) is the part that needs
export and re-homing.

---

## 2. Serial scales & gauges (`WSC32.DLL`)

The `da` / `da_offline` data-acquisition objects (`da.sra`, **in repo**) read
weigh scales and thickness gauges over RS-232 using the **MarshallSoft WSC32**
serial library. This is physically tied to the shop floor and must keep working
throughout migration — the target is a small **edge service** exposing these
devices to the API.

**Complete `Sio*` API surface declared (29 functions):**

- **Port lifecycle:** `SioReset`, `SioDone`, `SioParms`, `SioBaud`, `SioFlow`,
  `SioInfo`, `SioGetReg`, `SioDebug`, `SioKeyCode`
- **Read/write:** `SioGetc`, `SioGets`, `SioPutc`, `SioPuts`, `SioUnGetc`,
  `SioRead`
- **Queues:** `SioRxQue`, `SioTxQue`, `SioRxClear`, `SioTxClear`
- **Modem/line signals:** `SioCTS`, `SioDCD`, `SioDSR`, `SioDTR`, `SioRI`,
  `SioRTS`, `SioRTS`, `SioBrkSig`, `SioEvent`, `SioStatus`
- **Diagnostics:** `SioWinError`

(Source: `da.sra` external-function declarations, `LIBRARY "WSC32.DLL"`.)

**Migration note.** A `.NET`/edge serial reader (`System.IO.Ports`) replaces the
WSC32 P/Invoke surface 1:1; the per-device parsing logic lives in the `da`
objects and is recoverable once the PB source is exported.

---

## 3. OPC (PLC / SCADA line equipment)  ⛔ tags need PB export

Line equipment integrates over **OPC**. The audit/telemetry trail lands in the
`opc_log` table (and the now-vestigial `opc_action_log` the API's audit
middleware targets — see [`ORACLE_VALIDATION.md`](ORACLE_VALIDATION.md)). The
**precise OPC tag/item inventory is not recoverable from the artifacts in this
repo** — the OPC client objects are in unexported PB libraries. Cataloguing
every tag is **⛔ needs PB export** (and, ideally, the OPC server's address
space). Like serial, OPC is **edge-bound**: it belongs in the shop-floor edge
service, not the central API.

---

## What's still blocked (and on whom)

| Gap | Needs | Owner |
|---|---|---|
| Full per-call PB EDI orchestration (`edi.pbl`) | PB source export | Needs Windows PB IDE |
| OPC tag/item inventory | PB source export + OPC server address space | Needs PB IDE + shop-floor access |
| `da` device-parsing logic (per scale/gauge) | PB source export of `da`/`da_offline` | Needs PB IDE |

Everything else above is recovered from in-repo artifacts and the live database.
