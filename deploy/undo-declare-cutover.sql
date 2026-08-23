-- Undo the production declaration — re-allow refreshes on .230.
-- ================================================================
-- Run this ONLY if the cutover was called off and .230 is going back to being a refresh target.
--
-- ⚠️  AFTER THIS, `refresh-nonprod.sh` WILL RUN AGAIN — and it replaces every non-excluded DBO table
--     from .9. If .230 has taken ANY real production traffic since the cutover was declared, that work
--     is destroyed by the next refresh. Check before you run this, not after:
--
--       SELECT COUNT(*) FROM customer_order WHERE order_created_dttm > <declared_utc>;
--       SELECT COUNT(*) FROM coil           WHERE coil_entry_date   > <declared_utc>;
--
--     `declared_utc` is in the row this script is about to overwrite, so read it FIRST:
--
--       SELECT is_production, declared_utc, declared_by, note FROM abis_cutover_state;
--
-- WHY THIS EXISTS AT ALL
--   A guard nobody can unwind gets worked around — commented out, or the marker updated by hand at 2am
--   by someone who does not know what it protects. A documented, deliberate reversal is safer than an
--   undocumented one, which is the same reasoning as `undo_retire_legacy_pm.sql`.

SET SERVEROUTPUT ON

PROMPT
PROMPT === The row you are about to overwrite ===
SELECT is_production, TO_CHAR(declared_utc,'YYYY-MM-DD HH24:MI') AS declared_utc, declared_by, note
  FROM abis_cutover_state WHERE cutover_id = 1;
PROMPT

DEFINE undo_reason = ''

UPDATE abis_cutover_state
   SET is_production = 0,
       note          = 'Cutover reverted: &undo_reason'
 WHERE cutover_id = 1;

COMMIT;

DECLARE
  v_flag NUMBER(1);
BEGIN
  SELECT is_production INTO v_flag FROM abis_cutover_state WHERE cutover_id = 1;
  IF v_flag = 0 THEN
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('=== .230 is no longer declared production ===');
    DBMS_OUTPUT.PUT_LINE('refresh-nonprod.sh will run again. Anything written since the declaration');
    DBMS_OUTPUT.PUT_LINE('will be REPLACED by prod''s copy on the next refresh.');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Still declared production (is_production = ' || v_flag || ').');
  END IF;
END;
/
