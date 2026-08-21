-- Post-refresh audit: does .230 still have everything the modern app needs?
--
-- WHY THIS EXISTS
-- A Data Pump refresh imports every DBO table except ABIS_*, so prod's copy replaces .230's. Prod has
-- never heard of the modernization, and the things it therefore deletes fail LATER and SEPARATELY, each
-- looking like a different bug:
--
--   sequences behind their max        every id-minting INSERT dies ORA-00001
--   the ABIS admin login gone         sign-in says "user not found" - reads as an AD/LDAP fault
--   the four modern features gone     403 on every Parts/maintenance/admin write, for EVERYONE
--   the IT group's grants reverted    403 on a screen that looks available
--   the IT group's MEMBERS gone       the same 403, but only for some people
--
-- On 2026-08-21 all five were true at once on .230 and each was found by accident while chasing
-- something else - the last one only because someone asked why a count looked wrong. That is what this
-- script is for: one deliberate check instead of five accidental discoveries.
--
-- READ-ONLY. It reports; it changes nothing. The repairs are docs/DB_REFRESH.md Parts 3-6.
--
-- RUN ON THE DB HOST (oeldb01 / .230) as DBO - the app host has no Oracle client:
--   sqlplus -S /nolog
--   CONNECT dbo@//192.168.1.230:1521/abc11     (prompts for the password; never echoes it)
--   @tools/verify_refresh.sql
--
-- Do NOT paste dbo/<pw>@... - bash reads <pw> as a redirect and answers "pw: No such file or
-- directory" before sqlplus is ever reached.

SET SERVEROUTPUT ON SIZE UNLIMITED
SET FEEDBACK OFF

DECLARE
  v_fail      PLS_INTEGER := 0;
  v_warn      PLS_INTEGER := 0;
  v_n         PLS_INTEGER;
  v_m         PLS_INTEGER;
  v_group_id  PLS_INTEGER;
  v_names     VARCHAR2(4000);

  PROCEDURE say (p_line VARCHAR2) IS BEGIN DBMS_OUTPUT.PUT_LINE(p_line); END;

  PROCEDURE pass (p_what VARCHAR2, p_detail VARCHAR2 := NULL) IS
  BEGIN say(RPAD('  OK', 8) || p_what || CASE WHEN p_detail IS NOT NULL THEN ' - ' || p_detail END); END;

  PROCEDURE fail (p_what VARCHAR2, p_fix VARCHAR2) IS
  BEGIN v_fail := v_fail + 1; say(RPAD('  FAIL', 8) || p_what); say(RPAD(' ', 8) || '  fix: ' || p_fix); END;

  PROCEDURE warn (p_what VARCHAR2, p_note VARCHAR2) IS
  BEGIN v_warn := v_warn + 1; say(RPAD('  WARN', 8) || p_what); say(RPAD(' ', 8) || '  ' || p_note); END;
