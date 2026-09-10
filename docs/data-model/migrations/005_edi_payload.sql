-- 005_edi_payload.sql — the ABIS-owned generated-EDI payload store.
--
-- The legacy EDI engine wrote each generated X12 to a file on the DB host (utl_file) and only tracked it
-- in outbound_edi_transaction. The modern engine (docs/EDI_ENGINE.md) keeps the payload itself here, as a
-- CLOB (NOT the deprecated LONG RAW), keyed by edi_file_id + transaction set. The 861 (Receiving Advice)
-- carries its source receiving_bol_id so a BOL's advice can be looked up and re-generation guarded.
--
-- The app provisions this automatically at startup (AbisSchema.EnsureOwnedTablesAsync); this script is the
-- canonical DDL for manual/DBA use. Idempotent by intent: skip statements for objects that already exist.
--
-- GENERATION ONLY. Nothing in the modern stack transmits this payload — the VAN SFTP stays the single
-- legacy owner (the no-live-firing guardrail). This table is the boundary: build + store, never send.


-- Wrong-schema guard. sqlplus runs the script it was handed even when the CONNECT ahead of it failed,
-- on whatever connection the session already had — that is how migration 011 created both its tables
-- in SYS on 2026-09-09 while printing complete success (#455). A stray ABIS_* table in another schema
-- is also outside the refresh parfile's LIKE 'ABIS%' exclude, which covers the DBO export only, so no
-- refresh would ever clear it.
--
-- This migration is bare DDL with no PL/SQL block of its own, so the guard is a prologue. The
-- WHENEVER pair is deliberate: EXIT FAILURE makes the RAISE actually stop the script (a raised error
-- alone does not), and CONTINUE NONE immediately restores sqlplus's default so the DDL below keeps
-- the error behaviour it has always had — re-running still reports ORA-00955 per object and carries on.
WHENEVER SQLERROR EXIT FAILURE
BEGIN
  IF USER <> 'DBO' THEN
    RAISE_APPLICATION_ERROR(-20005,
      'Migration 005 must be applied as DBO, not ' || USER || '. Reconnect with: CONNECT dbo');
  END IF;
END;
/
WHENEVER SQLERROR CONTINUE NONE

CREATE TABLE abis_edi_payload (
  edi_file_id       NUMBER(12)     NOT NULL,
  transaction_type  VARCHAR2(6)    NOT NULL,   -- '861', '870', '846', '856', '863'
  receiving_bol_id  NUMBER(12),                -- source BOL for the 861; null for other sets
  customer_id       NUMBER(10),
  edi_file_name     VARCHAR2(80),              -- e.g. S_Novelis_1234.edi
  payload           CLOB           NOT NULL,   -- the full X12 interchange (ISA..IEA)
  created_utc       DATE,
  CONSTRAINT pk_abis_edi_payload PRIMARY KEY (edi_file_id, transaction_type));

CREATE INDEX ix_abis_edi_payload_bol ON abis_edi_payload (receiving_bol_id, transaction_type);
