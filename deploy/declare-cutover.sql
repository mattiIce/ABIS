-- Declare .230 PRODUCTION — run this once, at cutover, and not before.
-- ================================================================
-- After this, `deploy/refresh-nonprod.sh` refuses to run. That is the entire point: the refresh is
-- `impdp ... table_exists_action=replace`, and against a live production .230 it would overwrite real
-- orders, coils, shipments and PM history with the retired box's copy.
--
-- WHEN
--   AFTER the final refresh from .9 has completed and been verified, and .230 is about to start
--   diverging permanently. Not during parallel running — refreshes are correct and expected then, and
--   declaring early would block the testing this whole phase exists for.
--
-- BEFORE YOU RUN IT
--   1. The final refresh is done and `tools/verify_refresh.sql` reports no failures.
--   2. The post-refresh repairs are applied — sequences, admin login, IT grants AND members, the
--      modern feature rows, migrations 008/009, and the KeepTrak import. DB_REFRESH.md Parts 3-8.
--      Every one of those is undone by a refresh, so the LAST refresh undid them too.
--   3. Somebody has actually looked at the app against the refreshed data.
--
-- REVERSIBLE, deliberately: if the cutover is called off, `undo-declare-cutover.sql` sets it back and
-- refreshes resume. A guard nobody can unwind gets worked around instead of respected.

SET SERVEROUTPUT ON

-- Substitution variables so the record says WHO, rather than a row nobody can attribute.
-- sqlplus will prompt for these; there is no default on purpose.
DEFINE declared_by = ''
DEFINE cutover_note = ''

UPDATE abis_cutover_state
   SET is_production = 1,
       declared_utc  = SYS_EXTRACT_UTC(SYSTIMESTAMP),
       declared_by   = '&declared_by',
       note          = '&cutover_note'
 WHERE cutover_id = 1;

COMMIT;

DECLARE
  v_flag NUMBER(1);
  v_when DATE;
  v_who  VARCHAR2(64);
BEGIN
  SELECT is_production, declared_utc, declared_by
    INTO v_flag, v_when, v_who
    FROM abis_cutover_state WHERE cutover_id = 1;

  IF v_flag = 1 THEN
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('=== .230 IS NOW DECLARED PRODUCTION ===');
    DBMS_OUTPUT.PUT_LINE('declared ' || TO_CHAR(v_when, 'YYYY-MM-DD HH24:MI') || ' UTC by ' || v_who);
    DBMS_OUTPUT.PUT_LINE('refresh-nonprod.sh will now REFUSE to run against this database.');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Remaining manual step: remove the refresh cron entries if they were ever');
    DBMS_OUTPUT.PUT_LINE('installed (DB_REFRESH.md "Weekly automation"). The guard stops the script,');
    DBMS_OUTPUT.PUT_LINE('but a cron that fires every Sunday and mails a failure is noise nobody needs.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('NOT declared - is_production is still ' || v_flag || '. Did the UPDATE match a row?');
  END IF;
END;
/