BEGIN
  say('=== post-refresh audit of ' || SYS_CONTEXT('USERENV','DB_NAME') || ' as of ' ||
      TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI') || ' ===');
  say('');

  -- 1. The four features the modern app gates on ---------------------------------
  say('1. modern-app security features (security_application)');
  SELECT COUNT(*) INTO v_n FROM security_application
   WHERE TRIM(application_name) IN ('Part Number','Maintenance_logs','Scheduler Admin','Server Admin');
  IF v_n = 4 THEN
    pass('all four present');
  ELSE
    fail(TO_CHAR(4 - v_n) || ' of 4 missing - EVERY signed-in user 403s on the writes behind them',
         'restart the ABIS service (it restores them at startup), or run tools/bootstrap-admin.sh');
  END IF;

  -- 2. The IT group, its grants, and its members ---------------------------------
  say('');
  say('2. the IT group (security_group / _application / _user_group)');
  BEGIN
    SELECT user_group_id INTO v_group_id FROM security_group WHERE UPPER(TRIM(group_name)) = 'IT';
    pass('group exists', 'id ' || v_group_id);

    SELECT COUNT(*) INTO v_n FROM security_application;
    SELECT COUNT(*) INTO v_m FROM security_group_application
     WHERE user_group_id = v_group_id AND group_application_privilege = 1;
    IF v_m = v_n THEN
      pass('holds Write on every feature', v_m || ' of ' || v_n);
    ELSE
      fail('holds Write on only ' || v_m || ' of ' || v_n || ' features - 403 on screens that look available',
           'tools/grant_it_group.sql, or the API form in DB_REFRESH.md Part 5');
    END IF;

    SELECT COUNT(*) INTO v_m FROM security_user_group WHERE user_group_id = v_group_id;
    -- Membership is the one with no script: the right list is a plant decision, so this reports and
    -- does not prescribe. It was 1 of 5 on 2026-08-21 and nothing anywhere would have said so.
    SELECT LISTAGG(TRIM(u.login_id), ', ') WITHIN GROUP (ORDER BY u.login_id) INTO v_names
      FROM security_user_group g JOIN security_user u ON u.user_id = g.user_id
     WHERE g.user_group_id = v_group_id;
    IF v_m = 0 THEN
      fail('has NO members - its grants reach nobody',
           'add them: POST /api/security/users/{userId}/groups/' || v_group_id);
    ELSE
      warn(v_m || ' member(s): ' || NVL(v_names, '-'),
           'CHECK THIS LIST against who should be in IT - a refresh reverts it to prod''s and nothing else reports it.');
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      fail('no security_group named IT', 'create it, then re-grant (DB_REFRESH.md Part 5)');
    WHEN TOO_MANY_ROWS THEN
      fail('more than one group named IT', 'resolve the duplicate before granting');
  END;

  -- 3. The ABIS admin login -------------------------------------------------------
  say('');
  say('3. the ABIS admin login (security_user)');
  SELECT COUNT(*) INTO v_n FROM security_user WHERE UPPER(TRIM(login_id)) = 'CMATTINSON';
  IF v_n > 0 THEN
    pass('present');
  ELSE
    fail('missing - sign-in answers "user not found", which reads as an AD/LDAP fault',
         'sudo ./tools/bootstrap-admin.sh cmattinson Codi Mattinson  (on the APP host)');
  END IF;

  -- 4. Sequence drift -------------------------------------------------------------
  -- A representative sample rather than all 21: if these three are healthy the refresh's sequence
  -- handling worked, and the app re-syncs the full set at every startup anyway.
  say('');
  say('4. id sequences (a sample - the app re-syncs all of them at startup)');
  FOR r IN (
    SELECT 'COIL_ABC_NUM_SEQ' seq, 'COIL' tab, 'COIL_ABC_NUM' col FROM dual UNION ALL
    SELECT 'PROD_ITEM_NUM_SEQ', 'PRODUCTION_SHEET_ITEM', 'PROD_ITEM_NUM' FROM dual UNION ALL
    SELECT 'SYSTEM_LOG_ID_SEQ', 'SYSTEM_LOG', 'SYSTEM_LOG_KEY_NUM' FROM dual
  ) LOOP
    BEGIN
      EXECUTE IMMEDIATE 'SELECT NVL(MAX(' || r.col || '), 0) FROM ' || r.tab INTO v_m;
      SELECT last_number INTO v_n FROM all_sequences
       WHERE sequence_owner = 'DBO' AND sequence_name = r.seq;
      IF v_n > v_m THEN
        pass(r.seq, 'ahead of ' || r.tab || ' max (' || v_n || ' > ' || v_m || ')');
      ELSE
        fail(r.seq || ' is BEHIND ' || r.tab || ' max (' || v_n || ' <= ' || v_m || ') - inserts will ORA-00001',
             'restart the ABIS service, or run tools/resync_sequences.sql');
      END IF;
    EXCEPTION WHEN OTHERS THEN
      warn(r.seq || ' could not be checked', SQLERRM);
    END;
  END LOOP;

  -- 5. The ABIS_* config that the refresh is supposed to PRESERVE -----------------
  -- If any of these is empty the exclude did not work, which is a different and worse failure than
  -- anything above: it means the refresh deleted configuration that exists nowhere else.
  say('');
  say('5. ABIS-owned config (excluded from the refresh - must survive it)');
  FOR r IN (
    SELECT 'ABIS_EDI_PARTNER' t, 'EDI partner envelopes' d FROM dual UNION ALL
    SELECT 'ABIS_INI', 'legacy INI settings' FROM dual UNION ALL
    SELECT 'ABIS_X12_COIL', 'AISI coil-status code map' FROM dual UNION ALL
    SELECT 'ABIS_X12_SKID', 'AISI skid-status code map' FROM dual
  ) LOOP
    EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM ' || r.t INTO v_n;
    IF v_n > 0 THEN
      pass(r.t, v_n || ' rows (' || r.d || ')');
    ELSE
      fail(r.t || ' is EMPTY - the ABIS% exclude did not protect it',
           'restore from a backup; this config exists nowhere else. Check the parfile exclude.');
    END IF;
  END LOOP;

  -- 6. Things that are empty for their own reasons, reported so nobody re-investigates -
  say('');
  say('6. informational (empty is not necessarily wrong here)');
  SELECT COUNT(*) INTO v_n FROM abis_supervisor_pin;
  IF v_n = 0 THEN
    warn('no supervisor PINs enrolled', 'the DAS override cannot be used by anyone until someone enrols. '
         || 'This table IS excluded from the refresh, so an empty one was not caused by it.');
  ELSE
    pass('supervisor PINs enrolled', v_n || ' user(s)');
  END IF;

  SELECT COUNT(*) INTO v_n FROM abis_user_credential;
  IF v_n = 0 THEN
    pass('abis_user_credential empty', 'expected in AD/LDAP mode - AD holds the password, not ABIS');
  ELSE
    pass('abis_user_credential', v_n || ' local credential(s)');
  END IF;

  -- Verdict -----------------------------------------------------------------------
  say('');
  say('=== ' || v_fail || ' failure(s), ' || v_warn || ' warning(s) ===');
  IF v_fail > 0 THEN
    say('The app is NOT fully usable until the fixes above are applied. See docs/DB_REFRESH.md Parts 3-6.');
  ELSIF v_warn > 0 THEN
    say('No failures. Read the warnings - they are the things no script can decide for you.');
  ELSE
    say('Everything the modern app needs is present.');
  END IF;
END;
/

SET FEEDBACK ON
