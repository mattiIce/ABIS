// ABIS Shifts — shift records (legacy shift / shift_scheduler), restyled to the design system in
// the shared shell (#4 polish). Line-filtered search → load → edit → save (create/replace). Typed
// calls via the NSwag client.
//
// Compiled by tsc to wwwroot/ui/app/shifts.js; served at /ui/shifts.html.
import { AbisClient, ShiftWrite } from './generated/abis-client.js';
import { authFetch } from './auth.js';
import { initShell } from './shell.js';
import { statusChip, lineLabel } from './status-labels.js';
const $ = (sel) => document.querySelector(sel);
const client = () => new AbisClient('', { fetch: authFetch });
const esc = (s) => String(s ?? '').replace(/[&<>"]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c]));
const setErr = (m) => { $('#err').textContent = m; };
const setOk = (m) => { $('#ok').textContent = m; };
const setBusy = (b) => document.body.classList.toggle('busy', b);
const v = (id) => $(id).value.trim();
const setV = (id, value) => { $(id).value = value == null ? '' : String(value); };
const dtLocal = (d) => (d == null ? '' : d.toISOString().slice(0, 16));
const dtShow = (d) => (d == null ? '' : d.toLocaleString());
let editingId = null;
function scaffold() {
    return `
  <div class="page">
    <div class="page-head">
      <div><div class="eyebrow">Production · Shifts</div><h1>Shifts</h1></div>
      <div class="shift-tag" id="count">—</div>
    </div>

    <div class="card" style="margin-bottom:16px"><div class="body">
      <form id="searchForm" class="frow">
        <div class="fld"><label>Line #</label><input id="fLine" inputmode="numeric" style="width:110px" placeholder="any" /></div>
        <button class="btn sm" type="submit">Search</button>
      </form>
      <div id="err" class="err" style="margin-top:8px"></div>
    </div></div>

    <div class="grid">
      <div class="stack"><div class="card">
        <header><h2>Shift records</h2><span class="sub" id="listSub"></span></header>
        <div id="staleNote"></div>
        <div style="overflow-x:auto"><table class="tbl" style="min-width:560px">
          <thead><tr><th>Shift</th><th>Start</th><th>Line</th><th>Operator</th><th class="num">DT total</th><th>Status</th></tr></thead>
          <tbody id="shifts"><tr><td colspan="6" class="muted">Loading…</td></tr></tbody>
        </table></div>
      </div></div>
      <div class="stack"><div class="card">
        <header><h2 id="formTitle">New shift</h2></header>
        <div class="body">
          <div class="frow">
            <div class="fld"><label>Start time</label><input id="hStart" type="datetime-local" /></div>
            <div class="fld"><label>End time</label><input id="hEnd" type="datetime-local" /></div>
            <div class="fld"><label>Line #</label><input id="hLine" inputmode="numeric" style="width:90px" /></div>
            <div class="fld"><label>Schedule type</label><input id="hSchedule" inputmode="numeric" style="width:110px" /></div>
            <div class="fld"><label>Downtime total</label><input id="hDt" type="number" step="0.01" style="width:120px" /></div>
            <div class="fld"><label>Operator initials</label><input id="hOper" maxlength="10" style="width:120px" /></div>
            <div class="fld"><label>Data status</label><input id="hStatus" inputmode="numeric" style="width:100px" /></div>
            <div class="fld" style="flex:1;min-width:180px"><label>Note</label><textarea id="hNote" maxlength="1024"></textarea></div>
          </div>
          <div class="frow" style="margin-top:10px;align-items:center">
            <button class="btn sm" id="btnSave" type="button">Save</button>
            <button class="btn sm ghost" id="btnNew" type="button">New</button>
            <span id="ok" class="ok-note"></span>
          </div>
        </div>
      </div></div>
    </div>
  </div>`;
}
/**
 * The shifts the header's "N lines on a shift left open" notification is counting.
 *
 * <para>That notification links here, and used to land on the ordinary list — the newest 50 shifts by
 * start time. The stale ones are by definition OLD (the plant's were 709 hours), so they were nowhere
 * near the top and the page appeared to show something else entirely. The count was right; the
 * destination was not.</para>
 *
 * <para>This calls the SAME endpoint with the SAME arguments as the notification, which is the only way
 * to guarantee the page shows exactly the rows that were counted. Anything reconstructed from the
 * paged list could drift out of agreement with the badge above it.</para>
 */
async function showStaleOpen() {
    setErr('');
    setBusy(true);
    try {
        const r = await authFetch('/api/das/shifts/open?staleOnly=true&boardOnly=true');
        if (!r.ok)
            throw new Error(`open-shift lookup failed (${r.status})`);
        const rows = await r.json();
        $('#shifts').innerHTML = rows.length ? rows.map((s2) => `
      <tr class="click" data-id="${s2.shiftNum}">
        <td class="mono">${esc(s2.shiftNum)}</td><td class="mono">${esc(dtShow(s2.startTime ? new Date(s2.startTime) : undefined))}</td>
        <td class="mono">${esc(s2.lineDesc ?? lineLabel(s2.lineNum))}</td><td>${esc(s2.operatorInitial)}</td>
        <td class="num">${esc(s2.coilRuns)}</td>
        <td><span class="chip crit">${esc(s2.hoursOpen)} h open</span></td>
      </tr>`).join('')
            : '<tr><td colspan="6" class="muted">No shifts left open on a line board — nothing to clear.</td></tr>';
        // The DT-total column carries coil runs in this view, so relabel it rather than show one number
        // under another's heading.
        const dtHead = document.querySelector('#shifts')?.closest('table')?.querySelector('thead th.num');
        if (dtHead)
            dtHead.textContent = 'Coil runs';
        $('#count').textContent = `${rows.length} left open`;
        $('#listSub').textContent = 'on a line board';
        $('#staleNote').innerHTML = rows.length
            ? `<div class="warn-note">Showing the <b>${rows.length}</b> shift${rows.length === 1 ? '' : 's'} a line
         board still points at that nobody closed. A shift left open never gets its <code>dt_total</code>
         roll-up, so its line's efficiency is wrong until it is closed — and the coil runs column is how
         much work is being mis-attributed. Closing one is an operator action on the DAS station.
         <a href="/ui/shifts.html">Show all shifts instead</a>.</div>`
            : '';
        document.querySelectorAll('#shifts tr.click').forEach((tr) => tr.addEventListener('click', () => void loadShift(Number(tr.dataset.id))));
    }
    catch (e) {
        setErr(`Open-shift lookup failed: ${e.message}`);
    }
    finally {
        setBusy(false);
    }
}
async function search() {
    setErr('');
    setBusy(true);
    const lineNum = v('#fLine') ? Number(v('#fLine')) : undefined;
    try {
        const page = await client().listShifts(1, 50, lineNum, 'startTime', 'desc');
        const items = page.items ?? [];
        $('#shifts').innerHTML = items.length ? items.map((s) => `
      <tr class="click" data-id="${s.shiftNum}">
        <td class="mono">${esc(s.shiftNum)}</td><td class="mono">${esc(dtShow(s.startTime))}</td>
        <td class="mono">${esc(lineLabel(s.lineNum))}</td><td>${esc(s.operatorInitial)}</td>
        <td class="num">${esc(s.dtTotal)}</td><td>${statusChip('shiftDataStatus', s.shiftDataStatus)}</td>
      </tr>`).join('') : '<tr><td colspan="6" class="muted">No matching shifts.</td></tr>';
        $('#count').textContent = `${(page.totalCount ?? 0).toLocaleString()} shifts`;
        $('#listSub').textContent = `${items.length} shown`;
        document.querySelectorAll('#shifts tr.click').forEach((tr) => tr.addEventListener('click', () => void loadShift(Number(tr.dataset.id))));
    }
    catch (e) {
        setErr(`Search failed: ${e.message}`);
    }
    finally {
        setBusy(false);
    }
}
async function loadShift(id) {
    setErr('');
    setOk('');
    setBusy(true);
    try {
        const s = await client().getShift(id);
        editingId = id;
        $('#formTitle').textContent = `Edit shift #${id}`;
        $('#hStart').value = dtLocal(s.startTime);
        $('#hEnd').value = dtLocal(s.endTime);
        setV('#hLine', s.lineNum);
        setV('#hSchedule', s.scheduleType);
        setV('#hDt', s.dtTotal);
        setV('#hOper', s.operatorInitial);
        setV('#hStatus', s.shiftDataStatus);
        setV('#hNote', s.note);
    }
    catch (e) {
        setErr(`Load failed: ${e.message}`);
    }
    finally {
        setBusy(false);
    }
}
function newShift() {
    editingId = null;
    $('#formTitle').textContent = 'New shift';
    ['#hLine', '#hSchedule', '#hDt', '#hOper', '#hStatus', '#hNote'].forEach((id) => setV(id, ''));
    $('#hStart').value = '';
    $('#hEnd').value = '';
    setOk('');
    setErr('');
}
async function save() {
    setErr('');
    setOk('');
    setBusy(true);
    const body = new ShiftWrite({
        startTime: v('#hStart') ? new Date(v('#hStart')) : undefined,
        endTime: v('#hEnd') ? new Date(v('#hEnd')) : undefined,
        lineNum: v('#hLine') ? Number(v('#hLine')) : undefined,
        scheduleType: v('#hSchedule') ? Number(v('#hSchedule')) : undefined,
        dtTotal: v('#hDt') ? Number(v('#hDt')) : undefined,
        operatorInitial: v('#hOper') || undefined,
        shiftDataStatus: v('#hStatus') ? Number(v('#hStatus')) : undefined,
        note: v('#hNote') || undefined,
    });
    try {
        if (editingId == null) {
            const created = await client().createShift(body);
            setOk(`✓ Created shift #${created.shiftNum}.`);
        }
        else {
            await client().updateShift(editingId, body);
            setOk(`✓ Saved shift #${editingId}.`);
        }
        await search();
    }
    catch (e) {
        setErr(`Save failed: ${e.message}`);
    }
    finally {
        setBusy(false);
    }
}
(async () => {
    const main = await initShell({ active: 'shifts' });
    main.innerHTML = scaffold();
    $('#searchForm').addEventListener('submit', (e) => { e.preventDefault(); void search(); });
    $('#btnNew').addEventListener('click', newShift);
    $('#btnSave').addEventListener('click', () => void save());
    newShift();
    // ?open=stale is the header notification's destination. Without this the link landed on the ordinary
    // newest-50 list, which by definition does not contain shifts that have been open for weeks.
    if (new URLSearchParams(location.search).get('open') === 'stale')
        await showStaleOpen();
    else
        await search();
})();
