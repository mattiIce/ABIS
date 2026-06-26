// ABIS QA Results — third greenfield (Path C) module, replacing the legacy qa
// window. A typed read/reporting SPA on the Phase-2 API: mechanical test results
// (posted + in-progress working set) with test-type / position / date-range
// filters. Read-only; every call goes through the compiler-checked client.
//
// Compiled by `tsc` to wwwroot/ui/app/qa-results.js; served at /ui/qa-results.html.
import { AbisClient } from './generated/abis-client.js';
const $ = (sel) => document.querySelector(sel);
const keyInput = $('#apiKey');
keyInput.value = localStorage.getItem('abis_api_key') ?? 'dev-local-key';
keyInput.addEventListener('change', () => localStorage.setItem('abis_api_key', keyInput.value));
function client() {
    return new AbisClient('', {
        fetch: (url, init) => {
            const headers = new Headers(init?.headers);
            headers.set('X-Api-Key', keyInput.value);
            return fetch(url, { ...init, headers });
        },
    });
}
const esc = (s) => String(s ?? '').replace(/[&<>]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' }[c]));
const dec = (v) => (v == null ? '' : v.toFixed(2));
const setErr = (m) => { $('#err').textContent = m; };
const setBusy = (b) => document.body.classList.toggle('busy', b);
const val = (id) => $(id).value.trim();
const dateOrUndef = (id) => (val(id) ? new Date(val(id)) : undefined);
function render(rows, total) {
    const body = rows.map((t) => `
    <tr>
      <td>${esc(t.createdDate?.toISOString().slice(0, 10))}</td>
      <td>${esc(t.testType)}</td>
      <td>${esc(t.position)}</td>
      <td class="num">${dec(t.yts)}</td>
      <td class="num">${dec(t.uts)}</td>
      <td class="num">${dec(t.elong)}</td>
      <td class="num">${dec(t.n)}</td>
      <td class="num">${dec(t.r)}</td>
      <td class="num">${dec(t.thickness)}</td>
      <td class="num">${dec(t.width)}</td>
    </tr>`).join('');
    $('#results').innerHTML = body || '<tr><td colspan="10" class="muted">No matching results.</td></tr>';
    $('#count').textContent = `${(total ?? 0).toLocaleString()} total`;
}
async function load() {
    setErr('');
    setBusy(true);
    const testType = val('#fType') ? Number(val('#fType')) : undefined;
    const position = val('#fPosition') || undefined;
    const from = dateOrUndef('#fFrom');
    const to = dateOrUndef('#fTo');
    const inProgress = $('#fInProgress').checked;
    try {
        if (inProgress) {
            const page = await client().listTempTestResults(1, 100, testType, position, from, to, undefined, undefined);
            render((page.items ?? []).map((t) => ({
                createdDate: t.createdDate, testType: t.testType, position: t.position,
                yts: t.yts, uts: t.uts, elong: t.elongation, n: t.n, r: t.r, thickness: t.thickness, width: t.width,
            })), page.totalCount);
        }
        else {
            const page = await client().listTestResults(1, 100, testType, position, from, to, undefined, undefined);
            render((page.items ?? []).map((t) => ({
                createdDate: t.createdDate, testType: t.testType, position: t.position,
                yts: t.ytsVal, uts: t.utsVal, elong: t.elongVal, n: t.nVal, r: t.rVal, thickness: t.thickness, width: t.width,
            })), page.totalCount);
        }
    }
    catch (e) {
        setErr(`Load failed: ${e.message}`);
    }
    finally {
        setBusy(false);
    }
}
function init() {
    $('#filterForm').addEventListener('submit', (e) => { e.preventDefault(); void load(); });
    $('#fInProgress').addEventListener('change', () => void load());
    void load();
}
init();
