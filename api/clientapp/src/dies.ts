// ABIS Dies / Tooling — greenfield (Path C) module replacing the legacy die_tool
// window. A typed SPA on the Phase-2 API: filterable die search and a full
// load → edit → save form (create or replace). Through the NSwag-generated,
// compiler-checked client.
//
// Compiled by `tsc` to wwwroot/ui/app/dies.js; served at /ui/dies.html.
import { AbisClient, DieWrite } from './generated/abis-client.js';

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
const setOk = (m: string) => { $('#ok').textContent = m; };
const setBusy = (b: boolean) => document.body.classList.toggle('busy', b);
const v = (id: string) => $<HTMLInputElement>(id).value.trim();
const setV = (id: string, value: unknown) => { $<HTMLInputElement>(id).value = value == null ? '' : String(value); };

let editingId: number | null = null;

async function search(): Promise<void> {
  setErr(''); setBusy(true);
  const status = v('#fStatus') ? Number(v('#fStatus')) : undefined;
  try {
    const page = await client().listDies(1, 50, status, undefined, undefined);
    const rows = (page.items ?? []).map((d) => `
      <tr class="click" data-id="${d.dieId}">
        <td>${esc(d.dieId)}</td>
        <td>${esc(d.dieName)}</td>
        <td>${esc(d.status)}</td>
        <td>${esc(d.toolNum)}</td>
        <td>${esc(d.partName)}</td>
        <td>${esc(d.location)}</td>
      </tr>`).join('');
    $('#dies').innerHTML = rows || '<tr><td colspan="6" class="muted">No matching dies.</td></tr>';
    $('#count').textContent = `${numf(page.totalCount)} total`;
    document.querySelectorAll<HTMLTableRowElement>('#dies tr.click').forEach((tr) =>
      tr.addEventListener('click', () => loadDie(Number(tr.dataset.id))));
  } catch (e) { setErr(`Search failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

async function loadDie(id: number): Promise<void> {
  setErr(''); setOk(''); setBusy(true);
  try {
    const d = await client().getDie(id);
    editingId = id;
    $('#formTitle').textContent = `Edit die #${id}`;
    setV('#dName', d.dieName); setV('#dStatus', d.status); setV('#dTool', d.toolNum);
    setV('#dPart', d.partName); setV('#dWeight', d.grossWeight);
    setV('#dLocation', d.location); setV('#dDesc', d.description);
  } catch (e) { setErr(`Load failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

function newDie(): void {
  editingId = null;
  $('#formTitle').textContent = 'New die';
  ['#dName', '#dStatus', '#dTool', '#dPart', '#dWeight', '#dLocation', '#dDesc'].forEach((id) => setV(id, ''));
  setOk(''); setErr('');
}

async function save(): Promise<void> {
  setErr(''); setOk(''); setBusy(true);
  const body = new DieWrite({
    dieName: v('#dName') || undefined,
    status: v('#dStatus') ? Number(v('#dStatus')) : undefined,
    toolNum: v('#dTool') || undefined,
    partName: v('#dPart') || undefined,
    grossWeight: v('#dWeight') ? Number(v('#dWeight')) : undefined,
    location: v('#dLocation') || undefined,
    description: v('#dDesc') || undefined,
  });
  try {
    if (editingId == null) {
      const created = await client().createDie(body);
      setOk(`✓ Created die #${created.dieId}.`);
    } else {
      await client().updateDie(editingId, body);
      setOk(`✓ Saved die #${editingId}.`);
    }
    await search();
  } catch (e) { setErr(`Save failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

function init(): void {
  $<HTMLFormElement>('#searchForm').addEventListener('submit', (e) => { e.preventDefault(); void search(); });
  $('#btnNew').addEventListener('click', newDie);
  $('#btnSave').addEventListener('click', save);
  newDie();
  void search();
}

init();
