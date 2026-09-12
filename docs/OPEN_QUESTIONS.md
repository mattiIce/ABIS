# Open questions — what the modernization needs from the plant

One register for everything that is **blocked on a human answer** rather than on engineering time.
Each entry says what is blocked, exactly what is needed, and what happens under each answer, so a
five-minute reply unblocks real work.

Last reviewed **2026-09-11**. Companion to [`REMAINING_WORK.md`](REMAINING_WORK.md) (which tracks work
that needs no input) and [`EDI_CLIFFS.md`](EDI_CLIFFS.md) (the Cliffs program in full).

**Convention:** 🔴 blocks 1.0.0 · 🟡 blocks a feature · ⚪ nice to settle.

---

## A. Cleveland-Cliffs EDI onboarding

Cliffs is an **onboarding** partner, not a running one — 0 orders, 0 coils, cron commented out
`TEST ONLY`, every archived file the empty placeholder. So no golden file exists or can exist, and the
guides are the spec. Only the 846 is built. Details and evidence in [`EDI_CLIFFS.md`](EDI_CLIFFS.md).

### A1 🔴 Which Cliffs works are we processing for, and what is `606072130`?

The guides give four `N1*MF` (Steel Producer) DUNS:

| Works | DUNS |
|---|---|
| Indiana Harbor | `005159199` |
| Kote | `613460476` |
| Burns Harbor | `003913423` |
| Cleveland Works | `122373918` |

The DUNS we hold for customer 3061 is **`606072130`** — **none of them**. And it is doing two jobs at
once: it is the partner profile's **ISA08** (an envelope address) *and* what the legacy proc hardcodes
into the **`N1*MF` body** (a party identity). It cannot correctly be both.

Note the customer is named "CLIFFS STEEL-**CLEVELAND**" while every example identifier in the guides
is Indiana Harbor's.

- **If `606072130` is a VAN mailbox id** → it stays in ISA08 and the body needs the real works DUNS,
  which may vary per coil (the works that produced it).
- **If it is a party DUNS** → it is stale and needs replacing in both places.
- **If we process for more than one works** → the body value becomes per-material, not per-partner,
  and the 846/861/870 all need a works lookup they do not have today.

*Pinned by a test in `Edi846GeneratorTests` so it cannot be quietly forgotten.*

### A2 🔴 The ISA/GS envelope for every set other than the 846

Sender/receiver qualifiers and ids, the VAN mailbox, the test-vs-production indicator, and whether
Cliffs wants the same `~` segment terminator and `|` component separator the 846 profile carries.

**None of this is in the implementation guides** — it comes from a trading-partner setup sheet we were
not given. **Everything past the 846 is blocked on it**, because the envelope is in every file.

*Ask Cliffs for the trading-partner setup sheet / EDI profile for ABCo.*

### A3 🟡 Is the 810 (Invoice from Processor) in scope?

The guide was supplied, but the 810 is **absent from Cliffs' own 19-case certification plan**. Either
it certifies separately or it is a later phase.

### A4 🟡 LIN item-number qualifier — `VN` (guide) or `PO` (proc)?

The guide's LIN carries `VN` with an *item number* (`01` for Indiana Harbor / Kote / Cleveland;
order-dependent for Burns Harbor). The legacy proc emits `PO` with `customer_po`. Its own commented
draft line put the literal `01` behind a `PO` qualifier — so the author knew the value and used the
wrong qualifier for it.

### A5 🟡 Which optional segments does Cliffs require of us?

`MEA*PD*TH / WD / LN`, `MEA*CT`, the theoretical weight `MEA*WT*WT*…*24`, `DTM*009`, `PID*S*QAS`
(table 68), `REF*RV` (intransit). All marked *"OPTIONAL — based upon customer requirements"* in the
guides and all commented out in the proc. The underlying data (gauge, width, lineal feed) is populated
on live coils, so these are cheap once Cliffs says which.

### A6 🟡 Do we store the customer PO at all?

Cliffs' own test template carries a prep note to their implementer: *"Check with site to make sure
they store the Order, Cust PO#, Cust Part#, etc..."*. On `.230`, **`coil.customer_po` is NULL on all
216 on-hand coils**, and so is `inbound_coil.customer_po` for every one of them. Any segment sourcing
a customer PO emits nothing today.

### A7 — plant-side data fixes (one of them needs an EDI decision after all)

