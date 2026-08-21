// Shaping the Recovery page's three tables for export — kept in its own module so it can be unit
// tested. `recovery.ts` runs an IIFE at import time (it mounts the shell), so a test that imported it
// would boot the whole page.
//
// WHAT LEGACY HAD, AND DID NOT (audited 2026-08-21 against `quality/w_recovery.srw`):
//   • **Print** is real — `cb_3` calls `dw_report.Event pfc_print()` over
//     `d_recovery_customer_report_template.srd`. It cannot be ported: that template is one of the ~10
//     EXTERNAL DataWindows (layout only, no SQL, columns are positional slots filled by PowerScript)
//     and the window that fills it is not vendored. Recorded in OPEN_QUESTIONS §C4.
//   • **Email is DEAD.** `cb_email` is declared, created and destroyed — and has **no `event clicked`
//     of any kind**. It is a button on screen that does nothing, and has been for as long as the
//     vendored source goes back. There is nothing to port.
//   • **Export did not exist at all.** So this is new capability, not parity — chosen because every
//     other report in the modern app exports, and the plant's legacy reports were Excel/PDF.
//
// Numbers stay numeric (never pre-formatted strings): the whole point of .xlsx over CSV is that Excel
// can sum and sort them without the reader re-typing the column.
const n = (v) => (v ?? null);
const t = (v) => {
    const s = (v ?? '').trim();
    return s.length === 0 ? null : s;
};
/**
 * The flags column is four separate 0/1 columns on the row. On screen they are chips; in a
 * spreadsheet they become one readable list, because four boolean columns a reader has to decode is
 * worse than one they can filter on.
 */
export function flagText(r) {
    const f = [];
    if (r.coilRejected)
        f.push('rejected');
    if (r.coilRebanded)
        f.push('rebanded');
    if (r.specialAttention)
        f.push('attention');
    if (r.specialHandling)
        f.push('handling');
    return f.length ? f.join(', ') : null;
}
/** The daily recovery report — the table legacy's Print button printed. */
export function reportTable(abJobNum, rows) {
    return {
        name: `recovery-job-${abJobNum}`,
        headers: ['Coil', 'Coil id', 'Lot', 'Alloy', 'Type', 'Coil wt', 'Ship wt', 'Scrap wt', 'Rejected wt', 'Yield', 'Flags'],
        rows: rows.map((r) => [
            // The org number is what the customer calls the coil and what the operator reads off the tag;
            // our own id follows it rather than replacing it, so both sides can match a row up.
            t(r.coilOrgNum) ?? n(r.coilAbcNum),
            n(r.coilAbcNum),
            t(r.lotNum),
            t(r.alloy),
            t(r.productType),
            n(r.coilWt),
            n(r.shipWt),
            n(r.scrapWt),
            n(r.rejectedWt),
            // Yield ships as the FRACTION, not "94.2%". A percent-formatted string is a string, and the
            // reader loses the ability to average it — which is the first thing anyone does with a yield.
            n(r.yield),
            flagText(r),
        ]),
    };
}
/** Scrap by defect — the Pareto, flattened. */
export function defectTable(abJobNum, rows) {
    return {
        name: `recovery-scrap-by-defect-job-${abJobNum}`,
        headers: ['Code', 'Defect', 'Net wt', 'Pieces', 'Share of scrap'],
        rows: rows.map((d) => [t(d.scrapCode), t(d.scrapDefect), n(d.netWt), n(d.pieces), n(d.pct)]),
    };
}
/**
 * One coil's scrap worksheet.
 *
 * <para>`source` and `autoparts` ride along as columns on every row rather than as a header note,
 * because they change what the numbers MEAN and a spreadsheet has no header to read. "office" means
 * the quality office's figures, which supersede the floor's entirely; an autopart means the defect
 * list was narrowed. A reader who cannot tell those apart cannot trust the column.</para>
 */
export function worksheetTable(w) {
    const src = w.source === 'office' ? 'office' : 'DAS';
    return {
        name: `recovery-worksheet-job-${w.abJobNum}-coil-${w.coilAbcNum}`,
        headers: ['Code', 'Defect', 'Net wt', 'Pieces', 'Source', 'Autopart'],
        rows: w.rows.map((r) => [
            t(r.scrapCode), t(r.scrapDefect), n(r.netWt), n(r.pieces), src, w.autoparts ? 'yes' : 'no',
        ]),
    };
}
/**
 * CSV text for a table. Quotes only when needed, doubles embedded quotes, and uses CRLF — Excel on
 * Windows is the consumer and it is the one that cares.
 */
export function toCsv(table) {
    const cell = (v) => {
        if (v == null)
            return '';
        const s = String(v);
        return /[",\r\n]/.test(s) ? `"${s.replace(/"/g, '""')}"` : s;
    };
    return [table.headers.map((h) => cell(h)).join(','), ...table.rows.map((r) => r.map(cell).join(','))]
        .join('\r\n');
}
