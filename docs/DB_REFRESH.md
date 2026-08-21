# Refresh the non-prod DB (.230) from prod (.9)

Copy the live plant schema from **prod `192.168.1.9` / host `db01` / port `1523` (ABC11)** into the
**non-prod sandbox `192.168.1.230` / host `oeldb01` (abc11)** so the modernization UI (which reads
.230 — see [[abis-ui-production-data-source]]) shows current plant data.

> **Verified end-to-end 2026-07-23.** The values below are the real, working ones for this plant.

## Safety model
- **Reads prod only** (Data Pump export). Never writes to .9.
- **Destructive on .230** — that's the point; .230 is the write sandbox.
- **Preserves the modernization's `ABIS_*` tables** on .230 (their config — EDI partners, job runs —
  is not on prod and must survive). They are excluded from the refresh.
- A DB copy only: it runs **no** legacy EDI / scheduled job, so the no-live-firing guardrail is intact.

## What a refresh breaks — the whole list

The import is `schemas=DBO` with `table_exists_action=replace`, and only `ABIS_*` tables are excluded.
Everything else on this list is a **DBO table**, so prod's copy replaces .230's — and prod has never
heard of the modernization, so anything the modern app added is deleted. Nothing warns you; each one
surfaces later as a different-looking bug.

| What breaks | How it looks | Repaired by | Automatic? |
|---|---|---|---|
| **Id sequences** drift behind their table max | every id-minting INSERT fails `ORA-00001` | Part 3 | **Yes** — app startup |
| **The ABIS admin login** is deleted | sign-in fails "user not found" — looks like an AD/LDAP fault | Part 4 | No — run `bootstrap-admin.sh` |
| **The IT group's grants** revert to prod's | 403 on a screen that looks available | Part 5 | **Yes** — `refresh-nonprod.sh` |
| **The modern app's feature ROWS** are deleted | 403 on every Parts / maintenance / admin write, for everyone | Part 6 | **Yes** — app startup |

Two of those repair themselves, one is done by the refresh script, and **only the admin login needs a
person**. But read Part 6 before assuming the feature rows returning is the end of it: a feature nobody
holds still denies everyone, and the grants are Part 5.

## Two parts (why)
Network-mode Data Pump is fast and runs entirely on .230, but it **cannot move `LONG`/`LONG RAW`
columns over a DB link** (`ORA-31679`). A handful of legacy tables use `LONG` — including
**`OUTBOUND_EDI_TRANSACTION`, which the modern EDI page reads** (list / detail / 997 / stall check).
So the refresh is two parts:

1. **Bulk** — network import of every DBO table **except** `ABIS_*` and the `LONG` tables. → `deploy/refresh-nonprod.sh`
2. **LONG tables** — file-based (dump) import of the six `LONG` tables. → `deploy/refresh-long-tables.sh`

The `LONG` tables: `OUTBOUND_EDI_TRANSACTION`, `INBOUND_TRANSACTION`, `EDI_FILE_863`,
`IMPORTED_FILE_863`, `SKETCH`, `SKETCH_JPG`.

---

## One-time setup

### 1. Data Pump folder on .230 (OS, host `oeldb01`, user `oracle`)
```bash
mkdir -p /u01/app/oracle/dpump && chmod 750 /u01/app/oracle/dpump
```
```sql
-- as SYSDBA on .230
CREATE OR REPLACE DIRECTORY dpump_dir AS '/u01/app/oracle/dpump';
GRANT READ, WRITE ON DIRECTORY dpump_dir TO SYSTEM;
```

### 2. PUBLIC DB link to prod on .230 (SQL, as SYSDBA on .230)
Must be **PUBLIC** so the import account (`dbo`) can use it. Prod's listener is on **port 1523**
(host `db01`), service `abc11`. Paste as **one line** (SQL\*Plus splits statements at a blank line):
```sql
CREATE PUBLIC DATABASE LINK prod_9 CONNECT TO dbo IDENTIFIED BY "<dbo-pwd>" USING '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.1.9)(PORT=1523))(CONNECT_DATA=(SERVICE_NAME=abc11)))';
-- verify (returned 149837 live):
SELECT COUNT(*) FROM coil@prod_9;
```
The `dbo` password is the same on prod and non-prod. The import runs as `dbo` (owns the DBO schema);
grant it the import role once: `GRANT IMP_FULL_DATABASE TO dbo;` (as SYSDBA).

### 3. Passwordless ssh/scp prod (`db01`) → .230 (`oeldb01`)
Part 2 (the `LONG` tables) pushes a dump from prod to .230. Confirm `scp` from `db01` to
`oracle@192.168.1.230` works without a password (set up an ssh key if not).

