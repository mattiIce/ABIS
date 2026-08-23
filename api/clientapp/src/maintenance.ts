// ABIS Maintenance — the legacy maintenance window, restyled to the design system in the shared
// shell (#4 polish). Filterable maintenance-log search and a full load → edit → save form (create
// or replace). The replace path re-sends all writable fields (probDateTime/probDetails/author are
// NOT NULL) so a partial edit can't blank them. Through the NSwag-generated, compiler-checked client.
//
// Compiled by tsc to wwwroot/ui/app/maintenance.js; served at /ui/maintenance.html.
import { AbisClient, MaintLogWrite, PmDefinition, PmWrite, PmActionWrite, PmCompleteWrite } from './generated/abis-client.js';
import { authFetch } from './auth.js';
import { initShell } from './shell.js';
import { exportXlsx } from './xlsx.js';
import { pmListTable, toCsv } from './maintenance-export.js';

const $ = <T extends HTMLElement = HTMLElement>(sel: string): T => document.querySelector(sel) as T;
const client = (): AbisClient => new AbisClient('', { fetch: authFetch });
const esc = (s: unknown): string =>
  String(s ?? '').replace(/[&<>"]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c] as string));
const setErr = (m: string) => { $('#err').textContent = m; };
const setOk = (m: string) => { $('#ok').textContent = m; };
const setBusy = (b: boolean) => document.body.classList.toggle('busy', b);
const v = (id: string) => $<HTMLInputElement>(id).value.trim();

/**
 * What actually went wrong, from an NSwag ApiException.
 *
 * The generated client's `message` for a non-2xx is the generic "An unexpected server error
 * occurred." — so a **403** on a PM write read as though the server had broken, sending the reader to
 * look at the wrong thing entirely. It is the same failure as the AD sign-in reporting a certificate
 * problem as a bad password: the server said exactly what was wrong and the UI threw it away.
 *
 * The API answers RFC-9110 ProblemDetails, whose `detail` names the user, the level and the feature.
 * Other pages already decode it (auth.ts, sales.ts, qa-hold.ts); this one did not.
 */
function why(e: unknown): string {
  const ex = e as { status?: number; response?: string; message?: string };
  if (typeof ex?.response === 'string' && ex.response.length > 0) {
    try {
      const p = JSON.parse(ex.response) as { detail?: string; title?: string; errors?: Record<string, string[]> };
      if (p.errors) {
        const flat = Object.values(p.errors).flat().join(' ');
        if (flat) return flat;
      }
      if (p.detail) return p.detail;
      if (p.title) return p.title;
    } catch { /* not ProblemDetails — fall through to the raw message */ }
  }
  // 403 in particular must never read as a server fault: nothing is broken, the account lacks a grant.
  if (ex?.status === 403) return 'You do not have permission to do that.';
  return ex?.message ?? String(e);
}
const setV = (id: string, value: unknown) => { $<HTMLInputElement>(id).value = value == null ? '' : String(value); };
// Local-time formatter for datetime-local inputs — toISOString() would emit UTC and shift the value by
// the whole timezone offset on show/re-save (see downtime.ts).
const dtLocal = (d: Date | undefined): string =>
  (d == null ? '' : new Date(d.getTime() - d.getTimezoneOffset() * 60000).toISOString().slice(0, 16));
const chip = (s: unknown): string => `<span class="chip mut">${esc(s ?? '—')}</span>`;

let editingId: number | null = null;

function scaffold(): string {
  const tab = (id: string, label: string) => `<button id="tab-${id}" type="button">${label}</button>`;
  return `
  <div class="page">
    <div class="page-head"><div><div class="eyebrow">Maintenance</div><h1>Maintenance</h1></div><div class="shift-tag" id="count">—</div></div>
    <div class="tabs">${tab('due', 'PM due board')}${tab('pms', 'PM schedules')}${tab('logs', 'Logs')}</div>
    <div id="err" class="err" style="margin:8px 0"></div>

    <div id="pane-due">
      <div class="card" style="margin-bottom:16px"><div class="body">
        <form id="dueForm" class="frow" style="align-items:flex-end">
          <div class="fld"><label>Due within (days)</label><input id="dWithin" inputmode="numeric" value="7" style="width:120px" /></div>
          <div class="fld"><label>Dept id</label><input id="dDept" list="deptList" placeholder="any" style="width:90px" /></div>
          <button class="btn sm" type="submit">Refresh</button>
          <span class="muted" style="margin-left:auto">Active PMs only — overdue first. Retired PMs (status 0) never appear.</span>
        </form>
      </div></div>
      <div class="card">
        <header><h2>Due &amp; overdue</h2><span class="sub" id="cDue"></span></header>
        <div style="overflow-x:auto"><table class="tbl" style="min-width:820px">
          <thead><tr><th>PM#</th><th>Equipment</th><th>What</th><th>Freq</th><th>Due</th><th class="num">Days</th><th>State</th><th></th></tr></thead>
          <tbody id="tDue"><tr><td colspan="8" class="muted">Loading…</td></tr></tbody>
        </table></div>
      </div>
    </div>

    <div id="pane-pms" style="display:none">
      <div class="card" style="margin-bottom:16px"><div class="body">
        <form id="pmForm" class="frow" style="align-items:flex-end">
          <div class="fld"><label>Dept id</label><input id="pDept" list="deptList" placeholder="any" style="width:90px" /></div>
          <div class="fld"><label>Status</label><select id="pStatus" style="width:120px"><option value="1" selected>active</option><option value="">any</option><option value="0">retired</option></select></div>
          <button class="btn sm" type="submit">Search</button>
          <button class="btn sm ghost" id="btnNewPm" type="button">New PM</button>
        </form>
      </div></div>
      <div class="grid">
        <div class="stack"><div class="card">
          <header><h2>PM schedules</h2><span class="sub" id="cPms"></span>
            <span class="spacer"></span>
            <button class="btn sm ghost" id="pmCsv" type="button" disabled>Export CSV</button>
            <button class="btn sm ghost" id="pmXlsx" type="button" disabled>Export Excel</button>
          </header>
          <div style="overflow-x:auto"><table class="tbl" style="min-width:520px">
            <thead><tr><th>PM#</th><th>Equipment</th><th>What</th><th>Due</th><th>State</th></tr></thead>
            <tbody id="tPms"><tr><td colspan="5" class="muted">Loading…</td></tr></tbody>
          </table></div>
        </div></div>
        <div class="stack"><div class="card">
          <header><h2 id="pmTitle">New PM</h2><span class="sub" id="pmOk" class="ok-note"></span>
            <span class="spacer"></span>
            <span class="sub mono" id="pmPos"></span>
            <button class="btn sm ghost" id="pmPrev" type="button" title="Previous PM in the list" disabled>&#9664;</button>
            <button class="btn sm ghost" id="pmNext" type="button" title="Next PM in the list" disabled>&#9654;</button>
          </header>
          <div class="body" id="pmDetail"></div>
        </div></div>
      </div>
    </div>

    <div id="pane-logs" style="display:none">
    <div class="card" style="margin-bottom:16px"><div class="body">
      <form id="searchForm" class="frow">
        <div class="fld"><label>Status</label><input id="fStatus" placeholder="e.g. Completed" style="width:130px" /></div>
        <div class="fld"><label>Dept id</label><input id="fDept" list="deptList" placeholder="id" style="width:90px" /></div>
        <button class="btn sm" type="submit">Search</button>
      </form>
    </div></div>
    <div class="grid">
      <div class="stack"><div class="card">
        <header><h2>Maintenance logs</h2></header>
        <div style="overflow-x:auto"><table class="tbl" style="min-width:460px">
          <thead><tr><th>Log#</th><th>Status</th><th>Dept</th><th>Problem</th><th>Author</th></tr></thead>
          <tbody id="logs"><tr><td colspan="5" class="muted">Loading…</td></tr></tbody>
        </table></div>
      </div></div>
      <div class="stack"><div class="card">
        <header><h2 id="formTitle">New maintenance log</h2></header>
        <div class="body">
          <div class="frow">
            <div class="fld"><label>Status</label><input id="mStatus" placeholder="e.g. Completed" style="width:130px" /></div>
            <div class="fld"><label>Department</label><input id="mDept" list="deptList" style="width:120px" /></div>
          </div>
          <div class="frow" style="margin-top:8px">
            <div class="fld"><label>System</label><input id="mSystem" style="width:120px" /></div>
            <div class="fld"><label>Subsystem</label><input id="mSubsystem" style="width:120px" /></div>
            <div class="fld"><label>Item / device</label><input id="mItem" style="width:120px" /></div>
          </div>
          <div class="frow" style="margin-top:8px"><div class="fld"><label>Problem time</label><input id="mProbDt" type="datetime-local" /></div></div>
          <div class="frow" style="margin-top:8px"><div class="fld" style="flex:1;min-width:200px"><label>Problem details</label><input id="mDetails" /></div></div>
          <div class="frow" style="margin-top:8px"><div class="fld" style="flex:1;min-width:200px"><label>Actions</label><input id="mActions" /></div></div>
          <div class="frow" style="margin-top:8px">
            <div class="fld"><label>Author</label><input id="mAuthor" style="width:110px" /></div>
            <div class="fld"><label>Reported by</label><input id="mReportedBy" style="width:110px" /></div>
            <div class="fld"><label>Assigned to</label><input id="mAssignedTo" style="width:110px" /></div>
          </div>
          <div class="frow" style="margin-top:8px">
            <div class="fld"><label>Completed by</label><input id="mCompletedBy" style="width:110px" /></div>
            <div class="fld"><label>Labor hours</label><input id="mLabor" type="number" step="0.1" style="width:100px" /></div>
          </div>
          <div class="frow" style="margin-top:10px;align-items:center">
            <button class="btn sm" id="btnSave" type="button">Save</button>
            <button class="btn sm ghost" id="btnNew" type="button">New</button>
            <span id="ok" class="ok-note"></span>
          </div>
        </div>
      </div></div>
    </div>
    </div>
  </div>
  <datalist id="deptList"></datalist>`;
}

async function search(): Promise<void> {
  setErr(''); setBusy(true);
  const status = v('#fStatus') || undefined;
  const dept = v('#fDept') ? Number(v('#fDept')) : undefined;
  try {
    const page = await client().listMaintLogs(1, 50, status, dept, undefined, undefined);
    const items = page.items ?? [];
    $('#logs').innerHTML = items.length ? items.map((m) => `
      <tr class="click" data-id="${m.maintLogId}">
        <td class="mono">${esc(m.maintLogId)}</td><td>${chip(m.maintLogStatus)}</td><td class="mono">${esc(m.groupDepartmentId)}</td>
        <td>${esc(m.probDetails)}</td><td>${esc(m.author)}</td>
      </tr>`).join('') : '<tr><td colspan="5" class="muted">No matching logs.</td></tr>';
    $('#count').textContent = `${(page.totalCount ?? 0).toLocaleString()} total`;
    document.querySelectorAll<HTMLTableRowElement>('#logs tr.click').forEach((tr) =>
      tr.addEventListener('click', () => void loadLog(Number(tr.dataset.id))));
  } catch (e) { setErr(`Search failed: ${why(e)}`); }
  finally { setBusy(false); }
}

async function loadLog(id: number): Promise<void> {
  setErr(''); setOk(''); setBusy(true);
  try {
    const m = await client().getMaintLog(id);
    editingId = id;
    $('#formTitle').textContent = `Edit maintenance log #${id}`;
    setV('#mStatus', m.maintLogStatus); setV('#mDept', m.groupDepartmentId);
    setV('#mSystem', m.systemEquipment); setV('#mSubsystem', m.subsystemEquipment);
    setV('#mItem', m.itemDevice); $<HTMLInputElement>('#mProbDt').value = dtLocal(m.probDateTime);
    setV('#mDetails', m.probDetails); setV('#mActions', m.actions);
    setV('#mAuthor', m.author); setV('#mReportedBy', m.reportedBy);
    setV('#mAssignedTo', m.assignedTo); setV('#mCompletedBy', m.completedBy);
    setV('#mLabor', m.laborHours);
  } catch (e) { setErr(`Load failed: ${why(e)}`); }
  finally { setBusy(false); }
}

function newLog(): void {
  editingId = null;
  $('#formTitle').textContent = 'New maintenance log';
  ['#mStatus', '#mDept', '#mSystem', '#mSubsystem', '#mItem', '#mDetails', '#mActions',
    '#mAuthor', '#mReportedBy', '#mAssignedTo', '#mCompletedBy', '#mLabor'].forEach((id) => setV(id, ''));
  $<HTMLInputElement>('#mProbDt').value = dtLocal(new Date());
  setOk(''); setErr('');
}

async function save(): Promise<void> {
  setErr(''); setOk(''); setBusy(true);
  const body = new MaintLogWrite({
    maintLogStatus: v('#mStatus') || undefined,
    groupDepartmentId: v('#mDept') ? Number(v('#mDept')) : undefined,
    systemEquipment: v('#mSystem') || undefined,
    subsystemEquipment: v('#mSubsystem') || undefined,
    itemDevice: v('#mItem') || undefined,
    probDateTime: v('#mProbDt') ? new Date(v('#mProbDt')) : undefined,
    probDetails: v('#mDetails') || undefined,
    actions: v('#mActions') || undefined,
    author: v('#mAuthor') || undefined,
    reportedBy: v('#mReportedBy') || undefined,
    assignedTo: v('#mAssignedTo') || undefined,
    completedBy: v('#mCompletedBy') || undefined,
    laborHours: v('#mLabor') ? Number(v('#mLabor')) : undefined,
  });
  try {
    if (editingId == null) {
      const created = await client().createMaintLog(body);
      setOk(`✓ Created log #${created.maintLogId}.`);
    } else {
      await client().updateMaintLog(editingId, body);
      setOk(`✓ Saved log #${editingId}.`);
    }
    await search();
  } catch (e) { setErr(`Save failed: ${why(e)}`); }
  finally { setBusy(false); }
}

// ---- Preventive maintenance ----------------------------------------------------------

// The server derives dueBucket; the UI only picks a tone for it.
const dueChip = (b: string | undefined): string => {
  // 'retired' falls through to the muted class deliberately: it is a state, not a warning.
  const cls = b === 'overdue' ? 'crit' : b === 'due' ? 'warn' : b === 'scheduled' ? 'ok' : 'mut';
  return `<span class="chip ${cls}">${esc(b ?? '—')}</span>`;
};
// A PM's equipment path, deepest level first, skipping levels it doesn't target.
const equipPath = (p: PmDefinition): string =>
  [p.systemEquipment, p.subsystemEquipment, p.itemDevice].filter(Boolean).join(' › ') || '—';
const dOnly = (d: Date | undefined): string => (d == null ? '' : d.toLocaleDateString());
const dInput = (d: Date | undefined): string =>
  (d == null ? '' : new Date(d.getTime() - d.getTimezoneOffset() * 60000).toISOString().slice(0, 10));

let pmEditingId: number | null = null;

async function loadDue(): Promise<void> {
  setErr(''); setBusy(true);
  try {
    const within = v('#dWithin') ? Number(v('#dWithin')) : 7;
    const dept = v('#dDept') ? Number(v('#dDept')) : undefined;
    const rows = await client().getPmsDue(within, dept);
    $('#tDue').innerHTML = rows.length ? rows.map((p) => `<tr>
      <td class="mono">${esc(p.pmId)}</td><td>${esc(equipPath(p))}</td><td>${esc(p.pmNotice)}</td>
      <td>${esc(p.maintFreq)}</td><td class="mono">${esc(dOnly(p.nextDueDate))}</td>
      <td class="num mono">${esc(p.daysUntilDue)}</td><td>${dueChip(p.dueBucket)}</td>
      <td><button class="btn xs ghost" type="button" data-open="${esc(p.pmId)}">Open</button></td></tr>`).join('')
      : '<tr><td colspan="8" class="muted">Nothing due in this window.</td></tr>';
    const overdue = rows.filter((r) => r.dueBucket === 'overdue').length;
    $('#cDue').textContent = `${rows.length} due · ${overdue} overdue`;
    document.querySelectorAll<HTMLButtonElement>('#tDue [data-open]').forEach((b) =>
      b.addEventListener('click', () => { showTab('pms'); void loadPm(Number(b.dataset.open)); }));
  } catch (e) { setErr(`Due board failed: ${why(e)}`); }
  finally { setBusy(false); }
}

// The PM list as last loaded. Exporting reads THIS rather than scraping the table, so a number in
// the file is the number the server sent; record-nav walks it so Prev/Next follow the order and
// filters the operator is actually looking at, not the whole table.
let pmList: PmDefinition[] = [];

async function loadPms(): Promise<void> {
  setErr(''); setBusy(true);
  try {
    const dept = v('#pDept') ? Number(v('#pDept')) : undefined;
    const st = $<HTMLSelectElement>('#pStatus').value;
    const page = await client().listPms(1, 100, dept, st === '' ? undefined : Number(st), undefined, undefined, undefined);
    const items = page.items ?? [];
    pmList = items;
    ($('#pmCsv') as HTMLButtonElement).disabled = items.length === 0;
    ($('#pmXlsx') as HTMLButtonElement).disabled = items.length === 0;
    $('#tPms').innerHTML = items.length ? items.map((p) => `
      <tr class="click" data-id="${p.pmId}">
        <td class="mono">${esc(p.pmId)}</td><td>${esc(equipPath(p))}</td><td>${esc(p.pmNotice)}</td>
        <td class="mono">${esc(dOnly(p.nextDueDate))}</td><td>${dueChip(p.dueBucket)}</td></tr>`).join('')
      : '<tr><td colspan="5" class="muted">No PMs match.</td></tr>';
    $('#cPms').textContent = `${(page.totalCount ?? 0).toLocaleString()} total`;
    document.querySelectorAll<HTMLTableRowElement>('#tPms tr.click').forEach((tr) =>
      tr.addEventListener('click', () => void loadPm(Number(tr.dataset.id))));
  } catch (e) { setErr(`PM list failed: ${why(e)}`); }
  finally { setBusy(false); }
}

/**
 * Record navigation — legacy's "First record / Next / Last Record" buttons on
 * `w_maint_pm_management`, which exist because reviewing PMs one after another is what this screen is
 * for. A table you must return to between every record makes that ten clicks instead of two.
 *
 * It walks the CURRENTLY LOADED list, so it follows the operator's filter and sort rather than the
 * whole table — stepping out of the filtered set would be a surprise, not a convenience.
 */
function pmNav(): void {
  const at = pmEditingId == null ? -1 : pmList.findIndex((x) => x.pmId === pmEditingId);
  const prev = $<HTMLButtonElement>('#pmPrev');
  const next = $<HTMLButtonElement>('#pmNext');
  prev.disabled = at <= 0;
  next.disabled = at < 0 || at >= pmList.length - 1;
  // Position is worth showing: "3 of 144" tells you where you are and how much is left, which the
  // buttons alone cannot. Blank for an unsaved PM, which is not in the list at all.
  $('#pmPos').textContent = at < 0 ? '' : `${at + 1} of ${pmList.length}`;
}

function stepPm(delta: number): void {
  const at = pmEditingId == null ? -1 : pmList.findIndex((x) => x.pmId === pmEditingId);
  const target = pmList[at + delta];
  if (at >= 0 && target?.pmId != null) void loadPm(target.pmId);
}

// The detail pane is rendered as one block per PM (edit form + checklist + complete + history)
// so switching PMs can't leave stale rows behind.
function pmForm(p: PmDefinition | null): string {
  const val = (x: unknown) => esc(x ?? '');
  return `
    <div class="frow">
      <div class="fld"><label>What (notice)</label><input id="xNotice" style="min-width:220px" value="${val(p?.pmNotice)}" /></div>
      <div class="fld"><label>Frequency</label><select id="xFreq" style="min-width:170px"></select></div>
      <div class="fld"><label>Shift</label><input id="xShift" list="shiftList" style="width:90px" value="${val(p?.pmshift)}" /></div>
      <div class="fld"><label>Status</label><select id="xStatus" style="width:110px">
        <option value="1"${p?.pmStatus !== 0 ? ' selected' : ''}>active</option>
        <option value="0"${p?.pmStatus === 0 ? ' selected' : ''}>retired</option></select></div>
    </div>
    <div class="frow" style="margin-top:8px">
      <div class="fld"><label>System</label><select id="xSys" style="min-width:150px"></select></div>
      <div class="fld"><label>Subsystem</label><select id="xSub" style="min-width:150px"></select></div>
      <div class="fld"><label>Item / device</label><select id="xItem" style="min-width:150px"></select></div>
    </div>
    <div class="frow" style="margin-top:8px">
      <div class="fld"><label>Department</label><select id="xDept" style="min-width:170px"></select></div>
      <div class="fld"><label>Craft</label><select id="xCraft" style="min-width:130px"></select></div>
      <div class="fld"><label>Assigned to</label><input id="xGroup" style="width:130px" value="${val(p?.assignedToGroup)}" /></div>
      <div class="fld"><label>Reference</label><input id="xRef" style="width:130px" value="${val(p?.pmReference)}" /></div>
    </div>
    <div class="frow" style="margin-top:8px">
      <div class="fld"><label>Days between</label><input id="xBetween" type="number" step="1" style="width:110px" value="${val(p?.daysBetween)}" /></div>
      <div class="fld"><label>Times / year</label><input id="xPerYear" type="number" step="1" style="width:110px" value="${val(p?.numOfTimesPerYear)}" /></div>
      <div class="fld"><label>Next due</label><input id="xNextDue" type="date" value="${dInput(p?.nextDueDate)}" /></div>
      <div class="fld"><label>Mins/unit</label><input id="xMins" type="number" step="1" style="width:100px" value="${val(p?.minsPerUnit)}" /></div>
      <div class="fld"><label>Units</label><input id="xUnits" type="number" step="1" style="width:90px" value="${val(p?.numOfUnits)}" /></div>
    </div>
    <div class="frow" style="margin-top:10px;align-items:center">
      <button class="btn sm" id="btnSavePm" type="button">${p ? 'Save PM' : 'Create PM'}</button>
      ${p ? '<button class="btn sm ghost" id="btnDeletePm" type="button">Delete</button>' : ''}
      <span class="muted">${p ? `Last done ${esc(dOnly(p.pmCompleted)) || '—'} by ${esc(p.completedBy) || '—'}` : 'Interval drives the next due date when a completion is recorded.'}</span>
    </div>`;
}

function completeAndChecklist(p: PmDefinition): string {
  return `
    <h3 style="font-size:11px;text-transform:uppercase;letter-spacing:.06em;color:var(--ink-3);margin:18px 0 8px">Record a completion</h3>
    <div class="frow" style="align-items:flex-end">
      <div class="fld"><label>Completed by</label><input id="cBy" style="width:130px" /></div>
      <div class="fld"><label>On</label><input id="cOn" type="date" value="${dInput(new Date())}" /></div>
      <div class="fld"><label>Next due (optional)</label><input id="cNext" type="date" /></div>
      <div class="fld" style="flex:1;min-width:160px"><label>Notes</label><input id="cNotes" /></div>
      <button class="btn sm" id="btnComplete" type="button">Complete</button>
    </div>
    <p class="muted" style="margin:6px 0 0">Leave <em>next due</em> blank to advance automatically from ${
      p.daysBetween ? `days-between (${esc(p.daysBetween)})` : p.numOfTimesPerYear ? `${esc(p.numOfTimesPerYear)}×/year` : 'the interval — this PM has none, so the stored date is kept'}.</p>

    <h3 style="font-size:11px;text-transform:uppercase;letter-spacing:.06em;color:var(--ink-3);margin:18px 0 8px">Checklist</h3>
    <div style="overflow-x:auto"><table class="tbl" style="min-width:420px">
      <thead><tr><th>Action</th><th>Details</th><th></th></tr></thead>
      <tbody id="tActions"><tr><td colspan="3" class="muted">Loading…</td></tr></tbody>
    </table></div>
    <div class="frow" style="margin-top:8px;align-items:flex-end">
      <div class="fld"><label>Action</label><input id="aItem" style="width:170px" /></div>
      <div class="fld" style="flex:1;min-width:160px"><label>Details</label><input id="aDetails" /></div>
      <button class="btn sm ghost" id="btnAddAction" type="button">Add</button>
    </div>

    <h3 style="font-size:11px;text-transform:uppercase;letter-spacing:.06em;color:var(--ink-3);margin:18px 0 8px">Completion history</h3>
    <div style="overflow-x:auto"><table class="tbl" style="min-width:420px">
      <thead><tr><th>Completed</th><th>By</th><th>Notes</th></tr></thead>
      <tbody id="tHistory"><tr><td colspan="3" class="muted">Loading…</td></tr></tbody>
    </table></div>`;
}

async function loadPm(id: number | null): Promise<void> {
  setErr(''); $('#pmOk').textContent = ''; setBusy(true);
  try {
    const p = id == null ? null : await client().getPm(id);
    pmEditingId = p?.pmId ?? null;
    $('#pmTitle').textContent = p ? `PM #${p.pmId}` : 'New PM';
    $('#pmDetail').innerHTML = pmForm(p) + (p ? completeAndChecklist(p) : '');
    pmNav();
    await fillEquipmentPickers(p);
    $('#btnSavePm').addEventListener('click', () => void savePm());
    document.querySelector('#btnDeletePm')?.addEventListener('click', () => void deletePm());
    if (p && pmEditingId != null) {
      const pmId = pmEditingId;
      $('#btnComplete').addEventListener('click', () => void completePm());
      $('#btnAddAction').addEventListener('click', () => void addAction());
      await Promise.all([loadActions(pmId), loadHistory(pmId)]);
    }
  } catch (e) { setErr(`PM load failed: ${why(e)}`); }
  finally { setBusy(false); }
}

// Cascading pickers: system -> subsystem -> item. Each level reloads its children on change.
async function fillEquipmentPickers(p: PmDefinition | null): Promise<void> {
  const opt = (id: unknown, label: unknown, sel: unknown) =>
    `<option value="${esc(id)}"${String(id) === String(sel ?? '') ? ' selected' : ''}>${esc(label)}</option>`;
  const blank = '<option value="">—</option>';
  try {
    // maint_freq is an FK to the frequency catalog, so offer the codes rather than free text —
    // a typed value would be rejected by the server (and would fail the FK on Oracle).
    const freqs = await client().getMaintFrequencies();
    $('#xFreq').innerHTML = blank + freqs.map((f) => {
      const days = f.freqType === 'HMC' ? 'meter' : `${f.daysBetween ?? '?'}d`;
      return opt(f.maintFreq, `${f.maintFreq} — ${days}`, p?.maintFreq);
    }).join('');
    const [depts, crafts] = await Promise.all([client().listGroupDepartments(), client().getTitleCrafts()]);
    $('#xDept').innerHTML = blank + depts.map((d) => opt(d.groupDepartmentId, d.groupDepartmentName, p?.groupDepartmentId)).join('');
    $('#xCraft').innerHTML = blank + crafts.map((c) => opt(c.titleCraftId, c.titleCraftName, p?.titleCraftId)).join('');

    // Department -> System -> Subsystem -> Item. The department level was missing and the system list
    // was fetched unfiltered, which was survivable when ABIS held a handful of rows; the KeepTrak
    // import (2026-08-21) took it to **382 systems in one flat dropdown**, against 25 for a typical
    // department. The hierarchy nests cleanly enough for this to work — measured on the imported data,
    // every system has a department and every item/device has a subsystem.
    const fillItems = async (subId: string, selItem?: unknown) => {
      const items = subId ? await client().getItemDevices(Number(subId)) : [];
      $('#xItem').innerHTML = blank + items.map((i) => opt(i.itemDeviceId, i.itemDeviceName, selItem)).join('');
    };
    const fillSubs = async (sysId: string, selSub?: unknown, selItem?: unknown) => {
      const subs = sysId ? await client().getSubsystemEquipment(Number(sysId)) : [];
      $('#xSub').innerHTML = blank + subs.map((s) => opt(s.subsysEquipmentId, s.subsystemEquipmentName, selSub)).join('');
      await fillItems($<HTMLSelectElement>('#xSub').value, selItem);
    };
    const fillSystems = async (deptId: string, selSys?: unknown, selSub?: unknown, selItem?: unknown) => {
      let systems = await client().getSystemEquipment(deptId ? Number(deptId) : undefined);
      // A PM carries its OWN groupdepartment_id as well as its sysequipment_id, and the two can
      // disagree — nothing enforces that the system belongs to the department the PM names. If the
      // saved system is not in the filtered list, fall back to the unfiltered one rather than render a
      // blank: the operator would not see the equipment their PM is for, and the next save would write
      // that blank back and strip it off the record.
      const keep = selSys != null && String(selSys) !== '';
      if (keep && !systems.some((x) => String(x.sysEquipmentId) === String(selSys))) {
        systems = await client().getSystemEquipment(undefined);
      }
      $('#xSys').innerHTML = blank + systems.map((x) => opt(x.sysEquipmentId, x.systemEquipmentName, selSys)).join('');
      await fillSubs($<HTMLSelectElement>('#xSys').value, selSub, selItem);
    };

    await fillSystems(String(p?.groupDepartmentId ?? ''), p?.sysEquipmentId, p?.subsysEquipmentId, p?.itemDeviceId);
    // Changing a level clears the ones below it: keeping a stale child would let a PM be saved against
    // an item that does not belong to the equipment above it.
    $('#xDept').addEventListener('change', () => void fillSystems($<HTMLSelectElement>('#xDept').value));
    $('#xSys').addEventListener('change', () => void fillSubs($<HTMLSelectElement>('#xSys').value));
    $('#xSub').addEventListener('change', () => void fillItems($<HTMLSelectElement>('#xSub').value));
  } catch { /* pickers are best-effort; the PM still saves without them */ }
}

function pmBody(): PmWrite {
  const numOr = (id: string) => (v(id) ? Number(v(id)) : undefined);
  return new PmWrite({
    pmNotice: v('#xNotice') || undefined,
    maintFreq: v('#xFreq') || undefined,
    pmshift: v('#xShift') || undefined,
    pmStatus: Number($<HTMLSelectElement>('#xStatus').value),
    sysEquipmentId: numOr('#xSys'), subsysEquipmentId: numOr('#xSub'), itemDeviceId: numOr('#xItem'),
    groupDepartmentId: numOr('#xDept'), titleCraftId: numOr('#xCraft'),
    assignedToGroup: v('#xGroup') || undefined, pmReference: v('#xRef') || undefined,
    daysBetween: numOr('#xBetween'), numOfTimesPerYear: numOr('#xPerYear'),
    nextDueDate: v('#xNextDue') ? new Date(v('#xNextDue')) : undefined,
    minsPerUnit: numOr('#xMins'), numOfUnits: numOr('#xUnits'),
  });
}

async function savePm(): Promise<void> {
  setErr(''); setBusy(true);
  try {
    if (pmEditingId == null) {
      const created = await client().createPm(pmBody());
      $('#pmOk').textContent = `✓ Created PM #${created.pmId}.`;
      await Promise.all([loadPms(), loadPm(created.pmId ?? null)]);
    } else {
      await client().updatePm(pmEditingId, pmBody());
      $('#pmOk').textContent = `✓ Saved PM #${pmEditingId}.`;
      await Promise.all([loadPms(), loadDue()]);
    }
  } catch (e) { setErr(`Save failed: ${why(e)}`); }
  finally { setBusy(false); }
}

async function deletePm(): Promise<void> {
  if (pmEditingId == null) return;
  if (!confirm(`Delete PM #${pmEditingId} and its checklist? (Refused if completions exist — retire it instead.)`)) return;
  setErr(''); setBusy(true);
  try {
    await client().deletePm(pmEditingId);
    await loadPm(null);
    await Promise.all([loadPms(), loadDue()]);
  } catch (e) { setErr(`Delete failed: ${why(e)}`); }
  finally { setBusy(false); }
}

async function completePm(): Promise<void> {
  if (pmEditingId == null) return;
  if (!v('#cBy')) { setErr('Completed by is required.'); return; }
  setErr(''); setBusy(true);
  try {
    const r = await client().completePm(pmEditingId, new PmCompleteWrite({
      completedBy: v('#cBy'),
      completedDate: v('#cOn') ? new Date(v('#cOn')) : undefined,
      nextDueDate: v('#cNext') ? new Date(v('#cNext')) : undefined,
      completedNotes: v('#cNotes') || undefined,
    }));
    // Say how the schedule moved and why, rather than making the user re-read the form.
    const how = r.advanceBasis === 'none' ? 'no interval, date unchanged' : `via ${esc(r.advanceBasis)}`;
    $('#pmOk').textContent = `✓ Completed. Next due ${dOnly(r.nextDueDate) || '—'} (${how}).`;
    await Promise.all([loadPm(pmEditingId), loadPms(), loadDue()]);
  } catch (e) { setErr(`Complete failed: ${why(e)}`); }
  finally { setBusy(false); }
}

async function loadActions(pmId: number): Promise<void> {
  const rows = await client().getPmActions(pmId);
  $('#tActions').innerHTML = rows.length ? rows.map((a) => `<tr>
    <td>${esc(a.actionItems)}</td><td>${esc(a.itemDetails)}</td>
    <td><button class="btn xs ghost" type="button" data-del-action="${esc(a.pmActionId)}">Remove</button></td></tr>`).join('')
    : '<tr><td colspan="3" class="muted">No checklist items.</td></tr>';
  document.querySelectorAll<HTMLButtonElement>('#tActions [data-del-action]').forEach((b) =>
    b.addEventListener('click', () => void removeAction(pmId, Number(b.dataset.delAction))));
}

async function addAction(): Promise<void> {
  if (pmEditingId == null || !v('#aItem')) { setErr('Action text is required.'); return; }
  setErr('');
  try {
    await client().addPmAction(pmEditingId, new PmActionWrite({ actionItems: v('#aItem'), itemDetails: v('#aDetails') || undefined }));
    setV('#aItem', ''); setV('#aDetails', '');
    await loadActions(pmEditingId);
  } catch (e) { setErr(`Add failed: ${why(e)}`); }
}

async function removeAction(pmId: number, actionId: number): Promise<void> {
  try { await client().deletePmAction(pmId, actionId); await loadActions(pmId); }
  catch (e) { setErr(`Remove failed: ${why(e)}`); }
}

async function loadHistory(pmId: number): Promise<void> {
  const rows = await client().getPmCompletions(pmId);
  $('#tHistory').innerHTML = rows.length ? rows.map((h) => `<tr>
    <td class="mono">${esc(dOnly(h.completedDate))}</td><td>${esc(h.completedBy)}</td>
    <td>${esc(h.completedNotes)}</td></tr>`).join('')
    : '<tr><td colspan="3" class="muted">Never completed.</td></tr>';
}

function showTab(name: string): void {
  ['due', 'pms', 'logs'].forEach((t) => {
    $(`#pane-${t}`).style.display = t === name ? '' : 'none';
    $(`#tab-${t}`).classList.toggle('active', t === name);
  });
}

(async () => {
  const main = await initShell({ active: 'maintenance' });
  main.innerHTML = scaffold();
  // Department dropdown options as <datalist> hints.
  try {
    const depts = await client().listGroupDepartments();
    $('#deptList').innerHTML = (depts ?? []).map((d) =>
      `<option value="${esc(d.groupDepartmentId)}">${esc(d.groupDepartmentName)}</option>`).join('');
  } catch { /* dropdown is best-effort */ }
  // PM shift codes as a datalist hint (best-effort, like the departments).
  try {
    const shifts = await client().getPmShifts();
    const dl = document.createElement('datalist');
    dl.id = 'shiftList';
    dl.innerHTML = (shifts ?? []).map((s) => `<option value="${esc(s)}"></option>`).join('');
    document.body.appendChild(dl);
  } catch { /* best-effort */ }
  ['due', 'pms', 'logs'].forEach((t) => $(`#tab-${t}`).addEventListener('click', () => showTab(t)));
  $<HTMLFormElement>('#searchForm').addEventListener('submit', (e) => { e.preventDefault(); void search(); });
  $<HTMLFormElement>('#dueForm').addEventListener('submit', (e) => { e.preventDefault(); void loadDue(); });
  $<HTMLFormElement>('#pmForm').addEventListener('submit', (e) => { e.preventDefault(); void loadPms(); });
  $('#btnNewPm').addEventListener('click', () => void loadPm(null));
  // The PM list report (legacy d_report_pm_list). Exports what is LOADED, so it matches the filter on
  // screen — a file that quietly covered more than the table above it would be worse than none.
  const download = (name: string, data: BlobPart, mime: string): void => {
    const url = URL.createObjectURL(new Blob([data], { type: mime }));
    const a = document.createElement('a');
    a.href = url; a.download = name; a.click();
    URL.revokeObjectURL(url);
  };
  // Export the WHOLE filtered set, not the loaded page. The list fetches 100 at a time, so exporting
  // `pmList` silently produced a file covering 100 of 221 rows while the header said "221 total" —
  // a truncation nobody would notice until they trusted the file.
  const allPms = async (): Promise<PmDefinition[]> => {
    const dept = v('#pDept') ? Number(v('#pDept')) : undefined;
    const st = $<HTMLSelectElement>('#pStatus').value;
    const status = st === '' ? undefined : Number(st);
    const out: PmDefinition[] = [];
    for (let page = 1; page <= 50; page++) {          // 50 x 200 = 10,000, far above any real PM count
      const r = await client().listPms(page, 200, dept, status, undefined, undefined, undefined);
      const items = r.items ?? [];
      out.push(...items);
      if (out.length >= (r.totalCount ?? 0) || items.length === 0) break;
    }
    return out;
  };
  const exportPms = async (kind: 'csv' | 'xlsx'): Promise<void> => {
    setBusy(true);
    try {
      const tb = pmListTable(await allPms());
      if (kind === 'csv') download(`${tb.name}.csv`, toCsv(tb), 'text/csv');
      else exportXlsx(tb.name, tb.name.slice(0, 31), tb.headers, tb.rows);
    } catch (e) { setErr(`Export failed: ${why(e)}`); }
    finally { setBusy(false); }
  };
  $('#pmCsv').addEventListener('click', () => void exportPms('csv'));
  $('#pmXlsx').addEventListener('click', () => void exportPms('xlsx'));
  $('#pmPrev').addEventListener('click', () => stepPm(-1));
  $('#pmNext').addEventListener('click', () => stepPm(1));
  $('#btnNew').addEventListener('click', newLog);
  $('#btnSave').addEventListener('click', () => void save());
  newLog();
  showTab('due');
  await Promise.all([loadDue(), loadPms(), search(), loadPm(null)]);
})();