- `abis_x12_coil` has **no row for coil status 2 ("New")**, although status 2 *is* in the on-hand
  cursor's status list → every new coil ships an empty `PID*S*MA` material status.
  ⚠ **Measured 2026-09-12: this is the DOMINANT case, not an edge one — 165 of the 180 on-hand coils on
  `.230` are status 2 (92%).** So an 846 inventory advice would carry an empty material status for nearly
  every line. The 846 generator deliberately still emits the segment with an empty PID04 rather than
  dropping one the guide requires, so the file points at the real cause.
  <br>**And it is not decision-free:** the row needs an AISI table-67 class and table-70 status chosen for
  "New" by whoever owns the EDI mapping. Neighbouring rows suggest the shape (status 1 → `01`/`7`,
  12 → `01`/`0`, 11 → `01`/`E`) but guessing a code that ships to a trading partner is not a data fix.
  ABIS seeds this map verbatim from `.230`, hole included, so fixing the plant row fixes both.
- The same map stores the literal string **`NA`** for skid statuses 12 and 15, which is not a valid
  AISI code.
- `customer.customer_duns_number` (NUMBER) is NULL for 3061 while `customer_duns_number_string` is
  populated. **Leave it that way** unless A1 is resolved first — the legacy proc's `N1` line is missing
  a `*` and only produces valid output *because* that column is NULL.

---

## B. Blocks 1.0.0

### B1 🔴 The end-coil balance gate — the live observation

**Status: the gate WARNS, it does not block.** Deliberate and temporary.

