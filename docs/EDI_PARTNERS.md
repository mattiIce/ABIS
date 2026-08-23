# EDI partner × document inventory (built vs. missing)

Enumerated 2026-07-12 from the legacy PL/SQL (`docs/data-model/oracle_ddl.sql` + `oracle_plsql_current.sql`)
and the PB EDI source (`legacy/src/edi/`). The legacy has a **separate proc per customer per document**, so
"the EDI engine" is a matrix, not five generators. Backups/test/dated copies (`_BAK`, `_ORIG`, `_ALEX`,
`_TESTn`, `_06262017`, `_RERUN`, `_per_job`, `_one_skid`, …) are omitted — only the canonical partner is listed.

Every generator here **builds + stores, never transmits** (the no-transmit seam). Each partner+document is a
row in `abis_edi_partner` (envelope/enablement as data) + a body **variant** in code where the layout diverges.

**Legend:** ✅ built · 🔶 tracked task · ⬜ missing (not yet ported)

**Byte-fidelity validated (2026-07-19)** against real production `.edi` off the .9 server: **870 Aleris + Novelis**
and **861 Arconic + Constellium + Novelis** all match segment-for-segment (Novelis 861 was re-ported to match).
Redacted golden fixtures + byte-equality tests live in `api/tests/ABIS.Api.Tests/golden/`. The real files stay
off-repo (maintainer's Desktop). The 846 / 856 / 863 / 997 goldens there are the spec for those unbuilt sets.

## 861 — Receiving Advice
| Partner | Customer id | Source proc | Status |
|---|---|---|---|
| Novelis (Kingston/Oswego/Guthrie) | 1153 / 1459 / 2582 | P_CREATE_EDI_861_FOR_ALL | ✅ #185, re-ported to golden fidelity (envelope SH/R0P7A/001504935001 ver 00401 + body) |
| Aleris | 1980 | P_CREATE_EDI_861_FOR_ALERIS / F_EDI_ALERIS_861 | ✅ #185 |
| Arconic (TN) | 2784 | F_EDI_ARCONIC_861 / EDI_ARCONIC_861_TEST | ✅ #193 (variant `arconic`) |
| Constellium | 2776 | F_EDI_CONSTELLIUM_861 (GS SH, receiver 043207177, `@` comp sep) | ✅ #194 (variant `constellium`) — golden-checked; TODO: add the trailing per-coil `MEA*CT**1*PC` |
| Commonwealth (= former Aleris) | **?** | F_EDI_COMMONWEALTH_861 (≈ aleris, receiver 964790856, N1*MF*Commonwealth*1*117791081) | 🔶 #59 — needs customer_id |

## 870 — Order/Coil Status  ⚠️ Aleris + Novelis built; 5 others are missing
| Partner | Source proc | Status |
|---|---|---|
| Aleris | EDI_ALERIS_870 / F_EDI_ALERIS_870_PER_JOB | ✅ #187 |
| **Novelis / Alcan** (Kingston 1153 / Oswego 1459 / Guthrie 2950) (+ scrap) | EDI_ALCAN_870 / F_EDI_NOVELIS_870_4JOB / P_EDI_NOVELIS_SCRAP_870 | ✅ #195 (variant `novelis`, per-job; GS03 override); Guthrie 2950 seeded (shared proc; only N1*SU DUNS differs) |
| Constellium (2776) (+ reject) | F_EDI_CONSTELLIUM_BG_870_4JOB / F_EDI_CONST_870_REJECT_4JOB | ✅ variant `constellium`, per-COIL (O→I→F, @ sep, ~ terminator, BSR02=PA); fully-scrapped reject 870 still deferred |
| Arconic | EDI_ARCONIC_870 | ⛔ **do not build** — no caller anywhere; dev file prefix (see below) |
| Wise | F_EDI_WISE_870 / F_EDI_WISE_870_BY_COIL / P_EDI_WISE_870 | ⛔ **do not build** — commented out in `ediprocess.sh`; newest Wise order **2007-09-07** |
| MISA | F_EDI_MISA_870_4JOB | ⛔ **do not build** — no caller; MISA has **2 orders ever** |
| Kaiser | f_edi_kaiser_870 (PB) | ⛔ **do not build** — no caller; newest Kaiser order **2001-01-11** |
| Reynolds | f_edi_reynolds_870 (PB) | ⛔ **do not build** — no caller; newest Reynolds order **2001-10-17** |

## 846 — Inventory Advice

> **Cleveland-Cliffs is a whole program, not one document.** They run an Outside Processing EDI suite — 23
> implementation guides and a 19-case certification plan spanning 810 / 846 / 856 / 861 / 863 / 867 / 870, in
> both directions. And it has **never gone live**: customer 3061 has zero orders and zero coils, the cron
> entries are commented out and marked "TEST ONLY", and every archived output is the empty placeholder — so
> **no golden file exists for any Cliffs document**. The full map, the open decisions and the build order are
> in **[EDI_CLIFFS.md](EDI_CLIFFS.md)**; the rows below cover only the 846.

| Partner | Customer id | Source proc | Status |
|---|---|---|---|
| Cleveland-Cliffs CCSC | 3061 | p_846_cleveland_cliff_ccsc | ✅ built, reconciled to the guide 2026-08-20 — see **[EDI_CLIFFS.md](EDI_CLIFFS.md)** |
| Novelis Kingston | 1153 | P_EDI_846_FOR_NOVELIS_KINGSTON | ⬜ |
| Novelis Oswego | 1459 | P_EDI_846_FOR_NOVELIS_OSWEGO | ⬜ |

## 856 — ASN / DESADV  ⚠️ the biggest set — ~16 destinations, none built
Alcan→**GM** (f_edi_alcan_gm_856) · Alcan→**Ford** (EDI_ALCAN_FORD_856_X12) · Alcan→**Budd** (EDI_ALCAN_BUDD_856) ·
Alcan→**Eagle** (EDI_ALCAN_EAGLE_856) · Alcoa→**Hayes** (EDI_ALCOA_HAYES_856_X12) · **Kaiser** (EDI_KAISER_856) ·
**Reynolds** (f_edi_reynolds_856 + des_856 + warehouse_856) · **MISA** (EDI_MISA_856_X12) · **Olympic**
(EDI_OLYMPIC_856_X12) · **Stellantis** (EDI_STELLANTIS_856_X12) · **TWB** (EDI_TWB_856_X12) · **Constellium**
(EDI_CONST_856_X12) · **Aleris** (EDI_ALERIS_856_X12) · **Arconic** (EDI_ARCONIC_856_X12 + DESADV Davenport) ·
**Novelis** (EDI_NOVELIS_856_X12 + scrap + rejcoil) · **Wise** (EDI_WISE_856). Generic driver: `F_EDI_856`,
`F_EDI_DESADV2`, `F_EDI_DESADV_BOLT`. All ⬜ (task #54 currently scoped to Alcan→GM/Ford only — widen it).

## 863 — Report of Test Results
Per-customer: `F_CUSTOMER_863` resolves the customer from the skid, then `F_CREATE_EDI_863_FILE` /
`_BY_COIL` / `_RESEND` build it; `F_ALL_SKID_COILS_HAVE_863` gates readiness; UI `w_edi_863`. ⬜ (task #55).
⚠️ confirm the `.863` filename actually transmits (GXS sweeps `S*.edi`, not `.863`).

## 997 — Functional Ack monitor
`p_check_997` — watchdog, not a partner generator. 🔶 #56.

---
## Bottom line for 0.5.0 scope
"EDI engine complete" is **~30+ partner-documents**, not 5. Built: 861 (Novelis+Aleris+Arconic+Constellium), 870 (Aleris+Novelis). The
backbone (#188) + standard pattern (#189) make each remaining one *a profile row + a variant*, but 856 alone
is ~16 and 870 is ~8 partners. **Re-estimate 0.5.0** = at minimum the live partners per set; the long tail of
low-volume 856 destinations may be a fast-follow. Confirm with the plant which partners are still active before
building the tail (some legacy procs — Budd, Eagle, Hayes, Reynolds, Kaiser — may be dormant customers).


---

## What legacy ACTUALLY transmits (audited 2026-08-23)

The remaining 870 and 856 variants were parked as *"confirm with the plant which partners are still
active first."* That was answerable from the code and the data, without asking.

### Only two 870s can run at all

**Every** invocation path was enumerated — the production cron driver and the PowerBuilder app.

`legacy/cron/db01-prod/scripts/abis_scripts/ediprocess.sh` runs exactly three statements:

```sh
execute dbo.p_create_edi_861_for_all;      # Novelis 861
execute dbo.p_create_edi_861_for_aleris;   # Aleris 861
execute dbo.edi_aleris_870;                # Aleris 870
```

…with `edi_alcan_870` commented out on 2020-12-07 ("Include Rebanded Coils project"),
`edi_alcan_870_reband` commented on 2016-11-02, and **`p_edi_wise_870` commented out** entirely.

The app side is every `DECLARE … procedure for …` in `legacy/src/`, which is the complete set of stored
procedures PowerBuilder can invoke. It contains **exactly one 870**: `f_edi_alcan_870`, aliased locally
as `p_edi_870` in `w_edi.srw:541` — so the EDI screen's "870" button generates the Alcan/Novelis
document and nothing else.

**Therefore the only 870s reachable in the entire legacy system are Aleris (cron) and Alcan/Novelis
(app button).** Arconic, Wise, MISA, Kaiser and Reynolds 870 procedures are defined and never invoked.

`EDI_ARCONIC_870` carries its own warning: the production file prefix is commented out and the
**development** one is active (`edi_file_prefix := 's_arconic_870_'; --Development`). Seven variants of
it exist — `_04302019`, `_ALEX`, `_ONE_JOB`, `_REBAND`, `_TEST`, `_TEST2` — which is what unfinished
experimentation looks like, not a settled production path.

Arconic **does** trade heavily (Davenport 50: 1,757 orders, newest 2026-07-10; TN 2784: 208, newest
2026-06-15) — and its **861 is built and live** (`f_edi_arconic_861`, invocable from the app). The
trading relationship is real; the 870 leg of it is not.

### The 856 tail is dormant

`f_edi_856.srf` is a genuine `Choose Case li_customer_id` dispatcher, but its Reynolds branch (customers
40, 44) and the Ford destination sub-cases under it are inside a `/* … */` block. The branches that are
live dispatch for customers **34, 35, 10** — and all three are dormant:

| Customer | | Orders | Newest |
|---|---|---:|---|
| 34 | ARCONIC-ALTERS | 0 | — |
| 35 | NOVELIS ROLLED PRODUCTS CO.-WARREN | 328 | **2001-04-09** |
| 10 | NOVELIS AUTOMOTIVE PRODUCTS | 0 | — |

The "~16-destination tail" is the Ford/GM enduser sub-cases beneath those three. **Porting them would
build routing for business that stopped 25 years ago.**

### Controls

Measurements were validated against partners known to be live: **Novelis 7,794 orders (newest
2026-08-19)** and **Constellium 15,044 (newest 2026-08-19)**. A first attempt returned 0 orders for
every partner including those two — an invalid `sort=createdDate` made the endpoint answer with a
validation problem, and the loop read `totalCount` as 0. **The controls are what caught it**; without
them the conclusion would have been "everything is dormant," which is false and would have been
believed.

### What this does NOT say

This is about **porting more per-customer variants out of legacy**. It says nothing about whether
modern ABIS should send an 856 or 870 to whoever the plant trades with *now* — that is a live business
question, and the modern EDI engine already carries the generic 856/870 builders. The finding is only
that the legacy tail is not worth mining.
