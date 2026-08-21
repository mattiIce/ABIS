import { describe, expect, it } from 'vitest';
import { dateOnly, origin, pmListTable, statusWord, toCsv } from '../src/maintenance-export.js';

/**
 * The PM list export — the modern `d_report_pm_list`.
 *
 * Legacy's report was six columns over five LEFT OUTER joins, ordered by pm_id. The outer joins matter:
 * 5 of 726 imported subsystems have no parent, so an inner join would silently drop PMs from a report
 * whose entire job is to list all of them.
 */
describe('PM list export', () => {
  const pm = {
    pmId: 100054, groupDepartmentName: 'Production Line', systemEquipment: 'BL 110',
    subsystemEquipment: 'PM', itemDevice: 'Complete Line', maintFreq: '1XY',
    pmNotice: 'Lifting Chain Inspection', pmStatus: 1, assignedToGroup: 'Maintenance Staff',
    titleCraft: 'Maintenance Technician', daysBetween: 365,
  };

  it('leads with the legacy six columns, in legacy order', () => {
    // Somebody comparing against the old printed report should find what they expect first.
    expect(pmListTable([]).headers.slice(0, 6))
      .toEqual(['PM#', 'Department', 'System', 'Subsystem', 'Item / device', 'Frequency']);
  });

  it('keeps the PM id numeric', () => {
    const tb = pmListTable([pm]);
    expect(tb.rows[0][0]).toBe(100054);
  });

  it('renders a PM with no hierarchy as blanks rather than dropping it', () => {
    // This is the LEFT OUTER JOIN, preserved. An orphaned PM must still appear.
    const tb = pmListTable([{ pmId: 7, maintFreq: '1XW' }]);
    expect(tb.rows).toHaveLength(1);
    expect(tb.rows[0][0]).toBe(7);
    for (const i of [1, 2, 3, 4]) expect(tb.rows[0][i]).toBeNull();
    expect(tb.rows[0][5]).toBe('1XW');
  });

  it('treats whitespace-only equipment names as blank', () => {
    // Oracle CHAR columns pad with spaces, so "empty" arrives as whitespace rather than ''.
    const tb = pmListTable([{ ...pm, subsystemEquipment: '   ' }]);
    expect(tb.rows[0][3]).toBeNull();
  });

  describe('status', () => {
    it('exports a word, not the raw code', () => {
      // "0" in a Status column reads as a count; a spreadsheet has no legend to explain it.
      expect(statusWord(0)).toBe('retired');
      expect(statusWord(1)).toBe('active');
      expect(statusWord(2)).toBe('active');
    });

    it('is blank when unknown rather than guessing', () => {
      expect(statusWord(undefined)).toBeNull();
    });
  });

  describe('origin', () => {
    it('separates imported PMs from the pre-2010 ABIS ones', () => {
      // 221 PMs live side by side and mean very different things; the id offset is what tells them
      // apart, and a reader of the file has no other way to know.
      expect(origin(100054)).toBe('KeepTrak');
      expect(origin(29)).toBe('legacy');
    });

    it('uses the same 100000 boundary the import reserves', () => {
      expect(origin(99999)).toBe('legacy');
      expect(origin(100000)).toBe('KeepTrak');
    });
  });

  describe('dates', () => {
    it('exports YYYY-MM-DD, which sorts as text and is locale-independent', () => {
      expect(dateOnly(new Date(2026, 7, 21))).toBe('2026-08-21');
    });

    it('drops the time, because nextduedate is a date in the schema', () => {
      expect(dateOnly(new Date(2026, 7, 21, 14, 30))).toBe('2026-08-21');
    });

    it('is blank for a missing or unparseable date rather than "Invalid Date"', () => {
      expect(dateOnly(undefined)).toBeNull();
      expect(dateOnly('not a date')).toBeNull();
    });
  });

  describe('CSV', () => {
    it('quotes a value containing a comma', () => {
      const csv = toCsv(pmListTable([{ ...pm, pmNotice: 'Grease, then inspect' }]));
      expect(csv).toContain('"Grease, then inspect"');
    });

    it('quotes a multi-line note instead of splitting the row', () => {
      // PM notices are memo text in KeepTrak and genuinely contain newlines.
      const csv = toCsv(pmListTable([{ ...pm, pmNotice: 'line1\nline2' }]));
      expect(csv).toContain('"line1\nline2"');
      expect(csv.split('\r\n')).toHaveLength(2);   // header + one record, despite the embedded newline
    });

    it('renders a blank as an empty field, not the word null', () => {
      const csv = toCsv(pmListTable([{ pmId: 7 }]));
      expect(csv.split('\r\n')[1].startsWith('7,,,,,')).toBe(true);
    });
  });
});
