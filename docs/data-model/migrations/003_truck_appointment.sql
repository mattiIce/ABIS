-- Migration 003 — Truck appointment scheduling (ABIS-owned table)
-- ================================================================
-- A NEW ABIS-owned table backing the truck-appointment scheduling area. The plant
-- currently keeps the truck schedule in an Excel document; this replaces it in ABIS:
-- schedule inbound/outbound trucks into a dock + time window, gate check-in/check-out
-- onsite, and drive a live truck-status board.
--
-- The app self-provisions this table at startup (AbisSchema.EnsureOwnedTablesAsync,
-- idempotent), so applying this by hand is optional — it exists for DBA visibility.
-- appointment_id uses the portable MAX(id)+1 (no sequence). carrier_id is a LOOSE
-- reference to the legacy CARRIER master (no FK — this is ABIS-owned); carrier_name is a
-- display snapshot. ref_type/ref_id optionally link the appointment to a SHIPMENT
-- (packing_list) or RECEIVING (receiving_bol) row.
--
-- truck_status matches the plant's Excel "location status" legend: 0 Pending arrival,
-- 1 Running late, 2 Parked out back, 3 Sent to Bldg 1, 4 Sent to Bldg 2, 5 Sent to Bldg 3,
-- 6 Signed out / gone, 9 Cancelled. quantity = # coils (inbound) / # skids (outbound).


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
    RAISE_APPLICATION_ERROR(-20003,
      'Migration 003 must be applied as DBO, not ' || USER || '. Reconnect with: CONNECT dbo');
  END IF;
END;
/
WHENEVER SQLERROR CONTINUE NONE

CREATE TABLE abis_truck_appointment (
  appointment_id   NUMBER(12)     NOT NULL,
  direction        VARCHAR2(10)   NOT NULL,   -- INBOUND | OUTBOUND
  carrier_id       NUMBER(10),
  carrier_name     VARCHAR2(120),
  dock             VARCHAR2(30),
  scheduled_start  DATE,
  scheduled_end    DATE,
  ref_type         VARCHAR2(12),              -- SHIPMENT | RECEIVING | null
  ref_id           VARCHAR2(40),
  driver_name      VARCHAR2(80),
  tractor_num      VARCHAR2(30),
  trailer_num      VARCHAR2(30),
  seal_num         VARCHAR2(40),
  quantity         NUMBER(8),                 -- # coils (inbound) / # skids (outbound)
  truck_status     NUMBER(2)      DEFAULT 0 NOT NULL,
  checkin_time     DATE,
  checkout_time    DATE,
  notes            VARCHAR2(1000),
  created_utc      DATE,
  updated_utc      DATE,
  created_by       VARCHAR2(64),
  CONSTRAINT pk_abis_truck_appointment PRIMARY KEY (appointment_id)
);

CREATE INDEX ix_abis_truck_appt_start  ON abis_truck_appointment (scheduled_start);
CREATE INDEX ix_abis_truck_appt_status ON abis_truck_appointment (truck_status);
