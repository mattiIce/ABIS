// ABIS Reporting — greenfield (Path C) production reporting (legacy daily_prod). A
// typed SPA on the Phase-2 API: the per-line production summary over an optional date
// window (job count, average material yield, processed weight), aggregated server-
// side over line ⋈ ab_job ⋈ process_coil. Through the NSwag-generated client.
//
// Compiled by `tsc` to wwwroot/ui/app/reporting.js; served at /ui/reporting.html.
import { AbisClient } from './generated/abis-client.js';

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
const setBusy = (b: boolean) => document.body.classList.toggle('busy', b);
const dv = (id: string) => { const s = $<HTMLInputElement>(id).value.trim(); return s ? new Date(s) : undefined; };
const num = (n: number | undefined, dp = 0): string => (n == null ? '' : n.toLocaleString(undefined, { maximumFractionDigits: dp }));
const pct = (n: number | undefined): string => (n == null ? '' : `${n.toLocaleString(undefined, { maximumFractionDigits: 1 })}`);

async function run(): Promise<void> {
  setErr(''); setBusy(true);
  try {
    const rows = await client().getProductionSummary(dv('#from'), dv('#to'));
    const items = rows ?? [];
    $('#rows').innerHTML = items.map((r) => `
      <tr>
        <td>${esc(r.lineNum)}</td><td>${esc(r.lineDesc)}</td>
        <td style="text-align:right">${esc(num(r.jobCount))}</td>
        <td style="text-align:right">${esc(pct(r.avgYield))}</td>
        <td style="text-align:right">${esc(num(r.processedWt))}</td></tr>`).join('')
      || '<tr><td colspan="5" class="muted">No production data.</td></tr>';
    const totJobs = items.reduce((a, r) => a + (r.jobCount ?? 0), 0);
    const totWt = items.reduce((a, r) => a + (r.processedWt ?? 0), 0);
    $('#totals').textContent = `${items.length} line(s) · ${num(totJobs)} jobs · ${num(totWt)} lb processed`;
  } catch (e) { setErr(`Report failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

async function init(): Promise<void> {
  $<HTMLFormElement>('#repForm').addEventListener('submit', (e) => { e.preventDefault(); void run(); });
  await initAuth();
  await run();
}

void init();
