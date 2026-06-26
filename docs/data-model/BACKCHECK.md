# Legacy module back-check (greenfield ↔ real PowerBuilder source)

Once the previously-unexported `.pbl` libraries were exported and vendored under
[`legacy/src/`](../../legacy/src/), each already-built greenfield module was checked
against its **real** DataWindow column names (the authoritative `dbname="table.column"`
tokens) and against the authoritative Oracle DDL in
[`oracle_ddl.sql`](./oracle_ddl.sql).

**Headline:** there are **no silent column-name mismatches** in any built module — every
modeled column name matches the real Oracle `dbname`, including the traps
(`coil_alloy2` not `coil_alloy`; the misspelled `scrap_handing_type`; the no-underscore
maintenance names `probdatetime`/`systemequipment`/`laborhours`). The Oracle write path
will not break on what is modeled. The gaps are **omitted columns** (reduced subsets) and,
in two cases, a real correctness issue.

## Results

| Module | Table / PK / names | Verdict | Notes |
|---|---|---|---|
| **scan** | `scan_log`, PK `scan_id` | ✅ PASS | Exact 1:1 match to `oracle_ddl.sql`; all NOT NULL columns populated on insert. |
| **inv_coil** | `coil` | ✅ PASS | Every `coil` column name exact. Unused real columns absent (`coil_edi856_status`, `abco_coil_net_wt`, `consumed_coil_num`, `material_num`, `cash_date`, `coil_abc_num_previous`) — none currently read. |
| **maintenance** | `maint_log`, PK `maint_log_id` | ✅ PASS | All 17 names exact incl. the no-underscore ones. Omits 11 updatable columns; meaningful ones: `lastappendedby`/`lastappendeddate` (append audit), `hasimage`/`imagepath` (attachments). |
| **order_entry** | `customer_order` + `order_item` | ⚠️ subset | Names correct; the composite `order_item` PK `(order_abc_num, order_item_num)` and the `order_abc_num` FK are **confirmed** (the "INFERRED" comments were removed). Models a thin slice — missing `quantity`/tolerances, `item_status`, `item_due_date`, `part_num_id`, item/order notes, packaging specs, and most `customer_order` header fields. |
| **part_num** | `part_num`, PK `part_num_id` | ⚠️ subset | Names + PK correct. Models 9 of 37 real columns — missing gauge tolerances (`gauge_p`/`gauge_m`), trim fields, `die_id`, `theoretical_unit_wt`, and the packaging-spec block. |
| **die_tool** | `die`, PK `die_id` | ⚠️ subset | Table is `die` (not `die_tool`); names correct. Missing 5 real columns: **`owner`** (an editable header field), `num_of_parts_per_hit`, `engineered_scrap_y_n`, `angle_change_minutes`, `average_die_change_minutes`. |
| **qa** | `pst_test_result` / `temp_test_result` | 🔴 fixed | Table + value names correct, but the read model had dropped the coil linkage. **Fixed in this PR** (below). |
| **receiving** | `receiving_bol` | 🔴 design | `receiving_bol` column names match the DDL, but the vendored receiving DataWindows actually edit the **`coil`** table, and the BOL line-item table **`receiving_bol_coil`** (PK `(receiving_bol_id, coil_id)`, NOT NULL `coil_org_num`) is unmodeled. The module models the BOL header, not the per-coil receiving detail the screens capture. Left as a design decision. |

## Fixed in this PR — QA coil linkage

`pst_test_result`'s real primary key is the composite
`(coil_abc_num, position, created_date, source_id)` (`oracle_ddl.sql`). The greenfield
read model had replaced it with a surrogate `id` and dropped `coil_abc_num` and
`source_id` — so a posted mechanical test result could not be tied back to its coil.
Restored:

- `pst_test_result` → added `coil_abc_num` + `source_id`; the SQLite fixture now uses the
  real composite PK. `TestResult` exposes `CoilAbcNum` / `SourceId`.
- `temp_test_result` → added `coil_org_num` (how an in-progress result is matched to a
  coil by org number). `TempTestResult` exposes `CoilOrgNum`.

QA is read-only in the greenfield API, so this is a read-model enrichment (no write path
changed). SQLite CI had missed it because the fixture substituted an autoincrement `id`.

## Not addressed (reduced subsets — follow-up candidates)

`order_entry`, `part_num`, `die_tool`, and `maintenance` are faithful but thin — correct
on the columns they model, but missing real writable columns. Whether to widen them to the
full legacy column set is a product decision (the greenfield screens may intentionally
expose a smaller surface). `receiving` needs a design call on whether to model
`receiving_bol_coil` / the coil-entry flow.
