// ABIS Accounting / Invoicing — greenfield (Path C) module for the legacy w_invoice
// window. The invoice is driven by a job's rejected (3) / rebanded (7) coils
// (d_rej_reband_coil_list_for_invoice: coil ⋈ process_coil). Read-only view: enter a
// job, see its invoice-relevant coils + the billed weight. Through the NSwag-
// generated, compiler-checked client.
//
// Compiled by `tsc` to wwwroot/ui/app/accounting.js; served at /ui/accounting.html.
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
const v = (id) => $(id).value.trim();
const num = (n) => (n == null ? '' : n.toLocaleString(undefined, { maximumFractionDigits: 2 }));
const dShow = (d) => (d == null ? '' : d.toLocaleDateString());
const statusLabel = (s) => (s === 3 ? 'Rejected' : s === 7 ? 'Rebanded' : String(s ?? ''));
async function load() {
    setErr('');
    setBusy(true);
    const job = v('#fJob') ? Number(v('#fJob')) : 0;
    if (!job) {
        setErr('Enter a job number.');
        setBusy(false);
        return;
    }
    try {
        const coils = await client().getInvoiceCoils(job);
        const rows = (coils ?? []).map((c) => `
      <tr>
        <td>${esc(c.coilAbcNum)}</td><td>${esc(c.coilOrgNum)}</td><td>${esc(c.coilMidNum)}</td>
        <td>${esc(c.lotNum)}</td><td>${esc(c.coilGauge)}</td><td>${esc(num(c.netWt))}</td>
        <td>${esc(num(c.netWtBalance))}</td><td>${esc(num(c.processEndWt))}</td>
        <td>${esc(num(c.processQuantity))}</td><td>${esc(dShow(c.processDate))}</td>
        <td>${esc(statusLabel(c.processCoilStatus))}</td></tr>`).join('');
        $('#coils').innerHTML = rows || '<tr><td colspan="11" class="muted">No rejected/rebanded coils for this job.</td></tr>';
        const items = coils ?? [];
        const totalEnd = items.reduce((a, c) => a + (c.processEndWt ?? 0), 0);
        const totalNet = items.reduce((a, c) => a + (c.netWt ?? 0), 0);
        $('#summary').textContent = `${items.length} coil(s) · billed (process end) wt ${num(totalEnd)} · net wt ${num(totalNet)}`;
    }
    catch (e) {
        setErr(`Load failed: ${e.message}`);
    }
    finally {
        setBusy(false);
    }
}
async function init() {
    $('#jobForm').addEventListener('submit', (e) => { e.preventDefault(); void load(); });
    await initAuth();
}
void init();
