// ABIS Reporting — greenfield (Path C) production reporting (legacy daily_prod /
// silverdome3 w_report_production_*). A typed SPA on the Phase-2 API: a report selector
// over an optional date window, rendered into a dynamic-column table with CSV export.
// Reports: production summary, line efficiency (+ downtime), monthly production, downtime
// events, on-time delivery — all aggregated server-side. Through the NSwag client.
//
// Compiled by `tsc` to wwwroot/ui/app/reporting.js; served at /ui/reporting.html.
import { AbisClient } from './generated/abis-client.js';
import { initAuth, authFetch } from './auth.js';
const $ = (sel) => document.querySelector(sel);
function client() {
    return new AbisClient('', { fetch: authFetch });
}
const esc = (s) => String(s ?? '').replace(/[&<>]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' }[c]));
const setErr = (m) => { $('#err').textContent = m; };
const setBusy = (b) => document.body.classList.toggle('busy', b);
const dv = (id) => { const s = $(id).value.trim(); return s ? new Date(s) : undefined; };
const num = (n, dp = 0) => (n == null ? '' : Number(n).toLocaleString(undefined, { maximumFractionDigits: dp }));
const dt = (d) => (d == null ? '' : new Date(d).toLocaleString());
const REPORTS = {
    summary: {
        note: 'Per-line roll-up over line ⋈ ab_job ⋈ process_coil (legacy daily_prod).',
        load: (f, t) => client().getProductionSummary(f, t),
        cols: [
            { h: 'Line', f: (r) => esc(r.lineNum) }, { h: 'Description', f: (r) => esc(r.lineDesc) },
            { h: 'Jobs', num: true, f: (r) => num(r.jobCount), raw: (r) => r.jobCount },
            { h: 'Avg yield %', num: true, f: (r) => num(r.avgYield, 1), raw: (r) => r.avgYield },
            { h: 'Processed wt', num: true, f: (r) => num(r.processedWt), raw: (r) => r.processedWt },
        ],
    },
    efficiency: {
        note: 'Per-line jobs, processed weight, avg yield, and downtime (events + minutes).',
        load: (f, t) => client().getLineEfficiency(f, t),
        cols: [
            { h: 'Line', f: (r) => esc(r.lineNum) }, { h: 'Description', f: (r) => esc(r.lineDesc) },
            { h: 'Jobs', num: true, f: (r) => num(r.jobCount), raw: (r) => r.jobCount },
            { h: 'Processed wt', num: true, f: (r) => num(r.processedWt), raw: (r) => r.processedWt },
            { h: 'Avg yield %', num: true, f: (r) => num(r.avgYield, 1), raw: (r) => r.avgYield },
            { h: 'DT events', num: true, f: (r) => num(r.downtimeEvents), raw: (r) => r.downtimeEvents },
            { h: 'DT minutes', num: true, f: (r) => num(r.downtimeMinutes, 1), raw: (r) => r.downtimeMinutes },
        ],
    },
    monthly: {
        note: 'Production rolled up by month (YYYY-MM): jobs touched + processed weight.',
        load: (f, t) => client().getMonthlyProduction(f, t),
        cols: [
            { h: 'Month', f: (r) => esc(r.month) },
            { h: 'Jobs', num: true, f: (r) => num(r.jobCount), raw: (r) => r.jobCount },
            { h: 'Processed wt', num: true, f: (r) => num(r.processedWt), raw: (r) => r.processedWt },
        ],
    },
    downtime: {
        note: 'Individual downtime events with computed duration (minutes).',
        load: (f, t) => client().getProductionDowntime(f, t, undefined),
        cols: [
            { h: 'Line', f: (r) => esc(r.lineNum) }, { h: 'Desc', f: (r) => esc(r.lineDesc) },
            { h: 'Job', f: (r) => esc(r.abJobNum) }, { h: 'Start', f: (r) => esc(dt(r.startingTime)) },
            { h: 'End', f: (r) => esc(dt(r.endingTime)) },
            { h: 'Minutes', num: true, f: (r) => num(r.durationMinutes, 1), raw: (r) => r.durationMinutes },
            { h: 'Note', f: (r) => esc(r.note) },
        ],
    },
    ontime: {
        note: 'Per-line on-time delivery: jobs finished on/before due date.',
        load: (f, t) => client().getOnTimeDelivery(f, t),
        cols: [
            { h: 'Line', f: (r) => esc(r.lineNum) }, { h: 'Description', f: (r) => esc(r.lineDesc) },
            { h: 'Finished', num: true, f: (r) => num(r.finishedJobs), raw: (r) => r.finishedJobs },
            { h: 'On time', num: true, f: (r) => num(r.onTime), raw: (r) => r.onTime },
            { h: 'Late', num: true, f: (r) => num(r.late), raw: (r) => r.late },
            { h: 'On-time %', num: true, f: (r) => num(r.onTimePct, 1), raw: (r) => r.onTimePct },
        ],
    },
};
let current = [];
let currentKey = 'summary';
async function run() {
    setErr('');
    setBusy(true);
    currentKey = $('#report').value;
    const rep = REPORTS[currentKey];
    $('#repNote').textContent = rep.note;
    $('#head').innerHTML = rep.cols.map((c) => `<th${c.num ? ' style="text-align:right"' : ''}>${esc(c.h)}</th>`).join('');
    try {
        current = (await rep.load(dv('#from'), dv('#to'))) ?? [];
        $('#rows').innerHTML = current.map((r) => `<tr>${rep.cols.map((c) => `<td${c.num ? ' style="text-align:right"' : ''}>${c.f(r)}</td>`).join('')}</tr>`).join('')
            || `<tr><td colspan="${rep.cols.length}" class="muted">No data.</td></tr>`;
        $('#totals').textContent = `${current.length} row(s)`;
    }
    catch (e) {
        setErr(`Report failed: ${e.message}`);
    }
    finally {
        setBusy(false);
    }
}
// CSV export of the current report (raw numeric values, quoted text).
function exportCsv() {
    const rep = REPORTS[currentKey];
    const cell = (v) => { const s = String(v ?? ''); return /[",\n]/.test(s) ? `"${s.replace(/"/g, '""')}"` : s; };
    const header = rep.cols.map((c) => cell(c.h)).join(',');
    const lines = current.map((r) => rep.cols.map((c) => cell(c.raw ? c.raw(r) : c.f(r).replace(/&[a-z]+;/g, ''))).join(','));
    const csv = [header, ...lines].join('\r\n');
    const url = URL.createObjectURL(new Blob([csv], { type: 'text/csv' }));
    const a = document.createElement('a');
    a.href = url;
    a.download = `${currentKey}-report.csv`;
    a.click();
    URL.revokeObjectURL(url);
}
async function init() {
    $('#repForm').addEventListener('submit', (e) => { e.preventDefault(); void run(); });
    $('#btnCsv').addEventListener('click', exportCsv);
    await initAuth();
    await run();
}
void init();
