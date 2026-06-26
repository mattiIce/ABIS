// ABIS Reporting — greenfield (Path C) production reporting (legacy daily_prod). A
// typed SPA on the Phase-2 API: the per-line production summary over an optional date
// window (job count, average material yield, processed weight), aggregated server-
// side over line ⋈ ab_job ⋈ process_coil. Through the NSwag-generated client.
//
// Compiled by `tsc` to wwwroot/ui/app/reporting.js; served at /ui/reporting.html.
import { AbisClient } from './generated/abis-client.js';
import { initAuth, authFetch } from './auth.js';
const $ = (sel) => document.querySelector(sel);
// Auth — a Bearer token (OIDC) or the X-Api-Key field — is attached by ./auth.
function client() {
    return new AbisClient('', { fetch: authFetch });
}
const esc = (s) => String(s ?? '').replace(/[&<>]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' }[c]));
const setErr = (m) => { $('#err').textContent = m; };
const setBusy = (b) => document.body.classList.toggle('busy', b);
const dv = (id) => { const s = $(id).value.trim(); return s ? new Date(s) : undefined; };
const num = (n, dp = 0) => (n == null ? '' : n.toLocaleString(undefined, { maximumFractionDigits: dp }));
const pct = (n) => (n == null ? '' : `${n.toLocaleString(undefined, { maximumFractionDigits: 1 })}`);
async function run() {
    setErr('');
    setBusy(true);
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
    }
    catch (e) {
        setErr(`Report failed: ${e.message}`);
    }
    finally {
        setBusy(false);
    }
}
async function init() {
    $('#repForm').addEventListener('submit', (e) => { e.preventDefault(); void run(); });
    await initAuth();
    await run();
}
void init();
