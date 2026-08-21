// Shaping the PM list for export — the modern `d_report_pm_list`.
//
// WHAT LEGACY'S REPORT ACTUALLY WAS (decoded from the .srd, 2026-08-21):
//
//   SELECT pm.pm_id, groupdepartment.groupdepartment, systemequipment.systemequipment,
//          subsystemequipment.subsystemequipment, itemdevice.itemdevice, pm.maint_freq
//     FROM pm
//     LEFT OUTER JOIN groupdepartment    ON groupdepartment.groupdepartment_id = pm.groupdepartment_id
//     LEFT OUTER JOIN subsystemequipment ON subsystemequipment.subsysequipment_id = pm.subsysequipment_id
//     LEFT OUTER JOIN itemdevice         ON itemdevice.itemdevice_id = pm.itemdevice_id
//     LEFT OUTER JOIN systemequipment    ON systemequipment.sysequipment_id = pm.sysequipment_id
//    ORDER BY pm.pm_id
//
// Six columns, and every join is a LEFT OUTER — a PM appears even when its hierarchy is missing. That
// is not incidental: 5 of 726 imported subsystems have no parent, so an inner join would silently drop
// PMs from a report whose whole job is to list all of them. The blanks below preserve that.
//
// THE OTHER TWO LEGACY MAINTENANCE REPORTS ARE NOT PORTED, DELIBERATELY.
// `d_report_parts_details` and `d_report_parts_full_list` read `parts` / `parts_categories` /
// `suppliers` — the maintenance SPARES tables, whose 762 rows all carry `parts_entered_date`
// 2010-08-21, no order or receive dates, and zero stock. A dead one-shot load; the plant's live spares
// are in KeepTrak. Building them would produce two empty reports that look broken.
//
// Columns beyond the legacy six are added because a spreadsheet is not a printed page and the reader
// can hide what they do not want — but the legacy six come FIRST and in legacy's order, so somebody
// comparing against the old report finds what they expect.

/** A cell as the xlsx writer wants it: numbers stay numeric, text is text, blank is null. */
export type Cell = number | string | null;

export interface ExportTable {
  name: string;
  headers: string[];
  rows: Cell[][];
}

interface PmLike {
  pmId?: number;
  groupDepartmentName?: string;
  systemEquipment?: string;
  subsystemEquipment?: string;
  itemDevice?: string;
  maintFreq?: string;
  pmNotice?: string;
  nextDueDate?: Date | string;
  pmStatus?: number;
  assignedToGroup?: string;
  titleCraft?: string;
  daysBetween?: number;
}

const t = (v: string | undefined): Cell => {
  const s = (v ?? '').trim();
  return s.length === 0 ? null : s;
};

/**
 * A date as `YYYY-MM-DD`, which sorts correctly as text and does not depend on the reader's locale.
 * The time is dropped because `nextduedate` is a date in the schema — showing 00:00:00 would imply a
 * precision the data does not have.
 */
export function dateOnly(v: Date | string | undefined): Cell {
  if (v == null) return null;
  const d = v instanceof Date ? v : new Date(v);
  if (Number.isNaN(d.getTime())) return null;
  const p = (n: number) => String(n).padStart(2, '0');
  return `${d.getFullYear()}-${p(d.getMonth() + 1)}-${p(d.getDate())}`;
}

/**
 * `pm_status` 0 means retired. Exported as a word rather than the code: a spreadsheet has no legend,
 * and "0" in a Status column reads as a count.
 */
export function statusWord(v: number | undefined): Cell {
  if (v == null) return null;
  return v === 0 ? 'retired' : 'active';
}

/** Where a PM's rows came from — KeepTrak import or the pre-2010 ABIS data. */
export function origin(pmId: number | undefined): Cell {
  if (pmId == null) return null;
  return pmId >= 100000 ? 'KeepTrak' : 'legacy';
}

export function pmListTable(rows: PmLike[]): ExportTable {
  return {
    name: 'maintenance-pm-list',
    headers: [
      // the legacy six, in legacy's order
      'PM#', 'Department', 'System', 'Subsystem', 'Item / device', 'Frequency',
      // and what a spreadsheet can carry that a printed page could not
      'What', 'Next due', 'Days between', 'Status', 'Assigned to', 'Craft', 'Origin',
    ],
    rows: rows.map((p) => [
      p.pmId ?? null,
      t(p.groupDepartmentName),
      t(p.systemEquipment),
      t(p.subsystemEquipment),
      t(p.itemDevice),
      t(p.maintFreq),
      t(p.pmNotice),
      dateOnly(p.nextDueDate),
      p.daysBetween ?? null,
      statusWord(p.pmStatus),
      t(p.assignedToGroup),
      t(p.titleCraft),
      origin(p.pmId),
    ]),
  };
}

/** CSV for a table. CRLF and minimal quoting — Excel on Windows is the consumer. */
export function toCsv(table: ExportTable): string {
  const cell = (v: Cell): string => {
    if (v == null) return '';
    const s = String(v);
    return /[",\r\n]/.test(s) ? `"${s.replace(/"/g, '""')}"` : s;
  };
  return [table.headers.map(cell).join(','), ...table.rows.map((r) => r.map(cell).join(','))].join('\r\n');
}