---

## Run it manually (first time / on demand)

**Part 1 — bulk, on .230** (`impdp` is a shell command, not SQL\*Plus; connect to the local SID, no
`@alias`; a parfile avoids shell-quoting the excludes):
```bash
cat > /u01/app/oracle/dpump/net.par <<'EOF'
network_link=prod_9
schemas=DBO
table_exists_action=replace
exclude=TABLE:"LIKE 'ABIS%'"
exclude=TABLE:"IN ('OUTBOUND_EDI_TRANSACTION','INBOUND_TRANSACTION','EDI_FILE_863','IMPORTED_FILE_863','SKETCH','SKETCH_JPG')"
exclude=STATISTICS
logfile=dpump_dir:net.log
EOF
impdp dbo parfile=/u01/app/oracle/dpump/net.par      # enter dbo password
```
> Standard Edition → **no `parallel`**; 11g → **no `logtime`**. Expect `ORA-31684 "already exists"`
> noise (functions/sequences/views a table-replace doesn't touch) and a couple of `ORA-39083` FK
> warnings — normal; `impdp` returns exit **5** ("completed with errors") and that's success here.

**Part 2 — LONG tables, on prod `db01`** (export → copy → load on .230):
```bash
# on prod: keep the credential QUOTED - unquoted, bash reads <pwd> as a redirect
# and answers "pwd: No such file or directory" before expdp is reached.
expdp "dbo/<pwd>" directory=DATA_PUMP_DIR dumpfile=long_tabs.dmp logfile=long_exp.log reuse_dumpfiles=yes \
  tables=OUTBOUND_EDI_TRANSACTION,INBOUND_TRANSACTION,EDI_FILE_863,IMPORTED_FILE_863,SKETCH,SKETCH_JPG
scp /u01/app_11g/product/11.2.0/home/rdbms/log/long_tabs.dmp oracle@192.168.1.230:/u01/app/oracle/dpump/
# on .230:
impdp dbo directory=dpump_dir dumpfile=long_tabs.dmp table_exists_action=replace \
  tables=OUTBOUND_EDI_TRANSACTION,INBOUND_TRANSACTION,EDI_FILE_863,IMPORTED_FILE_863,SKETCH,SKETCH_JPG
```
Verify: `SELECT COUNT(*) FROM outbound_edi_transaction;` on .230 → 87617 (EDI page repopulates).

After: `EXEC DBMS_STATS.GATHER_SCHEMA_STATS('DBO', DEGREE=>1);` (optional, refreshes optimizer stats).

**Part 3 — re-sync the sequences (REQUIRED after every refresh).** A Data Pump table-replace imports
the row data but leaves the transactional **sequences behind their new table max** — the export is not
sequence-consistent. Confirmed 2026-07-24 on .230: **13 of 18 id sequences behind**, `COIL_ABC_NUM_SEQ`
by 877,220. Until they are advanced, **every id-minting INSERT fails with `ORA-00001`** (unique
constraint violated): order entry, coil mint, receiving BOLs, shift/skid/scrap creation, EDI
generation, downtime + error logging. This is the single most impactful post-refresh step for the
modern app, which runs on .230.

**On the DB host (`oeldb01` / .230), as `oracle`** - `codi-ABIS` has no Oracle client (the app uses
ODP.NET managed), so `sqlplus` there answers `command not found`. Let SQL*Plus prompt for the password
rather than putting it on the command line, where `ps` would show it to anyone on the box:

```bash
sqlplus -S /nolog
```
```sql
-- at the SQL*Plus prompt (CONNECT prompts for the password and never echoes it):
CONNECT dbo@//192.168.1.230:1521/abc11
@tools/resync_sequences.sql
```

> Do **not** paste `dbo/<pwd>@...` - bash reads `<pwd>` as a redirect and answers
> `pwd: No such file or directory` before sqlplus is ever reached.

Idempotent and safe to re-run (a sequence already ahead is skipped). Set `p_apply := FALSE` in the
script for a read-only dry run that only reports the gaps. Keep the (sequence, table, column) list in
the script in step with `AbisRepository.NextIdAsync` + the `Database:Sequences` overrides in
`appsettings.json`.

> **Automatic on the app host:** the ABIS API also self-heals this on **every startup** — on Oracle it
> advances any drifted sequence to `MAX+1` before serving (`AbisSchema.ResyncSequencesAsync`, logged;
> a no-op when healthy). So a **redeploy or restart of codi-ABIS corrects the drift with no manual
> step**, and this SQL script is the fallback for a box without the app or a manual run between deploys.
> Disable the startup pass with `Database:ResyncSequencesOnStartup=false` (e.g. if the app's DB user
> lacks `ALTER SEQUENCE`); then this script, run as DBO, is the only path.

---

## Weekly automation
Both scripts read credentials from the environment (prefer an Oracle wallet); they tolerate Data
Pump's exit-5 and won't wipe .230 if prod is unreachable.

- **`deploy/refresh-nonprod.sh`** — Part 1. Cron on **.230** (`oracle`), Sunday 02:00:
  ```cron
  0 2 * * 0  ORA_LOCAL="dbo/<pwd>" /home/oracle/scripts/refresh-nonprod.sh >> /home/oracle/scripts/refresh.log 2>&1
  ```
- **`deploy/refresh-long-tables.sh`** — Part 2. Cron on **prod `db01`** (`oracle`), Sunday 02:30
  (after Part 1), pushing to .230:
  ```cron
  30 2 * * 0  PROD_ORA="dbo/<pwd>" NONPROD_ORA="dbo/<pwd>" /home/oracle/scripts/refresh-long-tables.sh >> /home/oracle/scripts/refresh-long.log 2>&1
  ```

Because Part 1 **excludes** the `LONG` tables, the weekly network run never re-empties EDI/sketch
data again. Part 2 keeps that data current. If you skip Part 2 some week, the `LONG` tables simply
stay at their last sync (preserved, not wiped).

---

## Part 4 — restore the ABIS admin login (REQUIRED after every refresh)

**Every refresh wipes the ABIS admin login.** The import is `schemas=DBO` with
`table_exists_action=replace`, and `SECURITY_USER` / `SECURITY_GROUP` / `SECURITY_APPLICATION` /
`SECURITY_USER_GROUP` do **not** match the `'ABIS%'` exclude — so prod's copies replace them,
deleting any admin that existed only on .230. The symptom is a sign-in failing with
**"user not found"**, which looks like an AD/LDAP problem but is not one.

On the ABIS app host (`codi-ABIS`):

```bash
sudo apt-get install -y jq          # once; the script needs jq + curl
sudo ./tools/bootstrap-admin.sh cmattinson Codi Mattinson
```

Verify:

```bash
curl -s -H "X-Api-Key: $(grep -oP 'ApiKeys__Keys__0="?\K[^"]+' /etc/abis/abis.env)" \
  http://127.0.0.1:8080/api/security/users | grep -o cmattinson
```

**You do not need to reset the password.** `abis_user_credential` *does* match `'ABIS%'`, so it
survives the refresh, and it is keyed by `login_id` (not `user_id`) — recreating the
`security_user` row with the same login re-attaches the existing credential. In AD/LDAP mode the
password was never in ABIS to begin with: AD verifies it, while ABIS still needs the
`security_user` row for identity + RBAC (see `docs/AD_LOGIN.md`), which is exactly the row that
got wiped.

To automate it, set these before running `refresh-nonprod.sh` and it will restore the admin itself:

```bash
export ABIS_ADMIN_LOGIN=cmattinson
export BOOTSTRAP_ADMIN=/path/to/ABIS/tools/bootstrap-admin.sh
export ABIS_BASE=http://192.168.3.110:8080   # the app host, not the DB host
export ABIS_API_KEY=...                      # or let bootstrap-admin read /etc/abis/abis.env locally
```

If you would rather .230 keep its **own** user list across refreshes, add
`exclude=TABLE:"LIKE 'SECURITY%'"` to the parfile in `refresh-nonprod.sh`. That removes the wipe
entirely, at the cost of non-prod no longer mirroring prod's users for RBAC testing.


## Part 5 — restore the IT group's full grants (REQUIRED after every refresh)

Same cause as Part 4, different table. `SECURITY_GROUP_APPLICATION` is a DBO table and does not match
the `'ABIS%'` exclude, so **prod's copy replaces it** and the IT group reverts to whatever prod has.

The plant's instruction (2026-08-05) is that **IT holds full read/write/modify on every component of
ABIS**. On .230 that meant adding five features it lacked — `Line Employees`, `Maintenance_logs`,
`Part Number`, `Scheduler Admin`, `Server Admin` — all at privilege 1 (Write).

The symptom if you skip this is a 403 on a screen that looks available, which reads like a bug in the
page rather than a missing grant.

**`refresh-nonprod.sh` now does this for you** — it runs the script against the database it is already
connected to, with no opt-in, because unlike Part 4 this needs no call to the app host. Run it by hand
only if you refreshed some other way.

> **On the DB host (`oeldb01` / .230), as `oracle` — NOT on the app host.** `codi-ABIS` has no Oracle
> client: the app talks to Oracle through ODP.NET managed, so there is no `sqlplus` there and this
> fails with `sqlplus: command not found`. If you are on the app host, use the API form below instead.

```bash
sqlplus -S /nolog
```
```sql
-- at the SQL*Plus prompt (CONNECT prompts for the password and never echoes it):
CONNECT dbo@//192.168.1.230:1521/abc11
@tools/grant_it_group.sql
```

It is deliberately NOT done at app startup. The sequence self-heal can run on every boot because a
sequence behind its max is always wrong; a grant is policy. If the plant later narrows what IT holds,
an app that re-widened it on every restart would silently overrule them.

**From the app host instead (no Oracle client needed).** Same effect through the API — idempotent, sets
privilege 1, removes nothing. It authenticates with the API key, which bypasses RBAC, so it still works
when nobody yet holds `User Control`:

```bash
KEY=$(grep -oP 'ApiKeys__Keys__0="?\K[^"]+' /etc/abis/abis.env); B=http://127.0.0.1:8080
GID=$(curl -sS -H "X-Api-Key: $KEY" $B/api/security/groups | jq -r '.[]|select((.groupName//""|ascii_upcase|gsub("^ +| +$";""))=="IT")|.userGroupId')
for AID in $(curl -sS -H "X-Api-Key: $KEY" $B/api/security/applications | jq -r '.[].applicationId'); do
  printf '%s:%s ' "$AID" "$(curl -sS -o /dev/null -w '%{http_code}' -H "X-Api-Key: $KEY" -H 'Content-Type: application/json' -X PUT $B/api/security/groups/$GID/applications/$AID -d '{"privilege":1}')"
done; echo
```

Every feature should print `:204`.

Idempotent: it raises anything below Write, adds anything missing, removes nothing, and touches no
other group. It resolves the group by NAME rather than id (the id is whatever prod has after a
refresh) and fails loudly if IT does not end up holding every feature.

> **Prod (.9) is read-only** — do not run it there. Production security is owned by legacy ABIS and
> changing it is a plant decision made through that application.

## Part 6 — the modern app's feature rows (automatic since 2026-08-21)

`SECURITY_APPLICATION` is the legacy app's vocabulary — 35 names on prod. The modernization gates on
four that were never in it:

| Feature | What answers 403 without it |
|---|---|
| `Part Number` | every write on the Parts page |
| `Maintenance_logs` | every maintenance / PM write |
| `Scheduler Admin` | the scheduled-job registry |
| `Server Admin` | the server console |

Because `SECURITY_APPLICATION` is a DBO table, **every refresh deletes all four**, and the failure is
particularly misleading: `RequireFeatureAsync` asks for the signed-in user's privilege on the named
feature, a feature that does not exist has no privilege to return, and the endpoint answers **403**.
That is not "this user lacks permission" — *nobody can hold a feature that is not in the table.*

**The app now restores them on every startup** (`AbisSchema.EnsureRequiredFeaturesAsync`, Oracle only,
non-fatal). It only ever INSERTs a name that is missing — nothing is renamed, re-pointed or deleted —
so a feature the plant has since granted keeps its id and its grants. Each restore logs a **warning**
naming the feature, because needing to restore one means writes were failing until that moment:

```
warn: Restored missing security feature Part Number as application_id 37. …
```

> **Restoring the row is not the same as restoring access.** A feature with no grants denies everyone
> exactly as a missing one does. On 2026-08-21 the rows came back at ids 37–40 with **zero grants**, and
> Parts writes stayed 403 until Part 5 ran. Startup fixes the vocabulary; Part 5 fixes who holds it.
> Do both.

Why the rows self-heal but the grants do not: a feature the app gates on must exist or the app cannot
work, so recreating it is never wrong. A grant is policy — if the plant narrows what IT holds, an app
that re-widened it on every restart would silently overrule them.

Verify:

```sql
SELECT application_id, TRIM(application_name)
  FROM security_application
 WHERE TRIM(application_name) IN ('Part Number','Maintenance_logs','Scheduler Admin','Server Admin');
```

Four rows, and after Part 5 each should carry a grant. The list is kept in step with
`tools/bootstrap-admin.sh` by a test (`RequiredFeatureTests`), which also refuses any feature the app
gates on that neither the legacy schema defines nor the app restores — the check that would have caught
this three incidents ago.

## Notes
- The two `ORA-39083` FKs left disabled after a bulk refresh (`AB_JOB→SKETCH_JPG`, a Quest tool FK)
  re-validate once Part 2 loads `SKETCH_JPG`; re-enable if desired (`ALTER TABLE ab_job ENABLE
  CONSTRAINT <name>;`) — non-critical.
- The modern app on codi-ABIS keeps running against .230 throughout; `ABIS_*` config is untouched.
