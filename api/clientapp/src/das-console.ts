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
const setV = (id: string, val: unknown) => { $<HTMLInputElement>(id).value = val == null ? '' : String(val); };
const num = (n: number | undefined): string => (n == null ? '' : n.toLocaleString());
const dShow = (d: Date | undefined): string => (d == null ? '' : d.toLocaleString());

let job: number | null = null;
let lineNum: number | null = null;

async function loadJob(): Promise<void> {
  setErr(''); setOk('');
  const id = v('#fJob') ? Number(v('#fJob')) : 0;
  if (!id) { setErr('Enter a job number.'); return; }
  setBusy(true);
  try {
    const j = await client().getJob(id);
    job = id; lineNum = j.lineNum ?? null;
    $('#jobHdr').textContent = `Job ${id} · line ${j.lineNum ?? '—'} · status ${j.jobStatus ?? '—'} · order ${j.orderAbcNum ?? ''}/${j.orderItemNum ?? ''}`;
    $('#workarea').classList.remove('disabled');
    await Promise.all([loadCoils(), loadSkids(), loadScrap()]);
  } catch (e) { setErr(`Load job failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

async function loadCoils(): Promise<void> {
  const rows = await client().getJobCoils(job!);
  $('#tCoils').innerHTML = (rows ?? []).map((c) => `<tr>
    <td>${esc(c.coilAbcNum)}</td><td>${esc(c.processCoilStatus)}</td><td>${esc(num(c.processEndWt))}</td>
    <td>${esc(num(c.processQuantity))}</td><td>${esc(c.coilAlloy2)}</td><td>${esc(c.coilGauge)}</td></tr>`).join('')
    || '<tr><td colspan="6" class="muted">No coils.</td></tr>';
}

async function loadSkids(): Promise<void> {
  const rows = await client().getJobSkids(job!);
  $('#tSkids').innerHTML = (rows ?? []).map((s) => `<tr>
    <td>${esc(s.sheetSkidNum)}</td><td>${esc(s.sheetSkidDisplayNum)}</td><td>${esc(num(s.sheetNetWt))}</td>
    <td>${esc(num(s.sheetTareWt))}</td><td>${esc(s.skidPieces)}</td><td>${esc(dShow(s.skidDate))}</td></tr>`).join('')
    || '<tr><td colspan="6" class="muted">No skids yet.</td></tr>';
}

async function loadScrap(): Promise<void> {
  const rows = await client().getJobScrap(job!);
  $('#tScrap').innerHTML = (rows ?? []).map((s) => `<tr>
    <td>${esc(s.scrapSkidNum)}</td><td>${esc(s.scrapAlloy2)}</td><td>${esc(s.scrapType)}</td>
    <td>${esc(num(s.scrapNetWt))}</td><td>${esc(s.scrapLocation)}</td></tr>`).join('')
    || '<tr><td colspan="5" class="muted">No scrap yet.</td></tr>';
}

// Pull the current weight from the shop-floor edge service (/reading), if its URL is set.
async function pullWeight(): Promise<void> {
  const edge = v('#edgeUrl');
  if (!edge) { setErr('Set the edge URL to pull a live weight (e.g. http://edge-host:8090).'); return; }
  try {
    const r = await fetch(edge.replace(/\/$/, '') + '/reading', { cache: 'no-store' });
    if (!r.ok) throw new Error(`edge ${r.status}`);
    const reading = await r.json() as { value?: number; unit?: string };
    setV('#skNet', reading.value);
    setOk(`Pulled ${reading.value ?? ''} ${reading.unit ?? ''} from the scale.`);
  } catch (e) { setErr(`Scale read failed: ${(e as Error).message} (enter the weight manually).`); }
}

async function saveSkid(): Promise<void> {
  if (job == null) return;
  setErr(''); setOk(''); setBusy(true);
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
  } catch (e) { setErr(`Save skid failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

async function saveScrap(): Promise<void> {
  if (job == null) return;
  setErr(''); setOk(''); setBusy(true);
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
  } catch (e) { setErr(`Save scrap failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

async function saveDowntime(): Promise<void> {
  if (job == null) return;
  setErr(''); setOk(''); setBusy(true);
  try {
    await client().createDowntimeInstance(new DowntimeInstanceWrite({
      abJobNum: job, lineNum: lineNum ?? undefined,
      startingTime: v('#dtStart') ? new Date(v('#dtStart')) : undefined,
      endingTime: v('#dtEnd') ? new Date(v('#dtEnd')) : undefined,
      note: v('#dtNote') || undefined,
    }));
    setOk('✓ Logged downtime.');
    ['#dtStart', '#dtEnd', '#dtNote'].forEach((i) => setV(i, ''));
  } catch (e) { setErr(`Log downtime failed: ${(e as Error).message}`); }
  finally { setBusy(false); }
}

function showTab(name: string): void {
  ['skids', 'scrap', 'downtime', 'coils'].forEach((t) => {
    $(`#pane-${t}`).style.display = t === name ? '' : 'none';
    $(`#tab-${t}`).classList.toggle('active', t === name);
  });
}

async function init(): Promise<void> {
  $<HTMLFormElement>('#jobForm').addEventListener('submit', (e) => { e.preventDefault(); void loadJob(); });
  ['skids', 'scrap', 'downtime', 'coils'].forEach((t) => $(`#tab-${t}`).addEventListener('click', () => showTab(t)));
  $('#btnPull').addEventListener('click', pullWeight);
  $('#btnSkid').addEventListener('click', saveSkid);
  $('#btnScrap').addEventListener('click', saveScrap);
  $('#btnDt').addEventListener('click', saveDowntime);
  showTab('skids');
  await initAuth();
}

void init();
