-- Regenerate the rollback for retire_legacy_pm.sql, from the LIVE schema.
-- ================================================================
-- Run this BEFORE retire_legacy_pm.sql, every time.
--
-- WHY IT IS NOT ENOUGH TO KEEP THE COMMITTED COPY
--   `deploy/keeptrak/undo_retire_legacy_pm.sql` was captured from .230 on 2026-07-24 (8x'1', 46x'2',
--   23x'3'). `PM` is a legacy DBO table, so **every Data Pump refresh since then has restored prod's
--   copy over it** — and a refresh is exactly the routine event this project keeps rediscovering. If
--   prod's statuses differ from that snapshot, the committed rollback would restore the WRONG values,
--   quietly, on the day someone needs it most.
--
--   The legacy rows do not share a single status, so a blanket `pm_status = 2` revert is not an option
--   either. Each row has to carry its own original value.
--
-- WHAT IT DOES
--   Writes /tmp/undo_retire_legacy_pm.sql containing one UPDATE per legacy PM (pm_id < 100000),
--   restoring that row's current pm_status. Read-only: it SELECTs and spools, and changes nothing.
--
-- AFTER RUNNING
--   Keep the spooled file. It is the only way back.

SET PAGESIZE 0
SET FEEDBACK OFF
SET HEADING OFF
SET LINESIZE 200
SET TRIMSPOOL ON
SET VERIFY OFF

SPOOL /tmp/undo_retire_legacy_pm.sql

SELECT '-- Rollback for retire_legacy_pm.sql - restores each legacy PM''s ORIGINAL pm_status.' FROM dual;
SELECT '-- Regenerated from the live schema on ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI') || '.' FROM dual;
SELECT '-- Distribution at capture: ' ||
       LISTAGG(cnt, ', ') WITHIN GROUP (ORDER BY st)
  FROM (SELECT NVL(TO_CHAR(pm_status), 'NULL') AS st, COUNT(*) || 'x''' || NVL(TO_CHAR(pm_status), 'NULL') || '''' AS cnt
          FROM pm WHERE pm_id < 100000 GROUP BY pm_status);
SELECT '' FROM dual;

-- NULL is restored as NULL, not as 0: "never set" and "retired" are different states, and collapsing
-- them would make the rollback lossy in exactly the way the per-row capture exists to prevent.
SELECT 'UPDATE pm SET pm_status = '
       || NVL(TO_CHAR(pm_status), 'NULL')
       || ' WHERE pm_id = ' || TO_CHAR(pm_id) || ';'
  FROM pm
 WHERE pm_id < 100000
 ORDER BY pm_id;

SELECT 'COMMIT;' FROM dual;

SPOOL OFF

SET PAGESIZE 24
SET FEEDBACK ON
SET HEADING ON

PROMPT
PROMPT Wrote /tmp/undo_retire_legacy_pm.sql - keep it. Now check the count below is what you expect
PROMPT before running retire_legacy_pm.sql:
PROMPT

SELECT pm_status, COUNT(*) AS rows_affected
  FROM pm
 WHERE pm_id < 100000
 GROUP BY pm_status
 ORDER BY pm_status;
