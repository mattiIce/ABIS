-- Migration 009 — KeepTrak provenance marker on the PM tables
-- ================================================================
-- Apply on the ABIS Oracle schema (DBO on 192.168.1.230/abc11, and later the cutover target).
-- Safe to run before or after the KeepTrak import; the import re-runs cleanly either way.
--
-- ⚠️  Like 008, this ALTERS LEGACY tables (PM, PM_ACTIONS, PMCOMPLETIONS). See DB_REFRESH.md Part 7:
--     a migration that alters a legacy table is undone by every Data Pump refresh unless the table is
--     excluded. All three ARE excluded (KEEPTRAK_TABLES in deploy/refresh-nonprod.sh), and the app
--     also re-adds these columns at startup, so this one is covered twice over.
--     Additive and NULLable only: nothing is dropped, renamed, retyped or reordered, and the legacy
--     PowerBuilder app binds its DataWindows by column name, so an added NULLable column is invisible
--     to it.
--
-- WHY
--   The KeepTrak import cleared its previous run with `DELETE ... WHERE <id> >= 100000`, on the
--   assumption that the reserved id range holds only imported rows. That assumption expired the
--   moment the import landed.
--
--   PM, PM_ACTIONS and PMCOMPLETIONS all mint ids with MAX(id)+1 (Database:MaxIdTables), so after the
--   import MAX(pm_id) is ~100144 and MAX(pmcompletion_id) is ~113703. **Every PM created, action
--   added, or PM completed in ABIS from now on gets an id above 100000** — inside the range the
--   import deletes. Re-running the import (after a refresh, or to pick up newer KeepTrak data) would
--   therefore delete real maintenance work that was never in KeepTrak.
--
--   Raising the offset does not fix it, it only moves the collision: MAX+1 minting always climbs back
--   into whatever range is reserved next.
--
-- WHY NOT REUSE PM.PMREFERENCE
--   Imported PMs already carry `pmreference = 'KT-<keeptrak id>'`, but PMREFERENCE is a user-editable
--   field exposed through the API (`pmReference`). Keying a DELETE on data a user can type is how you
--   get a support call that begins "it deleted my PM". KT_REF is written ONLY by the import — no ABIS
--   code path sets it — so `KT_REF IS NOT NULL` means "this row came from KeepTrak", always.
--
-- SHAPE
--   kt_ref  VARCHAR2(32) — 'KT-<keeptrak id>' on imported rows, NULL on everything else.
--
-- NOT NEEDED ON THE HIERARCHY TABLES
--   GROUPDEPARTMENT / SYSTEMEQUIPMENT / SUBSYSTEMEQUIPMENT / ITEMDEVICE / TITLECRAFT keep their
--   id-range delete: the application has no code path that INSERTs into any of them (verified against
--   AbisRepository 2026-08-21), so nothing but the import can ever occupy that range. PMSHIFT is
--   never deleted at all — it is loaded with INSERT ... WHERE NOT EXISTS.
--
-- IDEMPOTENCY
--   Each ADD is guarded against USER_TAB_COLS, so re-running is a no-op rather than ORA-01430.

DECLARE
  n PLS_INTEGER;
  PROCEDURE add_kt_ref(p_table VARCHAR2) IS
  BEGIN
    SELECT COUNT(*) INTO n FROM user_tab_cols
     WHERE table_name = p_table AND column_name = 'KT_REF';
    IF n = 0 THEN
      EXECUTE IMMEDIATE 'ALTER TABLE ' || p_table || ' ADD (kt_ref VARCHAR2(32))';
      DBMS_OUTPUT.PUT_LINE('added ' || p_table || '.KT_REF');
    ELSE
      DBMS_OUTPUT.PUT_LINE(p_table || '.KT_REF already present - skipped');
    END IF;
  END;
BEGIN
  add_kt_ref('PM');
  add_kt_ref('PM_ACTIONS');
  add_kt_ref('PMCOMPLETIONS');
END;
/

-- Backfill: an import that ran BEFORE this migration left its rows unmarked. Without this they would
-- be invisible to the new marker-scoped DELETE and the next import would duplicate them. Scoped to
-- the reserved range, which is exactly the population the old id-range DELETE covered.
UPDATE pm            SET kt_ref = 'KT-' || TO_CHAR(pm_id - 100000)            WHERE pm_id            >= 100000 AND kt_ref IS NULL;
UPDATE pm_actions    SET kt_ref = 'KT-' || TO_CHAR(pm_action_id - 100000)     WHERE pm_action_id     >= 100000 AND kt_ref IS NULL;
UPDATE pmcompletions SET kt_ref = 'KT-' || TO_CHAR(pmcompletion_id - 100000)  WHERE pmcompletion_id  >= 100000 AND kt_ref IS NULL;
COMMIT;

-- Verify:
--   SELECT COUNT(*) FROM pm            WHERE kt_ref IS NOT NULL;   -- expect 144
--   SELECT COUNT(*) FROM pmcompletions WHERE kt_ref IS NOT NULL;   -- expect 13703
--   -- and this must be 0, or a re-import would delete in-ABIS work:
--   SELECT COUNT(*) FROM pm WHERE pm_id >= 100000 AND kt_ref IS NULL;
