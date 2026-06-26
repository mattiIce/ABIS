// ABIS Receiving — greenfield (Path C) module replacing the legacy receiving /
// coil_receiving window. A typed SPA on the Phase-2 API: filterable inbound
// receiving-BOL search and a load → edit → save form (create or replace). The
// replace path re-sends all writable fields (bol + customerId are required) so a
// partial edit can't blank them. Through the NSwag-generated, compiler-checked client.
//
// Compiled by `tsc` to wwwroot/ui/app/receiving.js; served at /ui/receiving.html.
import { AbisClient, ReceivingBolWrite } from './generated/abis-client.js';

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
const dateOnly = (d: Date | undefined): string => (d == null ? '' : d.toISOString().slice(0, 10));

let editingId: number | null = null;
const custNames = new Map<number, string>();
const custLabel = (id: number | undefined): string =>
  id == null ? '' : custNames.has(id) ? `${id} · ${custNames.get(id)}` : String(id);

// Customer datalist (value = id, label = name) + an id→name map for the list view.
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
  const status = v('#fStatus') ? Number(v('#fStatus')) : undefined;
  try {
    const page = await client().listReceivingBols(1, 50, customerId, status, undefined, undefined);
    const rows = (page.items ?? []).map((b) => `
      <tr class="click" data-id="${b.receivingBolId}">
        <td>${esc(b.receivingBolId)}</td>
        <td>${esc(b.bol)}</td>
        <td>${esc(custLabel(b.customerId))}</td>
        <td>${esc(dateOnly(b.receivedDate))}</td>
        <td>${esc(b.status)}</td>
        <td>${esc(b.createdBy)}</td>
      </tr>`).join('');
    $('#bols').innerHTML = rows || '<tr><td colspan="6" class="muted">No matching BOLs.</td></tr>';
    $('#count').textContent = `${(page.totalCount ?? 0).toLocaleString()} total`;
    document.querySelectorAll<HTMLTableRowElement>('#bols tr.click').forEach((tr) =>
      tr.addEventListener('click', () => loadBol(Number(tr.dataset.id))));
  } catch (e) { setErr(`Search failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

async function loadBol(id: number): Promise<void> {
  setErr(''); setOk(''); setBusy(true);
  try {
    const b = await client().getReceivingBol(id);
    editingId = id;
    $('#formTitle').textContent = `Edit receiving BOL #${id}`;
    setV('#rBol', b.bol); setV('#rCustomer', b.customerId);
    setV('#rCreatedBy', b.createdBy); $<HTMLInputElement>('#rReceived').value = dateOnly(b.receivedDate);
    setV('#rStatus', b.status);
  } catch (e) { setErr(`Load failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

function newBol(): void {
  editingId = null;
  $('#formTitle').textContent = 'New receiving BOL';
  ['#rBol', '#rCustomer', '#rCreatedBy', '#rStatus'].forEach((id) => setV(id, ''));
  $<HTMLInputElement>('#rReceived').value = '';
  setOk(''); setErr('');
}

async function save(): Promise<void> {
  setErr(''); setOk(''); setBusy(true);
  const body = new ReceivingBolWrite({
    bol: v('#rBol') || undefined,
    customerId: v('#rCustomer') ? Number(v('#rCustomer')) : undefined,
    createdBy: v('#rCreatedBy') || undefined,
    receivedDate: v('#rReceived') ? new Date(v('#rReceived')) : undefined,
    status: v('#rStatus') ? Number(v('#rStatus')) : undefined,
  });
  try {
    if (editingId == null) {
      const created = await client().createReceivingBol(body);
      setOk(`✓ Created BOL #${created.receivingBolId}.`);
    } else {
      await client().updateReceivingBol(editingId, body);
      setOk(`✓ Saved BOL #${editingId}.`);
    }
    await search();
  } catch (e) { setErr(`Save failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

async function init(): Promise<void> {
  await loadCustomers();
  $<HTMLFormElement>('#searchForm').addEventListener('submit', (e) => { e.preventDefault(); void search(); });
  $('#btnNew').addEventListener('click', newBol);
  $('#btnSave').addEventListener('click', save);
  newBol();
  await search();
}

void initAuth().then(init);
