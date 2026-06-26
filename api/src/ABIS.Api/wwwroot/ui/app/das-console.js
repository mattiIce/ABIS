// ABIS DAS console — greenfield (Path C) shop-floor operator console, the modern
// w_da_sheet. The legacy DAS is a tabbed data-acquisition window the operator works a
// job from: current coil/job, weigh & save finished skids, enter scrap, and log
// downtime. This rebuilds that as a typed SPA that ties a job's context together and
// posts through the existing API (no API change). The live scale weight can be pulled
// from the shop-floor edge service (/reading) when its URL is set.
//
// Compiled by `tsc` to wwwroot/ui/app/das-console.js; served at /ui/das-console.html.
import { AbisClient, SheetSkidWrite, ScrapSkidWrite, DowntimeInstanceWrite } from './generated/abis-client.js';
import { initAuth, authFetch } from './auth.js';
const $ = (sel) => document.querySelector(sel);
// Auth — a Bearer token (OIDC) or the X-Api-Key field — is attached by ./auth.
function client() {
    return new AbisClient('', { fetch: authFetch });
}
const esc = (s) => String(s ?? '').replace(/[&<>]/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;' }[c]));
const setErr = (m) => { $('#err').textContent = m; };
const setOk = (m) => { $('#ok').textContent = m; };
const setBusy = (b) => document.body.classList.toggle('busy', b);
const v = (id) => $(id).value.trim();
const setV = (id, val) => { $(id).value = val == null ? '' : String(val); };
const num = (n) => (n == null ? '' : n.toLocaleString());
const dShow = (d) => (d == null ? '' : d.toLocaleString());
let job = null;
let lineNum = null;
async function loadJob() {
    setErr('');
    setOk('');
    const id = v('#fJob') ? Number(v('#fJob')) : 0;
    if (!id) {
        setErr('Enter a job number.');
        return;
    }
    setBusy(true);
    try {
        const j = await client().getJob(id);
        job = id;
        lineNum = j.lineNum ?? null;
        $('#jobHdr').textContent = `Job ${id} · line ${j.lineNum ?? '—'} · status ${j.jobStatus ?? '—'} · order ${j.orderAbcNum ?? ''}/${j.orderItemNum ?? ''}`;
        $('#workarea').classList.remove('disabled');
        await Promise.all([loadCoils(), loadSkids(), loadScrap()]);
    }
    catch (e) {
        setErr(`Load job failed: ${e.message}`);
    }
    finally {
        setBusy(false);
    }
}
async function loadCoils() {
    const rows = await client().getJobCoils(job);
    $('#tCoils').innerHTML = (rows ?? []).map((c) => `<tr>
    <td>${esc(c.coilAbcNum)}</td><td>${esc(c.processCoilStatus)}</td><td>${esc(num(c.processEndWt))}</td>
    <td>${esc(num(c.processQuantity))}</td><td>${esc(c.coilAlloy2)}</td><td>${esc(c.coilGauge)}</td></tr>`).join('')
        || '<tr><td colspan="6" class="muted">No coils.</td></tr>';
}
async function loadSkids() {
    const rows = await client().getJobSkids(job);
    $('#tSkids').innerHTML = (rows ?? []).map((s) => `<tr>
    <td>${esc(s.sheetSkidNum)}</td><td>${esc(s.sheetSkidDisplayNum)}</td><td>${esc(num(s.sheetNetWt))}</td>
    <td>${esc(num(s.sheetTareWt))}</td><td>${esc(s.skidPieces)}</td><td>${esc(dShow(s.skidDate))}</td></tr>`).join('')
        || '<tr><td colspan="6" class="muted">No skids yet.</td></tr>';
}
async function loadScrap() {
    const rows = await client().getJobScrap(job);
    $('#tScrap').innerHTML = (rows ?? []).map((s) => `<tr>
    <td>${esc(s.scrapSkidNum)}</td><td>${esc(s.scrapAlloy2)}</td><td>${esc(s.scrapType)}</td>
    <td>${esc(num(s.scrapNetWt))}</td><td>${esc(s.scrapLocation)}</td></tr>`).join('')
        || '<tr><td colspan="5" class="muted">No scrap yet.</td></tr>';
}
// Pull the current weight from the shop-floor edge service (/reading), if its URL is set.
async function pullWeight() {
    const edge = v('#edgeUrl');
    if (!edge) {
        setErr('Set the edge URL to pull a live weight (e.g. http://edge-host:8090).');
        return;
    }
    try {
        const r = await fetch(edge.replace(/\/$/, '') + '/reading', { cache: 'no-store' });
        if (!r.ok)
            throw new Error(`edge ${r.status}`);
        const reading = await r.json();
        setV('#skNet', reading.value);
        setOk(`Pulled ${reading.value ?? ''} ${reading.unit ?? ''} from the scale.`);
    }
    catch (e) {
        setErr(`Scale read failed: ${e.message} (enter the weight manually).`);
    }
}
async function saveSkid() {
    if (job == null)
        return;
    setErr('');
    setOk('');
    setBusy(true);
    try {
        const created = await client().createSheetSkid(new SheetSkidWrite({
            abJobNum: job,
            sheetSkidDisplayNum: v('#skDisplay') || undefined,
            sheetNetWt: v('#skNet') ? Number(v('#skNet')) : undefined,
            sheetTareWt: v('#skTare') ? Number(v('#skTare')) : undefined,
            skidPieces: v('#skPieces') ? Number(v('#skPieces')) : undefined,
        }));
        setOk(`✓ Saved sheet skid #${created.sheetSkidNum}.`);
        ['#skDisplay', '#skNet', '#skTare', '#skPieces'].forEach((i) => setV(i, ''));
        await loadSkids();
    }
    catch (e) {
        setErr(`Save skid failed: ${e.message}`);
    }
    finally {
        setBusy(false);
    }
}
async function saveScrap() {
    if (job == null)
        return;
    setErr('');
    setOk('');
    setBusy(true);
    try {
        const created = await client().createScrapSkid(new ScrapSkidWrite({
            scrapAbJobNum: String(job),
            scrapAlloy2: v('#scAlloy') || undefined,
            scrapTemper: v('#scTemper') || undefined,
            scrapType: v('#scType') ? Number(v('#scType')) : undefined,
            scrapNetWt: v('#scNet') ? Number(v('#scNet')) : undefined,
            scrapLocation: v('#scLoc') || undefined,
        }));
        setOk(`✓ Saved scrap skid #${created.scrapSkidNum}.`);
        ['#scAlloy', '#scTemper', '#scType', '#scNet', '#scLoc'].forEach((i) => setV(i, ''));
        await loadScrap();
    }
    catch (e) {
        setErr(`Save scrap failed: ${e.message}`);
    }
    finally {
        setBusy(false);
    }
}
async function saveDowntime() {
    if (job == null)
        return;
    setErr('');
    setOk('');
    setBusy(true);
    try {
        await client().createDowntimeInstance(new DowntimeInstanceWrite({
            abJobNum: job, lineNum: lineNum ?? undefined,
            startingTime: v('#dtStart') ? new Date(v('#dtStart')) : undefined,
            endingTime: v('#dtEnd') ? new Date(v('#dtEnd')) : undefined,
            note: v('#dtNote') || undefined,
        }));
        setOk('✓ Logged downtime.');
        ['#dtStart', '#dtEnd', '#dtNote'].forEach((i) => setV(i, ''));
    }
    catch (e) {
        setErr(`Log downtime failed: ${e.message}`);
    }
    finally {
        setBusy(false);
    }
}
function showTab(name) {
    ['skids', 'scrap', 'downtime', 'coils'].forEach((t) => {
        $(`#pane-${t}`).style.display = t === name ? '' : 'none';
        $(`#tab-${t}`).classList.toggle('active', t === name);
    });
}
async function init() {
    $('#jobForm').addEventListener('submit', (e) => { e.preventDefault(); void loadJob(); });
    ['skids', 'scrap', 'downtime', 'coils'].forEach((t) => $(`#tab-${t}`).addEventListener('click', () => showTab(t)));
    $('#btnPull').addEventListener('click', pullWeight);
    $('#btnSkid').addEventListener('click', saveSkid);
    $('#btnScrap').addEventListener('click', saveScrap);
    $('#btnDt').addEventListener('click', saveDowntime);
    showTab('skids');
    await initAuth();
}
void init();
