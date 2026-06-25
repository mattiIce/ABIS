-- ABIS Oracle schema introspection
-- =================================
-- Recovers the REAL schema (tables, columns, PKs, FKs, indexes, sequences) from
-- the live ABIS database, so the partial/inferred model in docs/DATA_MODEL.md can
-- be replaced with ground truth. Also resolves the two write-path findings from
-- the Oracle validation (see docs/ORACLE_VALIDATION.md):
--   * real sequence names              -> fixes ORA-02289 on inserts
--   * the real audit/log table name    -> fixes ORA-00942 on opc_action_log
--
-- This is READ-ONLY: it only queries the data dictionary (ALL_* views).
--
-- How to run
-- ----------
-- sqlplus:
--   sqlplus user/pass@//192.168.1.230:1521/abc11 @tools/oracle_introspect.sql
--   (output is written to oracle_schema.txt via the SPOOL below)
-- SQL Developer:
--   open this file, set &OWNER below, Run Script (F5), save the Script Output.
--
-- Then paste/attach oracle_schema.txt back so tools/extract_schema.py can ingest it.

SET PAGESIZE 50000
SET LINESIZE 400
SET TRIMSPOOL ON
SET FEEDBACK ON
SET COLSEP '|'
SPOOL oracle_schema.txt

PROMPT ===== 0. Which schema OWNS the ABIS tables? (note the OWNER, set it below) =====
SELECT owner, table_name
FROM   all_tables
WHERE  table_name IN ('COIL','AB_JOB','CUSTOMER_ORDER','ORDER_ITEM','CUSTOMER')
ORDER  BY owner, table_name;

-- ---------------------------------------------------------------------------
-- Set the owner discovered above (UPPERCASE), then everything below scopes to it.
-- For this deployment the ABIS tables are owned by the DBO schema (confirmed via
-- step 0); change this if you point the script at a different schema/instance.
DEFINE OWNER = 'DBO'
-- ---------------------------------------------------------------------------

PROMPT
PROMPT ===== 1. Tables =====
SELECT table_name, num_rows, last_analyzed
FROM   all_tables
WHERE  owner = '&OWNER'
ORDER  BY table_name;

PROMPT
PROMPT ===== 2. Columns =====
SELECT table_name, column_id, column_name, data_type, data_length,
       data_precision, data_scale, nullable, data_default
FROM   all_tab_columns
WHERE  owner = '&OWNER'
ORDER  BY table_name, column_id;

PROMPT
PROMPT ===== 3. Primary / unique keys =====
SELECT c.table_name, c.constraint_name, c.constraint_type,
       cc.column_name, cc.position
FROM   all_constraints c
JOIN   all_cons_columns cc
       ON cc.owner = c.owner AND cc.constraint_name = c.constraint_name
WHERE  c.owner = '&OWNER'
AND    c.constraint_type IN ('P','U')
ORDER  BY c.table_name, c.constraint_name, cc.position;

PROMPT
PROMPT ===== 4. Foreign keys (child -> parent) =====
SELECT c.table_name      AS child_table,
       cc.column_name     AS child_column,
       cc.position,
       r.table_name       AS parent_table,
       rcc.column_name     AS parent_column,
       c.constraint_name
FROM   all_constraints c
JOIN   all_cons_columns cc
       ON cc.owner = c.owner AND cc.constraint_name = c.constraint_name
JOIN   all_constraints r
       ON r.owner = c.r_owner AND r.constraint_name = c.r_constraint_name
JOIN   all_cons_columns rcc
       ON rcc.owner = r.owner AND rcc.constraint_name = r.constraint_name
      AND rcc.position = cc.position
WHERE  c.owner = '&OWNER'
AND    c.constraint_type = 'R'
ORDER  BY c.table_name, c.constraint_name, cc.position;

PROMPT
PROMPT ===== 5. Indexes =====
SELECT i.table_name, i.index_name, i.uniqueness,
       ic.column_position, ic.column_name
FROM   all_indexes i
JOIN   all_ind_columns ic
       ON ic.index_owner = i.owner AND ic.index_name = i.index_name
WHERE  i.owner = '&OWNER'
ORDER  BY i.table_name, i.index_name, ic.column_position;

PROMPT
PROMPT ===== 6. Sequences (resolves ORA-02289: which sequences exist, if any) =====
SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM   all_sequences
WHERE  sequence_owner = '&OWNER'
ORDER  BY sequence_name;

PROMPT
PROMPT ===== 7. Audit / log tables (resolves ORA-00942 on opc_action_log) =====
SELECT owner, table_name
FROM   all_tables
WHERE  table_name LIKE '%LOG%'
   OR  table_name LIKE '%AUDIT%'
   OR  table_name LIKE 'OPC%'
ORDER  BY owner, table_name;

SPOOL OFF
PROMPT
PROMPT Done. Output written to oracle_schema.txt -- send it back for ingestion.
