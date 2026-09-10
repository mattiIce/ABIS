-- Migration 002 — User password credentials (ABIS-owned table)
-- ================================================================
-- A NEW ABIS-owned table backing the modern username/password login. The legacy
-- PowerBuilder ERP had NO application password column: it authenticated every user as a
-- real Oracle database account (login = a live Oracle CONNECT with the typed credentials;
-- see legacy/src/security/w_security_check.srw). There is therefore no legacy password
-- hash to migrate — the modern app keeps its own credential store here, one PBKDF2 hash
-- per security_user login.
--
-- The app also self-provisions this table at startup (AbisSchema.EnsureOwnedTablesAsync,
-- idempotent, ORA-00955-swallowing), so applying this file by hand is optional — it exists
-- for DBA visibility / a controlled rollout. No sequence needed (login_id is the key).
--
-- password_hash format (self-describing): pbkdf2-sha256$<iterations>$<b64 salt>$<b64 hash>.
-- must_change = 1 forces a change on first sign-in after an admin sets an initial password.
-- Only the derived hash is ever stored — never the plaintext.


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
    RAISE_APPLICATION_ERROR(-20002,
      'Migration 002 must be applied as DBO, not ' || USER || '. Reconnect with: CONNECT dbo');
  END IF;
END;
/
WHENEVER SQLERROR CONTINUE NONE

CREATE TABLE abis_user_credential (
  login_id       VARCHAR2(64)   NOT NULL,
  password_hash  VARCHAR2(200)  NOT NULL,
  must_change    NUMBER(1)      DEFAULT 1 NOT NULL,
  updated_utc    DATE,
  updated_by     VARCHAR2(64),
  CONSTRAINT pk_abis_user_credential PRIMARY KEY (login_id)
);

-- One credential per login, case-insensitively (matches the app's LOWER(login_id) lookup).
CREATE UNIQUE INDEX ux_abis_user_cred_login ON abis_user_credential (UPPER(login_id));
