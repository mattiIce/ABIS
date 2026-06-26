// ABIS Coil Inventory — the second greenfield (Path C) module, replacing the
// legacy inv_coil window. A typed SPA on the Phase-2 API: filterable coil search,
// the weight-on-hand rollup, a coil's detail + processing history, and an inline
// operational update (status / location / notes). Every call goes through the
// NSwag-generated, compiler-checked client.
//
// Compiled by `tsc` to wwwroot/ui/app/coil-inventory.js; served at
// /ui/coil-inventory.html. See docs/PHASE3_PILOT_LOG.md.
import { AbisClient, CoilPatch } from './generated/abis-client.js';

const $ = <T extends HTMLElement = HTMLElement>(sel: string): T =>
  document.querySelector(sel) as T;

const keyInput = $<HTMLInputElement>('#apiKey');
keyInput.value = localStorage.getItem('abis_api_key') ?? 'dev-local-key';
keyInput.addEventListener('change', () => localStorage.setItem('abis_api_key', keyInput.value));

function client(): AbisClient {
  return new AbisClient('', {
    fetch: (url: RequestInfo, init?: RequestInit) => {
      const headers = new Headers(init?.headers);
      headers.set('X-Api-Key', keyInput.value);
      return fetch(url, { ...init, headers });
    },
  });
}

const esc = (s: unknown): string =>
  String(s ?? '').replace(/[&<>]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' }[c] as string));
const numf = (v: number | undefined): string => (v == null ? '' : v.toLocaleString());
const setErr = (m: string) => { $('#err').textContent = m; };
const setBusy = (b: boolean) => document.body.classList.toggle('busy', b);
const val = (id: string) => $<HTMLInputElement>(id).value.trim();

let selected: number | null = null;

// ---- Search + list ---------------------------------------------------------
async function search(): Promise<void> {
  setErr(''); setBusy(true);
  const status = val('#fStatus') ? Number(val('#fStatus')) : undefined;
  const alloy = val('#fAlloy') || undefined;
  const location = val('#fLocation') || undefined;
  const customerId = val('#fCustomer') ? Number(val('#fCustomer')) : undefined;
  try {
    const page = await client().listCoils(1, 50, status, alloy, location, customerId, undefined, undefined);
    const rows = (page.items ?? []).map((c) => `
      <tr class="click" data-id="${c.coilAbcNum}">
        <td>${esc(c.coilAbcNum)}</td>
        <td>${esc(c.coilAlloy2)}</td>
        <td>${esc(c.coilTemper)}</td>
        <td>${esc(c.coilLocation)}</td>
        <td>${esc(c.coilStatus)}</td>
        <td class="num">${numf(c.netWtBalance)}</td>
      </tr>`).join('');
    $('#coils').innerHTML = rows || '<tr><td colspan="6" class="muted">No matching coils.</td></tr>';
    $('#coilCount').textContent = `${numf(page.totalCount)} total`;
    document.querySelectorAll<HTMLTableRowElement>('#coils tr.click').forEach((tr) =>
      tr.addEventListener('click', () => loadCoil(Number(tr.dataset.id))));
  } catch (e) { setErr(`Search failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

// ---- Weight-on-hand rollup -------------------------------------------------
async function summary(): Promise<void> {
  setErr('');
  const groupBy = $<HTMLSelectElement>('#sGroup').value;
  try {
    const groups = await client().coilInventorySummary(groupBy);
    $('#summary').innerHTML = `
      <table><thead><tr><th>${esc(groupBy)}</th><th class="num">Coils</th>
        <th class="num">Net wt</th><th class="num">On hand</th></tr></thead>
      <tbody>${groups.map((g) => `
        <tr><td>${esc(g.key)}</td><td class="num">${numf(g.count)}</td>
          <td class="num">${numf(g.totalNetWt)}</td><td class="num">${numf(g.totalBalance)}</td></tr>`).join('')
        || '<tr><td colspan="4" class="muted">No data.</td></tr>'}</tbody></table>`;
  } catch (e) { setErr(`Summary failed: ${(e as Error).message}`); }
}

// ---- Coil detail + processing history + inline update ----------------------
async function loadCoil(id: number): Promise<void> {
  setErr(''); setBusy(true); selected = id;
  try {
    const [c, proc] = await Promise.all([client().getCoil(id), client().getCoilProcessing(id)]);
    const hist = (proc ?? []).map((p) => `
      <tr><td>${esc(p.abJobNum)}</td><td>${esc(p.processCoilStatus)}</td>
        <td>${esc(p.processDate?.toString().slice(0, 10))}</td>
        <td class="num">${numf(p.processQuantity)}</td><td class="num">${numf(p.processEndWt)}</td></tr>`).join('');
    $('#detail').innerHTML = `
      <div class="kv">
        <span><b>Coil</b> ${esc(c.coilAbcNum)}</span>
        <span><b>Alloy</b> ${esc(c.coilAlloy2)} ${esc(c.coilTemper)}</span>
        <span><b>Gauge</b> ${numf(c.coilGauge)} &times; ${numf(c.coilWidth)}</span>
        <span><b>Lot</b> ${esc(c.lotNum)}</span>
        <span><b>On hand</b> ${numf(c.netWtBalance)} / ${numf(c.netWt)}</span>
      </div>
      <div class="row" style="margin:10px 0">
        <div><label>Status</label><br /><input id="eStatus" value="${esc(c.coilStatus)}" style="width:70px" /></div>
        <div><label>Location</label><br /><input id="eLocation" value="${esc(c.coilLocation)}" style="width:120px" /></div>
        <div style="flex:1"><label>Notes</label><br /><input id="eNotes" value="${esc(c.coilNotes)}" style="width:100%" /></div>
        <button id="btnSave" type="button">Save</button>
      </div>
      <h2>Processing history</h2>
      <table><thead><tr><th>Job</th><th>Status</th><th>Date</th>
        <th class="num">Qty</th><th class="num">End wt</th></tr></thead>
        <tbody>${hist || '<tr><td colspan="5" class="muted">Not yet processed.</td></tr>'}</tbody></table>`;
    $('#btnSave').addEventListener('click', saveCoil);
  } catch (e) { setErr(`Load failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

async function saveCoil(): Promise<void> {
  if (selected == null) return;
  setErr(''); setBusy(true);
  const patch = new CoilPatch({
    coilStatus: val('#eStatus') ? Number(val('#eStatus')) : undefined,
    coilLocation: val('#eLocation') || undefined,
    coilNotes: val('#eNotes') || undefined,
  });
  try {
    await client().patchCoil(selected, patch);
    $('#detail').insertAdjacentHTML('afterbegin', '<div class="ok">✓ Saved.</div>');
    await search();
  } catch (e) { setErr(`Save failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

// ---- Wire up ---------------------------------------------------------------
async function init(): Promise<void> {
  $<HTMLFormElement>('#searchForm').addEventListener('submit', (e) => { e.preventDefault(); void search(); });
  $('#btnSummary').addEventListener('click', summary);
  await search();
  await summary();
}

void init();
