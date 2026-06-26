// ABIS Parts — greenfield (Path C) master-data module for the part master
// (legacy part_num window). Parts are referenced by order entry, so this is the
// maintenance screen behind it. A typed SPA on the Phase-2 API: search by
// customer/alloy + load → edit → save (create/replace, re-sending customerId which
// is required). Through the NSwag-generated, compiler-checked client.
//
// Compiled by `tsc` to wwwroot/ui/app/parts.js; served at /ui/parts.html.
import { AbisClient, PartWrite } from './generated/abis-client.js';

import { initAuth, authFetch } from './auth.js';

const $ = <T extends HTMLElement = HTMLElement>(sel: string): T =>
  document.querySelector(sel) as T;

// Auth — a Bearer token (OIDC) or the X-Api-Key field — is attached by ./auth.
function client(): AbisClient {
  return new AbisClient('', { fetch: authFetch });
}

const esc = (s: unknown): string =>
  String(s ?? '').replace(/[&<>]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' }[c] as string));
const setErr = (m: string) => { $('#err').textContent = m; };
const setOk = (m: string) => { $('#ok').textContent = m; };
const setBusy = (b: boolean) => document.body.classList.toggle('busy', b);
const v = (id: string) => $<HTMLInputElement>(id).value.trim();
const setV = (id: string, value: unknown) => { $<HTMLInputElement>(id).value = value == null ? '' : String(value); };

let editingId: number | null = null;
const custNames = new Map<number, string>();
const custLabel = (id: number | undefined): string =>
  id == null ? '' : custNames.has(id) ? `${id} · ${custNames.get(id)}` : String(id);

async function loadCustomers(): Promise<void> {
  try {
    const page = await client().listCustomers(1, 500, undefined, undefined, undefined);
    custNames.clear();
    $('#custList').innerHTML = (page.items ?? []).map((c) => {
      if (c.customerId != null) custNames.set(c.customerId, c.customerName ?? '');
      return `<option value="${esc(c.customerId)}">${esc(c.customerName)}</option>`;
    }).join('');
  } catch { /* dropdown is best-effort */ }
}

async function search(): Promise<void> {
  setErr(''); setBusy(true);
  const customerId = v('#fCustomer') ? Number(v('#fCustomer')) : undefined;
  const alloy = v('#fAlloy') || undefined;
  try {
    const page = await client().listParts(1, 50, customerId, alloy, undefined, undefined);
    const rows = (page.items ?? []).map((p) => `
      <tr class="click" data-id="${p.partNumId}">
        <td>${esc(p.partNumId)}</td>
        <td>${esc(custLabel(p.customerId))}</td>
        <td>${esc(p.enduserPartNum)}</td>
        <td>${esc(p.sheetType)}</td>
        <td>${esc(p.alloy)}</td>
        <td>${esc(p.temper)}</td>
        <td>${esc(p.gauge)}</td>
        <td>${esc(p.itemStatus)}</td>
      </tr>`).join('');
    $('#parts').innerHTML = rows || '<tr><td colspan="8" class="muted">No matching parts.</td></tr>';
    $('#count').textContent = `${(page.totalCount ?? 0).toLocaleString()} total`;
    document.querySelectorAll<HTMLTableRowElement>('#parts tr.click').forEach((tr) =>
      tr.addEventListener('click', () => loadPart(Number(tr.dataset.id))));
  } catch (e) { setErr(`Search failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

async function loadPart(id: number): Promise<void> {
  setErr(''); setOk(''); setBusy(true);
  try {
    const p = await client().getPart(id);
    editingId = id;
    $('#formTitle').textContent = `Edit part #${id}`;
    setV('#pCustomer', p.customerId); setV('#pEnduser', p.enduserId);
    setV('#pPartNum', p.enduserPartNum); setV('#pSheet', p.sheetType);
    setV('#pAlloy', p.alloy); setV('#pTemper', p.temper);
    setV('#pGauge', p.gauge); setV('#pStatus', p.itemStatus);
  } catch (e) { setErr(`Load failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

function newPart(): void {
  editingId = null;
  $('#formTitle').textContent = 'New part';
  ['#pCustomer', '#pEnduser', '#pPartNum', '#pSheet', '#pAlloy', '#pTemper', '#pGauge', '#pStatus']
    .forEach((id) => setV(id, ''));
  setOk(''); setErr('');
}

async function save(): Promise<void> {
  setErr(''); setOk(''); setBusy(true);
  const body = new PartWrite({
    customerId: v('#pCustomer') ? Number(v('#pCustomer')) : undefined,
    enduserId: v('#pEnduser') ? Number(v('#pEnduser')) : undefined,
    enduserPartNum: v('#pPartNum') || undefined,
    sheetType: v('#pSheet') || undefined,
    alloy: v('#pAlloy') || undefined,
    temper: v('#pTemper') || undefined,
    gauge: v('#pGauge') ? Number(v('#pGauge')) : undefined,
    itemStatus: v('#pStatus') ? Number(v('#pStatus')) : undefined,
  });
  try {
    if (editingId == null) {
      const created = await client().createPart(body);
      setOk(`✓ Created part #${created.partNumId}.`);
    } else {
      await client().updatePart(editingId, body);
      setOk(`✓ Saved part #${editingId}.`);
    }
    await search();
  } catch (e) { setErr(`Save failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

async function init(): Promise<void> {
  await loadCustomers();
  $<HTMLFormElement>('#searchForm').addEventListener('submit', (e) => { e.preventDefault(); void search(); });
  $('#btnNew').addEventListener('click', newPart);
  $('#btnSave').addEventListener('click', save);
  newPart();
  await search();
}

void initAuth().then(init);