Legacy refuses to close a coil more than **0.5%** out of balance. Ported, then measured over **926
consumed coils** on `.230`: median discrepancy **6.3%**, with only 117/926 inside tolerance. Blocking
on that would demand a supervisor for *every* coil, turning the override into a rubber stamp and
destroying the audit trail the PIN exists to create — so it was softened to a warning (#403).

**What settles it — from the legacy DAS end-coil screen, for ONE coil:**

1. The **coil number** (without it nothing joins back to the database).
2. The four on-screen figures: `st_skid_wt`, `st_scrap_wt`, `st_hl`, `st_percent`.
3. The coil's starting weight and the weight typed as remaining.
4. Whether **OK was disabled** / the **Override** button appeared.

**How to read it:**
- On-screen % is small (<0.5%) but the database says ~6% for that coil → the sources genuinely differ;
  find what the recap grids read that the tables do not, then **restore the block**.
- On-screen % is *also* ~6% → the plant already overrides on every coil and the 0.5% tolerance is
  effectively dead; the question becomes what tolerance is real.

Restoring the block is a one-line change in `das-console.ts`. Full detail in `docs/SUPERVISOR_PIN.md`.

> Reported not running on 2026-08-20.

### B2 🔴 The cutover — a date for the final refresh

`.230` **becomes** production: a final refresh from `.9`, after which it diverges permanently and
`.9`/`.11` are retired. Until then the two run in parallel for testing only. **ABIS is already on the
right box — the cutover moves the data, not the app.** (This entry used to read "`.110` still reads
the sandbox", which framed the fix as re-pointing ABIS at `.9`, the machine being retired. Corrected
in #453.)

What is needed is a date. The sequence is [`DB_REFRESH.md`](DB_REFRESH.md) Part 9: the final refresh,
its Part 3–8 repairs, then `deploy/declare-cutover.sql`. The guard that stops a later refresh
destroying production is in place (#448). Enabling `Notifications:EdiStall` waits on this, because
`.230`'s outbound-EDI ledger is a copy of prod's until then.

### B4 🔴 Receiving against the mill's ASN — in scope for 1.0, and who owns the Novelis 861?

**Found 2026-09-11 while porting the archived-BOL list.** Modern receiving works from lines typed in
or scanned; legacy's receiving screen starts, for the big mills, from the ASN the mill sent. On `.230`,
**848 of the 1,921** receiving BOLs of the last 12 months match an inbound ASN for the same customer —
essentially all of Novelis Oswego (253/254), Kingston (61/61), Guthrie (37/37), Constellium BG
(166/169) and Arconic (112/115). Stellantis, Superior Cam, Sherman and the rest (1,070) have no ASN
and are unaffected.

**What legacy does that ABIS does not:**

1. `w_coil_receiving` lists the incoming ASNs (`dw_incomingedi`) and pulls one's coils into the BOL.
2. Saving it sets the ASN to **status 3** with a received time, and each ASN coil to **status 1**
   (imported) or 2 (damaged).
3. The 861 then comes from two places. At receiving, for customers flagged
   `customer.create_861_at_receiving = 'Y'` — on `.230` that is Novelis Kingston, Oswego and Guthrie,
   Constellium BG, Arconic and Cliffs — unless one already exists for the BOL. And the `ediprocess.sh`
   cron runs `p_create_edi_861_for_all` every 30 minutes, which **picks up status-3 BOLs for Novelis
   (1153/1459/2582)** whose coils are all imported or damaged, builds their 861 and sets status 1.

ABIS writes neither ASN status table, and nothing in it ingests an 856 — that parser is deferred as
data-blocked (`REMAINING_WORK.md` §A). **So after the cutover, the ASN queue would stop filling and
never drain, and these receipts would be keyed by hand.**

**⚠ A port cannot just write status 3.** `ediprocess.sh` is live on `.230`, so doing that there makes
legacy generate Novelis 861s into `.230`'s ledger (not transmitted — `GXS.ksh` is commented out), and
the same write against the production-era database would be a duplicate-861 risk. Whatever ABIS
writes has to be decided together with who owns the Novelis 861.

**What is needed:**

- **Is ASN-driven receiving in scope for 1.0?**
  - **Yes** → it needs the 856 parser too. The "no golden" objection may be weaker than it was: `.230`
    holds the parsed output for 43,948 BOLs back to 2004, so **if any raw inbound `.856` file survives**
    (none is documented — worth asking whoever runs `db01`), it could be checked against rows that
    already exist. Then the receiving screen gains an ASN picker.
  - **No, not at first** → receiving for those mills is typed or scanned after the cutover, and the
    Novelis 861 needs another trigger, because today it fires off ASN status 3.
- **Who owns the Novelis 861 at cutover** — the legacy cron (then ABIS must write status 3, and only
  after the cutover), or ABIS's own 861 (then the cron line is commented out first, per the valve's
  single-owner rule).

Until then the archived-BOL list on Coil inventory is read-only and changes nothing.

---

## C. Blocks a feature

### C1 🟡 Confirm the shipment status legend before cutover

The guided BOL close-out **assumes `0` = Shipped**. Built and working on that assumption; confirm
against the plant's definitive status list before anyone relies on it.

### C2 🟡 Five DAS tags are still ungated, on purpose

A plant decision about which tags require a supervisor, not a code change.

### C3 🟡 Server-console restart button — on or off?

Needs a polkit rule if on. Spec in `docs/SERVER_CONSOLE.md`.

### C4 🟡 Recovery report suite — source-incomplete, needs an export or a golden

The ~10 per-customer recovery report templates cannot be ported from what the repo holds, and the gap
is specific: every one of them is an **external** DataWindow. They carry the full layout — columns,
headers, grouping, page setup — but **no SQL**. Their columns are positional slots (`name_1`,
`name_2`, …) filled by PowerScript, and the window that does the filling is not in `legacy/src/`.

It is not recoverable from the `.pbl` files either. All 49 in the repo hold `DAT*` blocks but **zero**
`release N;` markers — compiled objects, not text source — and grepping every deblocked payload for
the report names returns nothing. The vendored `.srd`s came from an IDE export done elsewhere.

**They are live.** `.230` carries **14 recovery customers**, matching the templates: Constellium West
Virginia, Arconic-Lancaster (the `alcoa_lancaster` template, renamed since), four Samuel entities, and
Novelis Kingston with **two** rows — one `auto_only`, one `comm_only`, so the autoparts split is in
real use. These go to customers, so inventing the aggregation is the wrong move.

**What would unblock it, best first:**

1. **A fresh PowerBuilder IDE export** of the library holding the recovery-report window — exactly
   faithful, and the same route that produced the rest of `legacy/src/`.
2. **A golden output per template** (print to PDF, or the Excel export). The trick that made the EDI
   ports trustworthy: reconstruct the aggregation from the tables, then check every number against a
   real one. Works with no source at all.
3. **Reconstruct from layout + tables and have the plant verify** — possible, but with nothing to check
   against, on customer-facing paper.

**Also worth answering:** which of the ~10 are still used? One is a `_bk` backup copy, and the
customer-specific ones may have outlived their customers.

*Not blocked, and being built separately: the recovery **data** rules (autoparts filter, office-beats-DAS)
are fully sourced in the vendored `w_recovery.srw`.*

### C5 🟡 QA coil photos + QA email — source-complete, infrastructure-blocked

Both halves are fully readable in the vendored source (`qa/w_new_qa_coil.srw`, `qa/w_send_email_qa.srw`).
Neither can be built without answers about where things live, because **neither touches the database**.

**The photos are files on a Windows share, with no DB record at all.** The operator's PC stages them in
`C:\COILPHOTO` (`QA_PICTURE.LOCAL_FOLDER_BASE`), then a literal `cmd /c move` pushes them to
`<FOLDER_BASE>\<coil_abc_num>\` — default `E:\PHOTO`. The "picture list" on screen is a `DirList()` of
that directory. There is no `coil_pic` table; grep the DDL and nothing comes back.

**The email is MAPI, and its recipients are chosen by the operator at send time.** `w_send_email_qa`
opens a `mailSession`, attaches every photo in the coil's folder, sets the subject to
*"Quality issue of Coil ABC# {n}"*, and calls `mailAddress()` — which pops the desktop mail client's
address book. **There is no recipient list in the code**; a person picks, every time.

**What is needed before this can be built:**

1. **Where is `E:\PHOTO` actually?** It is a drive letter on a PowerBuilder client, so almost certainly a
   mapped share. The API server is Ubuntu — it needs the UNC path and read access (a CIFS mount), or the
   photos need migrating into the database / object storage.
2. **How many photos and how large?** That decides mount-and-serve versus migrate.
3. **Who should the QA email go to?** In legacy nobody decided — the operator picked from an address book
   each time. A web app can offer a typed list, a configured list, or both, and that is a plant choice.
   Note this is **operator-composed outbound mail with attachments**: it stays behind
   `Email:OverrideRecipient` and an off-by-default switch like every other notification.

Until then the QA console can show everything except the photos, which is what it does today.

### C7 🟡 WinSPC — needs live-DB discovery

Legacy had `w_quality_winspc`. A read-only connector is built and off by default (`WinSpc:Enabled`, see
`appsettings.json`). This entry used to call WinSPC the unblock for the dimension-check QC gate; that
premise was wrong — see *Resolved* at the end.

---

## D. Deprioritised by the user, recorded so it is not lost

### D1 ⚪ Paper has never printed

The two 4×6 tags and the Certificate of Conformance have never been put on paper. Deprioritised
2026-08-19. ZPL orientation errors only fail *visibly* on paper, so this stays a real risk until done.
`192.168.10.53` is the authorized test printer; the `192.168.9.x` printers are production and
`tools/labelprint` refuses them without `--allow-production`.

---

## E. Standing constraints — not questions, and not negotiable by a passing decision

- **Never transmit EDI.** The transmit seam stays a no-op; the legacy crontab on db01 is sole owner
  until a single-owner cutover. Duplicate transmission = duplicate EDI to trading partners.
  **Cliffs adds a second reason:** nothing has *ever* been sent to them, so a stray send is first
  contact, not a duplicate.
- **`.9` (prod) and `.11` (dev/EDI) are strictly read-only.** Only non-prod `.230` is a write sandbox.
  `tools/oraq` enforces SELECT-only.
- **Never re-run legacy tracking** alongside the modern stacker board — competing writers.
- **Plant access rides a VPN** that surfaces as a `192.168.8.x` address. No `192.168.8.x` means no
  route to anything plant-side, and it looks exactly like a plant outage.

---

## Resolved since the 2026-08-20 review

Removed from the sections above so the register only holds live questions.

- **B3 — sequence drift after a refresh** no longer needs an operator. The API advances any drifted
  sequence on every startup (`AbisSchema.ResyncSequencesAsync`), so restarting or redeploying `.110`
  after a refresh repairs it; `tools/resync_sequences.sql` remains for a manual run.
- **C6 — the KeepTrak import is done.** On `.230`, 144 of 221 PMs, 236 PM actions and 13,703 of
  15,754 completions carry a KeepTrak `kt_ref`, and #440 stops a refresh deleting them. The spares
  finding from that entry still stands: the Oracle `PARTS` tables are a dead 2010 load (see
  [`REMAINING_WORK.md`](REMAINING_WORK.md)).
- **The dimension-check "QC gate" was never a gate.** Legacy's `in_spec` is a checkbox the inspector
  ticks — in both `coil_eval/d_skid_dim_check.srd` and `da/d_skid_dim_check_per_skid.srd`, with no
  tolerance expression in either — and all 275 checks on `.230` are recorded as pass. There is nothing
  computed to port.
