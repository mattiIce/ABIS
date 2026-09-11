// ABIS EDI — monitor for the EDI surface (legacy edi window; X12 856 ASN + related), restyled to
// the design system in the shared shell (#4 polish). Read-only: inbound/outbound transactions
// (+ detail), the processing log, the per-customer EDI setup, and the transaction-type lookup.
//
// Compiled by tsc to wwwroot/ui/app/edi.js; served at /ui/edi.html.
import { AbisClient, EdiPartnerProfile, EdiPartnerWrite, Edi997IngestWrite, EdiTransmitPolicyView, EdiValveWrite, EdiArmWrite } from './generated/abis-client.js';
import { authFetch } from './auth.js';
import { initShell } from './shell.js';
import { bannerText } from './edi-transmit-banner.js';
import { problemText } from './api-errors.js';

const $ = <T extends HTMLElement = HTMLElement>(sel: string): T => document.querySelector(sel) as T;
const client = (): AbisClient => new AbisClient('', { fetch: authFetch });
const esc = (s: unknown): string =>
  String(s ?? '').replace(/[&<>"]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;' }[c] as string));
const setErr = (m: string) => { $('#err').textContent = m; };
const setBusy = (b: boolean) => document.body.classList.toggle('busy', b);
const val = (id: string) => $<HTMLInputElement>(id).value.trim();
const dShow = (d: Date | undefined): string => (d == null ? '' : d.toLocaleString());
const faChip = (s: number | undefined): string =>
  (s ?? 0) >= 1 ? '<span class="chip ok">FA received</span>' : '<span class="chip warn">awaiting</span>';
// 997 age bucket → chip: fresh (ack window open) / waiting (2–24h, chase it) / overdue (>24h).
const bucketChip = (b: string | undefined): string => {
  const cls = b === 'overdue' ? 'crit' : b === 'waiting' ? 'warn' : 'info';
  return `<span class="chip ${cls}">${esc(b ?? '')}</span>`;
};

function scaffold(): string {
  const tab = (id: string, label: string) => `<button id="tab-${id}" type="button">${label}</button>`;
  return `
  <div class="page">
    <div class="page-head"><div><div class="eyebrow">EDI · Monitor</div><h1>EDI operations</h1></div></div>
    <div id="err" class="err" style="margin-bottom:12px"></div>

    <!-- Transmit status. Rendered on EVERY tab, not just the valve one: somebody reading the
         transaction list needs to know whether those documents left the building. -->
    <div id="xmitBanner" style="margin-bottom:14px"></div>

    <div class="tabs">${tab('xmit', 'Transmit valve')}${tab('tx', 'Transactions')}${tab('acks', 'Functional acks (997)')}${tab('log', 'Processing log')}${tab('partners', 'Partner profiles')}${tab('cust', 'Customer setup')}${tab('types', 'Types')}</div>

    <div id="pane-xmit" class="grid" style="display:none">
      <div class="stack">
        <div class="card">
          <header><h2>The valve</h2><span class="sub" id="xState"></span></header>
          <div class="body" id="xValve"><p class="muted">Loading&hellip;</p></div>
        </div>
        <div class="card">
          <header><h2>What the valve does not cover</h2></header>
          <div class="body">
            <p class="muted" style="margin:0 0 8px">This switch governs <b>what ABIS sends</b>. It has no
            effect on the legacy engine: <span class="mono">ediprocess.sh</span> still generates and
            <span class="mono">GXS.ksh</span> still transmits on the DB host&rsquo;s cron, and those keep
            running whatever this says.</p>
            <p class="muted" style="margin:0">That is why arming is per partner and document rather than
            global. Legacy currently sends <b>861 to Novelis (1153, 1459, 2582)</b>, <b>861 to Aleris
            (1980)</b> and <b>870 to Aleris (1980)</b>. Arming ABIS for one of those without first
            commenting its line out of <span class="mono">ediprocess.sh</span> means the partner receives
            two copies &mdash; and partners reconcile receipts and invoices off these.</p>
          </div>
        </div>
      </div>
      <div class="stack"><div class="card">
        <header><h2>Armed pairs</h2><span class="sub" id="cArm"></span></header>
        <div class="body">
          <p class="muted" style="margin:0 0 8px">A document leaves only when the valve is open <b>and</b>
          its (document, customer) pair is armed. Both, always.</p>
          <form id="armForm" class="frow" style="margin-bottom:10px">
            <div class="fld"><label>Document</label><select id="aType"><option>861</option><option>870</option><option>846</option><option>856</option><option>810</option><option>863</option></select></div>
            <div class="fld"><label>Customer id</label><input id="aCust" inputmode="numeric" style="width:110px" required /></div>
            <div class="fld"><label>Note</label><input id="aNote" style="width:190px" placeholder="optional" /></div>
            <button class="btn sm" type="submit">Arm</button>
          </form>
          <div id="armMsg"></div>
        </div>
        <div style="overflow-x:auto"><table class="tbl" style="min-width:420px">
          <thead><tr><th>Document</th><th>Cust</th><th>Customer</th><th></th></tr></thead>
          <tbody id="tArm"><tr><td colspan="4" class="muted">Loading&hellip;</td></tr></tbody>
        </table></div>
      </div></div>
    </div>

    <div id="pane-tx" class="grid">
      <div class="stack"><div class="card">
        <header><h2>Outbound / inbound transactions</h2><span class="sub" id="cTx"></span></header>
        <div class="body"><form id="txForm" class="frow" style="margin-bottom:8px"><div class="fld"><label>Customer id</label><input id="fCust" inputmode="numeric" style="width:110px" placeholder="any" /></div><button class="btn sm" type="submit">Filter</button></form></div>
        <div style="overflow-x:auto"><table class="tbl" style="min-width:620px">
          <thead><tr><th>File</th><th>Time</th><th>DUNS from → to</th><th>Sent to</th><th>Name</th><th>FA</th></tr></thead>
          <tbody id="tTx"><tr><td colspan="6" class="muted">Loading…</td></tr></tbody>
        </table></div>
      </div></div>
      <div class="stack"><div class="card">
        <header><h2>Transaction detail</h2><button class="btn sm ghost" id="btnPayload" type="button" style="display:none">View X12 payload</button></header>
        <div class="body kv" id="txDetail"><p class="muted">Select a transaction.</p></div>
        <div class="body" id="payloadWrap" style="display:none;border-top:1px solid var(--line)">
          <div class="frow" style="align-items:center;justify-content:space-between"><span class="sub">Stored X12 (generation only — never transmitted)</span><button class="btn xs ghost" id="btnCopyPayload" type="button">Copy</button></div>
          <pre id="txPayload" style="max-height:340px;overflow:auto;white-space:pre-wrap;word-break:break-all;font-family:var(--mono,monospace);font-size:12px;margin:6px 0 0"></pre>
        </div>
      </div></div>
    </div>

    <div id="pane-acks" class="grid" style="display:none">
      <div class="stack"><div class="card">
        <header><h2>Waiting on 997</h2><span class="sub" id="cWait"></span></header>
        <div class="body"><p class="muted" style="margin:0 0 4px">Outbound transactions with no functional acknowledgment yet — the in-app form of the legacy <span class="mono">check_997.sh</span>, oldest first. <b>fresh</b> &lt;2h (window open) · <b>waiting</b> 2–24h (chase it) · <b>overdue</b> &gt;24h.</p></div>
        <div style="overflow-x:auto"><table class="tbl" style="min-width:660px">
          <thead><tr><th>Age</th><th>Age (h)</th><th>File</th><th>Doc</th><th>Cust</th><th>Group ctl</th><th>Time</th></tr></thead>
          <tbody id="tWait"><tr><td colspan="7" class="muted">Loading…</td></tr></tbody>
        </table></div>
      </div></div>
      <div class="stack"><div class="card">
        <header><h2>Ingest a 997</h2></header>
        <div class="body">
          <p class="muted" style="margin:0 0 8px">Paste an inbound 997 (Functional Acknowledgment) to reconcile it against the outbound ledger — matched by group control number (= EDI file id). Parse + store only; never transmits.</p>
          <form id="ingForm">
            <div class="fld" style="margin-bottom:8px"><label>Source name (optional)</label><input id="iName" style="width:240px" placeholder="e.g. 997_in_1001.x12" /></div>
            <textarea id="iPayload" rows="9" style="width:100%;font-family:var(--mono,monospace);font-size:12px" placeholder="ISA*00*          *00*          *ZZ*PARTNER..."></textarea>
            <div style="margin-top:8px"><button class="btn sm" type="submit">Ingest &amp; reconcile</button></div>
          </form>
          <div id="ingResult" class="kv" style="margin-top:12px"></div>
        </div>
      </div></div>
    </div>

    <div id="pane-log" class="card" style="display:none">
      <header><h2>Processing log</h2><span class="sub" id="cLog"></span></header>
      <div class="body"><form id="logForm" class="frow" style="margin-bottom:8px"><div class="fld"><label>Customer id</label><input id="fCustLog" inputmode="numeric" style="width:110px" placeholder="any" /></div><button class="btn sm" type="submit">Filter</button></form></div>
      <div style="overflow-x:auto"><table class="tbl" style="min-width:640px">
        <thead><tr><th>When</th><th>Cust</th><th>EDI name</th><th>Flag</th><th>File</th><th>Contents</th></tr></thead>
        <tbody id="tLog"><tr><td colspan="6" class="muted">Loading…</td></tr></tbody>
      </table></div>
    </div>

    <div id="pane-partners" class="card" style="display:none">
      <header><h2>Trading-partner profiles</h2><span class="sub">Per customer + document — how each customer's EDI is framed. Config only; generates/sends nothing.</span></header>
      <div class="body">
        <form id="partForm" class="frow" style="flex-wrap:wrap;gap:8px;margin-bottom:10px">
          <div class="fld"><label>Customer id</label><input id="pCust" inputmode="numeric" style="width:90px" required /></div>
          <div class="fld"><label>Document</label><select id="pSet"><option>861</option><option>870</option><option>846</option><option>856</option><option>863</option></select></div>
          <div class="fld"><label>Variant</label><input id="pVariant" style="width:130px" placeholder="novelis / aleris / …" /></div>
          <div class="fld"><label>Recv qual</label><input id="pRq" style="width:56px" placeholder="09" /></div>
          <div class="fld"><label>Receiver id (DUNS)</label><input id="pRid" style="width:150px" /></div>
          <div class="fld"><label>Comp sep</label><input id="pComp" style="width:50px" /></div>
          <div class="fld"><label>Suffix</label><input id="pSuffix" style="width:50px" placeholder="~" /></div>
          <div class="fld"><label>Version</label><input id="pVer" style="width:66px" placeholder="00401" /></div>
          <div class="fld"><label>GS code</label><input id="pGs" style="width:56px" placeholder="RC" /></div>
          <div class="fld"><label>GS sender</label><input id="pGsSender" style="width:90px" placeholder="(ABCo)" /></div>
          <div class="fld"><label>GS receiver</label><input id="pGsReceiver" style="width:110px" placeholder="(= receiver id)" /></div>
          <div class="fld"><label>File prefix</label><input id="pPrefix" style="width:140px" /></div>
          <div class="fld"><label>Item ref</label><input id="pItemRef" style="width:110px" /></div>
          <div class="fld"><label>Enabled</label><input id="pEnabled" type="checkbox" checked /></div>
          <button class="btn sm" type="submit">Save</button>
          <button class="btn sm ghost" id="pReset" type="button">Clear</button>
        </form>
        <div style="overflow-x:auto"><table class="tbl" style="min-width:1020px">
          <thead><tr><th>Cust</th><th>Customer</th><th>Doc</th><th>On</th><th>Variant</th><th>Receiver</th><th>Comp</th><th>Suf</th><th>Ver</th><th>GS</th><th>Prefix</th><th>Item ref</th><th></th></tr></thead>
          <tbody id="tPart"><tr><td colspan="13" class="muted">Loading…</td></tr></tbody>
        </table></div>
      </div>
    </div>

    <div id="pane-cust" class="card" style="display:none">
      <header><h2>Per-customer EDI setup</h2></header>
      <div style="overflow-x:auto"><table class="tbl" style="min-width:520px">
        <thead><tr><th>Cust</th><th>Name</th><th>Type</th><th>Version</th><th>Description</th></tr></thead>
        <tbody id="tCust"><tr><td colspan="5" class="muted">Loading…</td></tr></tbody>
      </table></div>
    </div>

    <div id="pane-types" class="card" style="display:none">
      <header><h2>Transaction types</h2></header>
      <div style="overflow-x:auto"><table class="tbl" style="min-width:360px">
        <thead><tr><th>Type</th><th>Version</th><th>Description</th></tr></thead>
        <tbody id="tTypes"><tr><td colspan="3" class="muted">Loading…</td></tr></tbody>
      </table></div>
    </div>
  </div>`;
}

async function loadTransactions(): Promise<void> {
  setErr('');
  const customerId = val('#fCust') ? Number(val('#fCust')) : undefined;
  try {
    const page = await client().listEdiTransactions(1, 50, customerId, undefined, 'transactionTime', 'desc');
    $('#tTx').innerHTML = (page.items ?? []).length ? (page.items ?? []).map((x) => `
      <tr class="click" data-id="${x.ediFileId}">
        <td class="mono">${esc(x.ediFileId)}</td><td class="mono">${esc(dShow(x.transactionTime))}</td>
        <td class="mono">${esc(x.dunsFrom)} → ${esc(x.dunsTo)}</td><td>${esc(x.customerSentTo)}</td>
        <td class="mono">${esc(x.ediFileName)}</td><td>${faChip(x.faReceiveStatus)}</td></tr>`).join('')
      : '<tr><td colspan="6" class="muted">No transactions.</td></tr>';
    $('#cTx').textContent = `${(page.totalCount ?? 0).toLocaleString()} total`;
    document.querySelectorAll<HTMLTableRowElement>('#tTx tr.click').forEach((tr) =>
      tr.addEventListener('click', () => void loadTxDetail(Number(tr.dataset.id))));
  } catch (e) { setErr(`Transactions load failed: ${problemText(e)}`); }
}

let selectedTxId: number | null = null;

async function loadTxDetail(id: number): Promise<void> {
  setBusy(true);
  try {
    const x = await client().getEdiTransaction(id);
    $('#txDetail').innerHTML = Object.entries(x as unknown as Record<string, unknown>)
      .filter(([, val2]) => val2 != null)
      .map(([k, val2]) => `<span><b>${esc(k)}</b>${esc(val2 instanceof Date ? val2.toLocaleString() : val2)}</span>`)
      .join('');
    // Reset the payload viewer for the newly-selected transaction.
    selectedTxId = id;
    $('#btnPayload').style.display = '';
    $('#payloadWrap').style.display = 'none';
    $('#txPayload').textContent = '';
  } catch (e) { setErr(`Detail load failed: ${problemText(e)}`); }
  finally { setBusy(false); }
}

// The stored X12 is plain text; the NSwag client discards non-JSON bodies, so fetch it directly.
async function loadPayload(): Promise<void> {
  if (selectedTxId == null) return;
  setErr(''); setBusy(true);
  try {
    const r = await authFetch(`/api/edi/transactions/${selectedTxId}/payload`);
    if (!r.ok) throw new Error(`HTTP ${r.status}`);
    $('#txPayload').textContent = await r.text();
    $('#payloadWrap').style.display = '';
  } catch (e) { setErr(`Payload load failed: ${problemText(e)}`); }
  finally { setBusy(false); }
}

async function loadWaiting(): Promise<void> {
  setErr('');
  try {
    const r = await client().edi997Waiting(1, 100, undefined);
    const items = r.items ?? [];
    $('#tWait').innerHTML = items.length ? items.map((x) => `<tr>
      <td>${bucketChip(x.bucket)}</td><td class="mono">${esc((x.ageHours ?? 0).toFixed(1))}</td>
      <td class="mono">${esc(x.ediFileId)}</td><td class="mono">${esc(x.transactionTypeId)}</td>
      <td class="mono">${esc(x.customerId)}</td><td class="mono">${esc(x.groupControlNumber)}</td>
      <td class="mono">${esc(dShow(x.transactionTime))}</td></tr>`).join('')
      : '<tr><td colspan="7" class="muted">Nothing waiting on a 997.</td></tr>';
    $('#cWait').textContent =
      `${(r.totalWaiting ?? 0).toLocaleString()} waiting · ${r.waitingCount ?? 0} to chase · ${r.overdueCount ?? 0} overdue`;
  } catch (e) { setErr(`997 waiting load failed: ${problemText(e)}`); }
}

async function ingest997(): Promise<void> {
  setErr('');
  const payload = $<HTMLTextAreaElement>('#iPayload').value.trim();
  if (!payload) { setErr('Paste a 997 payload first.'); return; }
  setBusy(true);
  try {
    const r = await client().edi997Ingest(new Edi997IngestWrite({ payload, sourceName: val('#iName') || undefined }));
    const row = (k: string, v: unknown) => `<span><b>${esc(k)}</b>${esc(v)}</span>`;
    const warn = (r.warnings ?? []).length ? `<span><b>warnings</b>${esc((r.warnings ?? []).join('; '))}</span>` : '';
    $('#ingResult').innerHTML =
      row('acks parsed', r.acksParsed) + row('matched', r.matched) + row('unmatched', r.unmatched) +
      row('accepted', r.accepted) + row('rejected', r.rejected) + row('partial', r.partial) +
      row('already acked', r.alreadyAcked) + warn;
    await Promise.all([loadWaiting(), loadTransactions()]);
  } catch (e) { setErr(`997 ingest failed: ${problemText(e)}`); }
  finally { setBusy(false); }
}

async function loadLog(): Promise<void> {
  setErr('');
  const customerId = val('#fCustLog') ? Number(val('#fCustLog')) : undefined;
  try {
    const page = await client().listEdiLog(1, 50, customerId, 'ediLogTimestamp', 'desc');
    $('#tLog').innerHTML = (page.items ?? []).length ? (page.items ?? []).map((x) => `<tr>
      <td class="mono">${esc(dShow(x.ediLogTimestamp))}</td><td class="mono">${esc(x.customerId)}</td><td>${esc(x.customerEdiName)}</td>
      <td class="mono">${esc(x.ediLogFlag)}</td><td class="mono">${esc(x.ediFileId)}</td><td>${esc(x.ediLogContents)}</td></tr>`).join('')
      : '<tr><td colspan="6" class="muted">No log entries.</td></tr>';
    $('#cLog').textContent = `${(page.totalCount ?? 0).toLocaleString()} total`;
  } catch (e) { setErr(`Log load failed: ${problemText(e)}`); }
}

async function loadCustomers(): Promise<void> {
  try {
    const list = await client().listCustomerEdi();
    $('#tCust').innerHTML = (list ?? []).length ? (list ?? []).map((x) => `<tr>
      <td class="mono">${esc(x.customerId)}</td><td>${esc(x.customerEdiName)}</td><td class="mono">${esc(x.ediTypeId)}</td>
      <td class="mono">${esc(x.ediVersion)}</td><td>${esc(x.customerEdiDesc)}</td></tr>`).join('')
      : '<tr><td colspan="5" class="muted">No customer EDI setups.</td></tr>';
  } catch (e) { setErr(`Customer EDI load failed: ${problemText(e)}`); }
}

async function loadTypes(): Promise<void> {
  try {
    const list = await client().listEdiTypes();
    $('#tTypes').innerHTML = (list ?? []).length ? (list ?? []).map((x) => `<tr>
      <td class="mono">${esc(x.ediTypeId)}</td><td class="mono">${esc(x.ediVersion)}</td><td>${esc(x.ediTypeDescription)}</td></tr>`).join('')
      : '<tr><td colspan="3" class="muted">No types.</td></tr>';
  } catch (e) { setErr(`Types load failed: ${problemText(e)}`); }
}

let partners: EdiPartnerProfile[] = [];

async function loadPartners(): Promise<void> {
  try {
    partners = (await client().listEdiPartners(undefined)) ?? [];
    const chip = (on: boolean | undefined) => (on ? '<span class="chip ok">on</span>' : '<span class="chip">off</span>');
    $('#tPart').innerHTML = partners.length ? partners.map((p) => `<tr>
      <td class="mono">${esc(p.customerId)}</td><td>${esc(p.customerName ?? '')}</td><td class="mono">${esc(p.transactionSet)}</td><td>${chip(p.enabled)}</td>
      <td>${esc(p.variant)}</td><td class="mono">${esc(p.receiverQualifier)}/${esc(p.receiverId)}</td>
      <td class="mono">${esc(p.componentSeparator)}</td><td class="mono">${esc(p.segmentSuffix)}</td>
      <td class="mono">${esc(p.envelopeVersion)}</td><td class="mono">${esc(p.gsFunctionalCode)}</td>
      <td class="mono">${esc(p.filePrefix)}</td><td class="mono">${esc(p.itemReference)}</td>
      <td style="white-space:nowrap"><button class="btn sm ghost pEdit" data-c="${p.customerId}" data-s="${esc(p.transactionSet)}" type="button">edit</button>
        <button class="btn sm ghost pDel" data-c="${p.customerId}" data-s="${esc(p.transactionSet)}" type="button">del</button></td></tr>`).join('')
      : '<tr><td colspan="13" class="muted">No profiles.</td></tr>';
    document.querySelectorAll<HTMLButtonElement>('#tPart .pEdit').forEach((b) => b.addEventListener('click', () =>
      fillPartner(partners.find((x) => String(x.customerId) === b.dataset.c && x.transactionSet === b.dataset.s))));
    document.querySelectorAll<HTMLButtonElement>('#tPart .pDel').forEach((b) => b.addEventListener('click', () =>
      void deletePartner(Number(b.dataset.c), b.dataset.s ?? '')));
  } catch (e) { setErr(`Partner profiles load failed: ${problemText(e)}`); }
}

function fillPartner(p: EdiPartnerProfile | undefined): void {
  if (!p) return;
  $<HTMLInputElement>('#pCust').value = String(p.customerId ?? '');
  $<HTMLSelectElement>('#pSet').value = p.transactionSet ?? '861';
  $<HTMLInputElement>('#pVariant').value = p.variant ?? '';
  $<HTMLInputElement>('#pRq').value = p.receiverQualifier ?? '';
  $<HTMLInputElement>('#pRid').value = p.receiverId ?? '';
  $<HTMLInputElement>('#pComp').value = p.componentSeparator ?? '';
  $<HTMLInputElement>('#pSuffix').value = p.segmentSuffix ?? '';
  $<HTMLInputElement>('#pVer').value = p.envelopeVersion ?? '';
  $<HTMLInputElement>('#pGs').value = p.gsFunctionalCode ?? '';
  $<HTMLInputElement>('#pGsSender').value = p.gsSenderCode ?? '';
  $<HTMLInputElement>('#pGsReceiver').value = p.gsReceiverCode ?? '';
  $<HTMLInputElement>('#pPrefix').value = p.filePrefix ?? '';
  $<HTMLInputElement>('#pItemRef').value = p.itemReference ?? '';
  $<HTMLInputElement>('#pEnabled').checked = p.enabled !== false;
}

function clearPartner(): void {
  ['#pCust', '#pVariant', '#pRq', '#pRid', '#pComp', '#pSuffix', '#pVer', '#pGs', '#pGsSender', '#pGsReceiver', '#pPrefix', '#pItemRef']
    .forEach((id) => { $<HTMLInputElement>(id).value = ''; });
  $<HTMLInputElement>('#pEnabled').checked = true;
}

async function savePartner(): Promise<void> {
  setErr('');
  const customerId = Number(val('#pCust'));
  const set = $<HTMLSelectElement>('#pSet').value;
  if (!customerId) { setErr('Customer id is required.'); return; }
  const opt = (id: string) => { const v = val(id); return v === '' ? undefined : v; };
  setBusy(true);
  try {
    await client().upsertEdiPartner(customerId, set, new EdiPartnerWrite({
      enabled: $<HTMLInputElement>('#pEnabled').checked, variant: opt('#pVariant'),
      receiverQualifier: opt('#pRq'), receiverId: opt('#pRid'), componentSeparator: opt('#pComp'),
      segmentSuffix: opt('#pSuffix'), envelopeVersion: opt('#pVer'), gsFunctionalCode: opt('#pGs'),
      gsSenderCode: opt('#pGsSender'), gsReceiverCode: opt('#pGsReceiver'),
      filePrefix: opt('#pPrefix'), itemReference: opt('#pItemRef'),
    }));
    await loadPartners();
  } catch (e) { setErr(`Save failed: ${problemText(e)}`); }
  finally { setBusy(false); }
}

async function deletePartner(customerId: number, set: string): Promise<void> {
  if (!confirm(`Remove the ${set} profile for customer ${customerId}?`)) return;
  setBusy(true);
  try { await client().deleteEdiPartner(customerId, set); await loadPartners(); }
  catch (e) { setErr(`Delete failed: ${problemText(e)}`); }
  finally { setBusy(false); }
}

// ---- transmit valve -------------------------------------------------------

let policy: EdiTransmitPolicyView | undefined;

const alertBox = (kind: string, icon: string, title: string, body: string): string =>
  `<div class="alert ${kind}"><span class="ai">${icon}</span><div class="at"><b>${title}</b><p>${body}</p></div></div>`;

const ICON_OFF = '<svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M6 6l12 12"/></svg>';
const ICON_LIVE = '<svg viewBox="0 0 24 24"><path d="M12 3v10"/><path d="M6.5 7a8 8 0 1 0 11 0"/></svg>';

function renderBanner(p: EdiTransmitPolicyView): void {
  const t = bannerText(p);
  $('#xmitBanner').innerHTML = alertBox(t.kind, t.kind === 'crit' ? ICON_LIVE : ICON_OFF, t.title, t.body);
}

function renderValve(p: EdiTransmitPolicyView): void {
  $('#xState').innerHTML = p.valveOpen
    ? '<span class="chip crit">open</span>'
    : '<span class="chip ok">closed</span>';
  $('#xValve').innerHTML = p.valveOpen
    ? `<p style="margin:0 0 10px">The valve is <b>open</b>. Armed pairs are permitted to transmit.</p>
       <button class="btn sm" id="btnClose" type="button">Close the valve</button>
       <p class="muted" style="margin:8px 0 0">Closing takes effect on the next document. It needs no note
       and no confirmation &mdash; it can only make things safer.</p>`
    : `<p style="margin:0 0 10px">The valve is <b>closed</b>. Nothing ABIS generates is transmitted.</p>
       <div class="fld" style="margin-bottom:8px"><label>Why are you opening it?</label>
         <input id="vNote" style="width:100%;max-width:340px" placeholder="recorded against your name" /></div>
       <button class="btn sm" id="btnOpen" type="button">Open the valve</button>
       <p class="muted" style="margin:8px 0 0">Opening alone sends nothing: each partner/document pair must
       also be armed.</p>`;
  if (p.valveOpen) $('#btnClose').addEventListener('click', () => void setValve(false));
  else $('#btnOpen').addEventListener('click', () => void setValve(true));
}

function renderArmed(p: EdiTransmitPolicyView): void {
  const rows = p.armed ?? [];
  $('#cArm').textContent = rows.length ? `${rows.length} armed` : 'none armed';
  // customerId is optional in the generated client (NSwag marks value types optional), so this
  // takes the undefined case rather than asserting it away.
  const nameOf = (id: number | undefined) => partners.find((x) => x.customerId === id)?.customerName ?? '';
  $('#tArm').innerHTML = rows.length ? rows.map((a) => `<tr>
    <td class="mono">${esc(a.transactionType)}</td><td class="mono">${esc(a.customerId)}</td>
    <td>${esc(nameOf(a.customerId))}</td>
    <td style="text-align:right"><button class="btn sm ghost aDis" data-t="${esc(a.transactionType)}" data-c="${a.customerId}" type="button">disarm</button></td></tr>`).join('')
    : '<tr><td colspan="4" class="muted">Nothing is armed &mdash; nothing can transmit.</td></tr>';
  document.querySelectorAll<HTMLButtonElement>('#tArm .aDis').forEach((b) => b.addEventListener('click', () =>
    void setArm(b.dataset.t ?? '', Number(b.dataset.c), false, '')));
}

async function loadTransmit(): Promise<void> {
  try {
    policy = await client().getEdiTransmitPolicy();
    renderBanner(policy);
    renderValve(policy);
    renderArmed(policy);
  } catch (e) {
    // Failing to READ the policy is not the same as it being off, and printing "disabled" here would
    // be a guess. Say what is actually known: the server treats an unreadable policy as closed.
    $('#xmitBanner').innerHTML = alertBox('warn', ICON_OFF, 'Transmit status unavailable',
      `Could not read the transmit policy: ${esc(problemText(e))}. The server treats an unreadable policy as `
      + 'closed, so nothing is being transmitted.');
    $('#xValve').innerHTML = '<p class="muted">Unavailable.</p>';
  }
}

async function setValve(open: boolean): Promise<void> {
  const note = open ? val('#vNote') : '';
  if (open && !note) { setErr('Say why the valve is being opened - it is recorded against your name.'); return; }
  if (open && !confirm('Open the EDI transmit valve?\n\nArmed partner/document pairs will be permitted '
    + 'to transmit. Anything legacy also sends will reach the partner twice.')) return;
  setBusy(true); setErr('');
  try { await client().setEdiTransmitValve(new EdiValveWrite({ open, note })); await loadTransmit(); }
  catch (e) { setErr(`Valve change failed: ${problemText(e)}`); }
  finally { setBusy(false); }
}

async function setArm(transactionType: string, customerId: number, armed: boolean, note: string): Promise<void> {
  setBusy(true); setErr(''); $('#armMsg').innerHTML = '';
  try {
    const r = await client().setEdiTransmitArm(new EdiArmWrite({ transactionType, customerId, armed, note }));
    // The duplicate-EDI warning is the whole reason this response is more than an echo - put it where
    // the person who just armed the pair is already looking, not in a log.
    if (r?.warning) $('#armMsg').innerHTML = alertBox('crit', ICON_LIVE, 'Legacy still sends this', esc(r.warning));
    await loadTransmit();
  } catch (e) { setErr(`Arm change failed: ${problemText(e)}`); }
  finally { setBusy(false); }
}

function showTab(name: string): void {
  ['xmit', 'tx', 'acks', 'log', 'partners', 'cust', 'types'].forEach((t) => {
    $(`#pane-${t}`).style.display = t === name ? '' : 'none';
    $(`#tab-${t}`).classList.toggle('active', t === name);
  });
}

(async () => {
  const main = await initShell({ active: 'edi' });
  main.innerHTML = scaffold();
  ['xmit', 'tx', 'acks', 'log', 'partners', 'cust', 'types'].forEach((t) => $(`#tab-${t}`).addEventListener('click', () => showTab(t)));
  $<HTMLFormElement>('#txForm').addEventListener('submit', (e) => { e.preventDefault(); void loadTransactions(); });
  $<HTMLFormElement>('#ingForm').addEventListener('submit', (e) => { e.preventDefault(); void ingest997(); });
  $<HTMLFormElement>('#logForm').addEventListener('submit', (e) => { e.preventDefault(); void loadLog(); });
  $<HTMLFormElement>('#partForm').addEventListener('submit', (e) => { e.preventDefault(); void savePartner(); });
  $('#pReset').addEventListener('click', () => clearPartner());
  $('#btnPayload').addEventListener('click', () => void loadPayload());
  $('#btnCopyPayload').addEventListener('click', () => void navigator.clipboard?.writeText($('#txPayload').textContent ?? ''));
  $<HTMLFormElement>('#armForm').addEventListener('submit', (e) => {
    e.preventDefault();
    const cust = Number(val('#aCust'));
    if (!(cust > 0)) { setErr('A customer is required - arming is always for a named partner.'); return; }
    void setArm($<HTMLSelectElement>('#aType').value, cust, true, val('#aNote'));
  });
  showTab('tx');
  // Partners first: the armed table renders customer NAMES out of that list, and a race would leave
  // the initial paint showing bare ids.
  await loadPartners();
  await Promise.all([loadTransmit(), loadTransactions(), loadWaiting(), loadLog(), loadCustomers(), loadTypes()]);
})();
