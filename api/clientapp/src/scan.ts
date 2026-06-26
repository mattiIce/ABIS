// ABIS Scan — greenfield (Path C) shop-floor module replacing the legacy `scan`
// (barcode) window. Scan events are append-only, so this is a capture form +
// recent-events list (filterable by job), not an edit screen. A typed SPA on the
// Phase-2 API through the NSwag-generated, compiler-checked client.
//
// Compiled by `tsc` to wwwroot/ui/app/scan.js; served at /ui/scan.html.
import { AbisClient, ScanLogWrite } from './generated/abis-client.js';

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
const dt = (d: Date | undefined): string => (d == null ? '' : d.toLocaleString());

async function search(): Promise<void> {
  setErr(''); setBusy(true);
  const abJobNum = v('#fJob') ? Number(v('#fJob')) : undefined;
  try {
    const page = await client().listScanLogs(1, 50, abJobNum, 'scanDatetime', 'desc');
    const rows = (page.items ?? []).map((s) => `
      <tr>
        <td>${esc(s.scanId)}</td>
        <td>${esc(dt(s.scanDatetime))}</td>
        <td>${esc(s.abJobNum)}</td>
        <td>${esc(s.scanStation)}</td>
        <td>${esc(s.note)}</td>
      </tr>`).join('');
    $('#scans').innerHTML = rows || '<tr><td colspan="5" class="muted">No scans.</td></tr>';
    $('#count').textContent = `${(page.totalCount ?? 0).toLocaleString()} total`;
  } catch (e) { setErr(`Search failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

// Record a scan. Append-only: keep job + station for repeated scans, clear the note.
async function record(): Promise<void> {
  setErr(''); setOk(''); setBusy(true);
  const body = new ScanLogWrite({
    abJobNum: v('#sJob') ? Number(v('#sJob')) : undefined,
    scanStation: v('#sStation') || undefined,
    note: v('#sNote') || undefined,
  });
  try {
    const created = await client().createScanLog(body);
    setOk(`✓ Recorded scan #${created.scanId}.`);
    $<HTMLInputElement>('#sNote').value = '';
    $<HTMLInputElement>('#sNote').focus();
    await search();
  } catch (e) { setErr(`Record failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

async function init(): Promise<void> {
  $<HTMLFormElement>('#searchForm').addEventListener('submit', (e) => { e.preventDefault(); void search(); });
  $<HTMLFormElement>('#scanForm').addEventListener('submit', (e) => { e.preventDefault(); void record(); });
  await search();
}

void initAuth().then(init);
