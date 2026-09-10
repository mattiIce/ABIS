-- Migration 011 — the EDI transmit valve and its per-partner arming
-- ================================================================
-- Apply on .230. Creates both tables and seeds the valve CLOSED, so applying this changes nothing:
-- ABIS still transmits nothing at all.
--
-- ⚠️  Both tables are ABIS_-prefixed on purpose. The refresh parfile excludes LIKE 'ABIS%', so the
--     valve state survives a refresh. That cuts both ways and is worth being explicit about: a refresh
--     will NOT close a valve somebody opened. Closing it is always a deliberate act.
--
-- WHY A VALVE AT ALL
--   Legacy owns EDI transmission today: `ediprocess.sh` generates and `GXS.ksh` SFTPs `S*.edi` from
--   /templar/templar/incoming/senddata/ to the Inovis VAN. If ABIS also emits a document for the same
--   shipment, the trading partner receives it TWICE — and partners reconcile receipts and invoices off
--   these, so a duplicate 856 can become a double receipt and a duplicate 810 a double payment.
--
--   Until 2026-09-09 the modern engine had no transmit path whatsoever: `IEdiTransport` existed as a
--   declared interface that nothing referenced, registered or called. That is a stronger guarantee than
--   any flag, and it is the guarantee this migration is deliberately trading away in exchange for being
--   able to cut over.
--
-- WHY TWO TABLES
--   They answer different questions and want different shapes.
--
--   ABIS_EDI_TRANSMIT_STATE — the VALVE. One row, one boolean. Turning it off stops everything ABIS
--   would send, immediately, without anyone having to reason about partners. That is what you want at
--   2am. Every document passes one gate, so one switch really does close all of them.
--
--   ABIS_EDI_TRANSMIT_ARM — per (transaction_type, customer). Which documents may pass when the valve
--   is open. Opening the valve globally would duplicate the three documents legacy still sends
--   (Novelis 861, Aleris 861, Aleris 870), so enabling is necessarily per-partner: you arm ABIS for a
--   document in the same change that comments its line out of `ediprocess.sh`.
--
--   The two are ANDed. Nothing transmits unless the valve is open AND that pair is armed.
--
-- IDEMPOTENCY
--   Guarded on USER_TABLES and on the seed row already existing. Re-running never re-opens a valve or
--   re-arms a partner.
--
--   Every reference to the new tables inside the block is DYNAMIC. PL/SQL resolves static SQL at
--   COMPILE time, so naming a table the same block creates would fail to compile on a schema that does
--   not have it yet — and then nothing runs, not even the CREATE. Migration 010 shipped with exactly
--   that bug on 2026-08-23.

DECLARE
  n PLS_INTEGER;
BEGIN
  -- Refuse to run in the wrong schema. A sqlplus session whose CONNECT failed still executes the
  -- script it was handed, on whatever connection it already had — so this block can be fed to a
  -- `/ as sysdba` session and report complete success while creating both tables in SYS, where the
  -- API cannot see them and the refresh parfile's `LIKE 'ABIS%'` exclude does not cover them. That
  -- happened on 2026-09-09. Failing here is the difference between a visible error and a valve that
  -- silently reads closed forever.
  IF USER <> 'DBO' THEN
    RAISE_APPLICATION_ERROR(-20011,
      'Migration 011 must be applied as DBO, not ' || USER || '. Reconnect with: CONNECT dbo');
  END IF;

  SELECT COUNT(*) INTO n FROM user_tables WHERE table_name = 'ABIS_EDI_TRANSMIT_STATE';
  IF n = 0 THEN
    EXECUTE IMMEDIATE '
      CREATE TABLE abis_edi_transmit_state (
        state_id      NUMBER(1)     DEFAULT 1 NOT NULL,
        valve_open    NUMBER(1)     DEFAULT 0 NOT NULL,
        changed_utc   DATE,
        changed_by    VARCHAR2(64),
        note          VARCHAR2(400),
        CONSTRAINT pk_abis_edi_tx_state PRIMARY KEY (state_id),
        CONSTRAINT ck_abis_edi_tx_one   CHECK (state_id = 1),
        CONSTRAINT ck_abis_edi_tx_flag  CHECK (valve_open IN (0,1))
      )';
    DBMS_OUTPUT.PUT_LINE('created ABIS_EDI_TRANSMIT_STATE');
  ELSE
    DBMS_OUTPUT.PUT_LINE('ABIS_EDI_TRANSMIT_STATE already present - skipped');
  END IF;

  SELECT COUNT(*) INTO n FROM user_tables WHERE table_name = 'ABIS_EDI_TRANSMIT_ARM';
  IF n = 0 THEN
    -- customer_id 0 is not a sentinel for "all": arming is always for a NAMED partner, because
    -- "all partners" is exactly the mistake that duplicates the three legacy still sends.
    EXECUTE IMMEDIATE '
      CREATE TABLE abis_edi_transmit_arm (
        transaction_type VARCHAR2(10)  NOT NULL,
        customer_id      NUMBER        NOT NULL,
        armed            NUMBER(1)     DEFAULT 0 NOT NULL,
        armed_utc        DATE,
        armed_by         VARCHAR2(64),
        note             VARCHAR2(400),
        CONSTRAINT pk_abis_edi_tx_arm  PRIMARY KEY (transaction_type, customer_id),
        CONSTRAINT ck_abis_edi_tx_armf CHECK (armed IN (0,1))
      )';
    DBMS_OUTPUT.PUT_LINE('created ABIS_EDI_TRANSMIT_ARM');
  ELSE
    DBMS_OUTPUT.PUT_LINE('ABIS_EDI_TRANSMIT_ARM already present - skipped');
  END IF;

  EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM abis_edi_transmit_state' INTO n;
  IF n = 0 THEN
    EXECUTE IMMEDIATE q'[INSERT INTO abis_edi_transmit_state (state_id, valve_open, note)
                         VALUES (1, 0, 'Closed. Legacy (ediprocess.sh + GXS.ksh) owns EDI transmission.')]';
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('seeded ABIS_EDI_TRANSMIT_STATE with the valve CLOSED');
  ELSE
    DBMS_OUTPUT.PUT_LINE('ABIS_EDI_TRANSMIT_STATE row already present - left as-is');
  END IF;
END;
/

-- Verify (0 = ABIS transmits nothing, which is the expected state before cutover):
--   SELECT valve_open, changed_utc, changed_by, note FROM abis_edi_transmit_state;
--   SELECT transaction_type, customer_id, armed, armed_by FROM abis_edi_transmit_arm ORDER BY 1,2;
