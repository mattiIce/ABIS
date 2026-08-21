import { describe, expect, it } from 'vitest';
import { defectTable, flagText, reportTable, toCsv, worksheetTable } from '../src/recovery-export.js';

/**
 * Exporting the Recovery page.
 *
 * Legacy's own Print button drove `d_recovery_customer_report_template.srd`, one of the external
 * DataWindows we cannot reach, and its Email button has no handler at all — so this is new capability
 * rather than a port, and the rules below are ours to get right.
 */
describe('recovery export', () => {
  describe('the daily recovery report', () => {
    it('keeps yield as a fraction, not a formatted percentage', () => {
      const tb = reportTable(1002, [{ coilAbcNum: 5, yield: 0.9421 }]);
      const yieldCol = tb.headers.indexOf('Yield');

      // "94.2%" is a string, and the first thing anyone does with a yield column is average it.
      expect(tb.rows[0][yieldCol]).toBe(0.9421);
    });

    it('keeps every weight numeric so Excel can sum the column', () => {
      const tb = reportTable(1002, [{ coilAbcNum: 5, coilWt: 12000, shipWt: 11000, scrapWt: 900, rejectedWt: 100 }]);
      for (const h of ['Coil wt', 'Ship wt', 'Scrap wt', 'Rejected wt']) {
        expect(typeof tb.rows[0][tb.headers.indexOf(h)]).toBe('number');
      }
    });

    it('shows the customer\'s coil number but keeps our id beside it', () => {
      const tb = reportTable(1002, [{ coilAbcNum: 232054, coilOrgNum: '4656100000' }]);
      // Both sides of a recovery dispute need to find the same row.
      expect(tb.rows[0][0]).toBe('4656100000');
      expect(tb.rows[0][1]).toBe(232054);
    });

    it('falls back to our id when the customer number is blank', () => {
      const tb = reportTable(1002, [{ coilAbcNum: 232054, coilOrgNum: '   ' }]);
      // Oracle CHAR columns pad with spaces, so "empty" arrives as whitespace, not ''.
      expect(tb.rows[0][0]).toBe(232054);
    });

    it('names the file after the job', () => {
      // Two exports of different jobs must not collide in the downloads folder.
      expect(reportTable(1002, []).name).toBe('recovery-job-1002');
      expect(reportTable(1003, []).name).toBe('recovery-job-1003');
    });
  });

  describe('the flags column', () => {
    it('collapses four 0/1 columns into one readable list', () => {
      expect(flagText({ coilRejected: 1, specialHandling: 1 })).toBe('rejected, handling');
    });

    it('is blank rather than "none" when nothing is flagged', () => {
      // A filter on the column should hide unflagged coils, not match a literal word.
      expect(flagText({})).toBeNull();
    });

    it('reports all four when all four are set', () => {
      expect(flagText({ coilRejected: 1, coilRebanded: 1, specialAttention: 1, specialHandling: 1 }))
        .toBe('rejected, rebanded, attention, handling');
    });
  });

  describe('the scrap worksheet', () => {
    const wks = {
      abJobNum: 1002, coilAbcNum: 232054, customerId: 1651, autoparts: true, source: 'office',
      rows: [{ scrapCode: 'ED', scrapDefect: 'Edge damage', netWt: 120.5, pieces: 3 }],
    };

    it('carries source and autopart on every row', () => {
      const tb = worksheetTable(wks);
      // These change what the numbers MEAN — office figures supersede the floor's entirely, and an
      // autopart narrows the defect list. A spreadsheet has no header note to carry that.
      expect(tb.rows[0][tb.headers.indexOf('Source')]).toBe('office');
      expect(tb.rows[0][tb.headers.indexOf('Autopart')]).toBe('yes');
    });

    it('labels a floor-captured worksheet as DAS', () => {
      const tb = worksheetTable({ ...wks, source: 'das', autoparts: false });
      expect(tb.rows[0][tb.headers.indexOf('Source')]).toBe('DAS');
      expect(tb.rows[0][tb.headers.indexOf('Autopart')]).toBe('no');
    });

    it('names the file after both the job and the coil', () => {
      expect(worksheetTable(wks).name).toBe('recovery-worksheet-job-1002-coil-232054');
    });

    it('keeps a zero weight as 0, not blank', () => {
      // Every configured defect appears, at zero if unbooked — a blank would read as "not measured".
      const tb = worksheetTable({ ...wks, rows: [{ scrapCode: 'ED', scrapDefect: 'Edge', netWt: 0, pieces: 0 }] });
      expect(tb.rows[0][tb.headers.indexOf('Net wt')]).toBe(0);
      expect(tb.rows[0][tb.headers.indexOf('Pieces')]).toBe(0);
    });
  });

  describe('scrap by defect', () => {
    it('keeps the share as a fraction', () => {
      const tb = defectTable(1002, [{ scrapCode: 'ED', scrapDefect: 'Edge damage', netWt: 900, pieces: 4, pct: 0.62 }]);
      expect(tb.rows[0][tb.headers.indexOf('Share of scrap')]).toBe(0.62);
    });
  });

  describe('CSV', () => {
    it('quotes only what needs quoting, and doubles embedded quotes', () => {
      const csv = toCsv({
        name: 'x', headers: ['a', 'b', 'c'],
        rows: [['plain', 'has,comma', 'has"quote']],
      });
      expect(csv.split('\r\n')[1]).toBe('plain,"has,comma","has""quote"');
    });

    it('quotes a value containing a newline instead of splitting the row', () => {
      const csv = toCsv({ name: 'x', headers: ['a'], rows: [['line1\nline2']] });
      expect(csv).toBe('a\r\n"line1\nline2"');
    });

    it('writes CRLF line endings', () => {
      // Excel on Windows is the consumer, and it is the one that cares.
      const csv = toCsv({ name: 'x', headers: ['a'], rows: [['1'], ['2']] });
      expect(csv).toBe('a\r\n1\r\n2');
    });

    it('renders a null as an empty field, not the word null', () => {
      const csv = toCsv({ name: 'x', headers: ['a', 'b'], rows: [[null, 5]] });
      expect(csv.split('\r\n')[1]).toBe(',5');
    });
  });

  describe('the sheet name Excel will accept', () => {
    it('stays within Excel\'s 31-character limit once truncated', () => {
      // recovery-worksheet-job-1002-coil-232054 is 39 chars; the caller slices to 31 before it
      // reaches the writer, and Excel rejects the file outright if a sheet name is longer.
      const name = worksheetTable({
        abJobNum: 1002, coilAbcNum: 232054, customerId: 1, autoparts: false, source: 'das', rows: [],
      }).name;
      expect(name.slice(0, 31).length).toBeLessThanOrEqual(31);
      // …and must not contain any of Excel's forbidden sheet-name characters.
      expect(name.slice(0, 31)).not.toMatch(/[:\\/?*[\]]/);
    });
  });
});
