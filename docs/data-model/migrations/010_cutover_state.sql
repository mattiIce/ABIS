-- Migration 010 — the cutover marker that stops a refresh destroying production
-- ================================================================
-- Apply on .230. Creates ABIS_CUTOVER_STATE and seeds the single row as NOT-yet-production, so
-- applying this changes no behaviour: refreshes go on working exactly as they do today.
--
-- WHY THIS EXISTS
--   .230 is today the non-prod sandbox, refreshed from prod (.9) so the new ABIS can be tested against
--   real data. **It is also the box that will BECOME production**: the plan is a final refresh from .9,
--   after which .230 diverges permanently and .9/.11 are retired. The two systems run in parallel
--   until then.
--
--   That makes `deploy/refresh-nonprod.sh` correct today and catastrophic the day after cutover. It is
--   `impdp ... table_exists_action=replace`; run once against a live production .230 it would overwrite
--   real orders, coils, shipments and PM history with the retired box's copy. And `docs/DB_REFRESH.md`
--   tells an operator to install it as a **Sunday 02:00 cron** — so the failure mode is not somebody
--   mistyping a command, it is a machine doing on a Sunday exactly what it was told to do months
--   earlier.
--
--   (Checked 2026-08-23 through the server console: that cron is NOT currently installed on .230. The
--   runbook documents automation nobody has armed yet. This guard is what makes arming it safe.)
--
-- WHY A TABLE AND NOT A FILE
--   A flag file on .230 could be lost in a rebuild, a migration to new hardware, or a restore from
--   backup — exactly the events after which somebody re-reads the runbook and re-arms the cron. The
--   marker belongs with the data it protects.
--
--   The name must start with ABIS_ : the refresh parfile excludes `LIKE 'ABIS%'`, so this table (and
--   the marker in it) survives every refresh. A marker a refresh could clear would be worthless — the
--   refresh would erase its own stop sign.
--
-- HOW IT IS USED
--   `refresh-nonprod.sh` reads it before touching anything and aborts if it says production. Setting it
--   is a deliberate, separate act: `deploy/declare-cutover.sql`.
--
-- IDEMPOTENCY
--   Guarded on USER_TABLES; re-running is a no-op and never resets an already-declared cutover.

DECLARE
  n PLS_INTEGER;
BEGIN
  -- Wrong-schema guard. sqlplus runs the script it was handed even when the CONNECT ahead of it
  -- failed, on whatever connection the session already had — that is how migration 011 created its
  -- tables in SYS on 2026-09-09 while reporting complete success (#455). This one matters more than
  -- most: ABIS_CUTOVER_STATE is what the refresh pre-flight reads to decide whether it is about to
  -- overwrite production. A copy in the wrong schema leaves DBO with no marker at all, and while the
  -- pre-flight does fail safe on an unreadable marker, it aborts the refresh with a message pointing
  -- at the wrong problem.
  IF USER <> 'DBO' THEN
    RAISE_APPLICATION_ERROR(-20010,
      'Migration 010 must be applied as DBO, not ' || USER || '. Reconnect with: CONNECT dbo');
  END IF;

  SELECT COUNT(*) INTO n FROM user_tables WHERE table_name = 'ABIS_CUTOVER_STATE';
  IF n = 0 THEN
    EXECUTE IMMEDIATE '
      CREATE TABLE abis_cutover_state (
        cutover_id     NUMBER(1)     DEFAULT 1 NOT NULL,
        is_production  NUMBER(1)     DEFAULT 0 NOT NULL,
        declared_utc   DATE,
        declared_by    VARCHAR2(64),
        note           VARCHAR2(400),
        CONSTRAINT pk_abis_cutover_state PRIMARY KEY (cutover_id),
        CONSTRAINT ck_abis_cutover_one   CHECK (cutover_id = 1),
        CONSTRAINT ck_abis_cutover_flag  CHECK (is_production IN (0,1))
      )';
    DBMS_OUTPUT.PUT_LINE('created ABIS_CUTOVER_STATE');
  ELSE
    DBMS_OUTPUT.PUT_LINE('ABIS_CUTOVER_STATE already present - skipped');
  END IF;

  -- Seed the single row as NOT production. Never overwrite an existing one: re-running this migration
  -- after cutover must not quietly re-open the door.
  --
  -- BOTH statements are dynamic, and that is not stylistic. PL/SQL resolves STATIC SQL at COMPILE
  -- time, so a block cannot name a table it creates with EXECUTE IMMEDIATE in the same block: on a
  -- schema where the table does not exist yet, the whole block fails to compile with ORA-06550 /
  -- ORA-00942 and NOTHING runs - not even the CREATE. That is exactly how the first version of this
  -- migration failed on .230 (2026-08-23). The error is a compile error, so it is all-or-nothing and
  -- left no partial state behind.
  EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM abis_cutover_state' INTO n;
  IF n = 0 THEN
    EXECUTE IMMEDIATE q'[INSERT INTO abis_cutover_state (cutover_id, is_production, note)
                         VALUES (1, 0, 'Parallel-running: .230 is the test target, refreshes from .9 are expected.')]';
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('seeded ABIS_CUTOVER_STATE as NOT production');
  ELSE
    DBMS_OUTPUT.PUT_LINE('ABIS_CUTOVER_STATE row already present - left as-is');
  END IF;
END;
/

-- Verify (0 = refreshes allowed, 1 = .230 is production and refreshes are blocked):
--   SELECT is_production, declared_utc, declared_by, note FROM abis_cutover_state;
