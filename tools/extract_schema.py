#!/usr/bin/env python3
"""Extract a partial database data model from PowerBuilder DataWindow sources.

ABIS stores most of its logic in compiled, binary ``.pbl`` libraries that cannot
be parsed here. However, the repository also contains exported DataWindow
(``.srd``) and query (``.srq``) sources in PowerBuilder's text export format.
Each of those embeds the columns it reads, qualified as ``table.column`` with a
declared type, and (for graphical "PBSELECT" queries) the joins between tables.

This script parses every ``.srd``/``.srq`` file and emits:

  * ``docs/data-model/schema.json`` -- machine-readable tables, columns, types,
    relationships, and provenance (which source files referenced each item).
  * a short text summary on stdout.

It makes no database connection and invents nothing: every table, column, type,
and relationship below was read directly out of a DataWindow definition. The
model is therefore *partial* -- it only covers what the exported DataWindows
touch, not the full ABIS database.

Usage:
    python3 tools/extract_schema.py [repo_root]
"""
from __future__ import annotations

import json
import re
import sys
from collections import defaultdict
from pathlib import Path

# column=(type=char(22) updatewhereclause=yes name=foo dbname="order_item.foo" ...)
# The type token may carry a size, e.g. char(22) / decimal(5); name is the
# DataWindow alias; dbname is the underlying "table.column" (or a bare
# expression/alias when the column is computed).
COLUMN_RE = re.compile(
    r'column=\(type=([a-z]+(?:\([0-9]+\))?)'   # 1: db type
    r'[^\n]*?\bname=([A-Za-z0-9_]+)'           # 2: dw column alias
    r'[^\n]*?\bdbname="([^"]+)"',              # 3: table.column (or expression)
)

# PBSELECT graphical-query join, e.g.
#   JOIN (LEFT="a.x" OP ="="RIGHT="b.y" )
JOIN_RE = re.compile(
    r'LEFT="([^"]+)"\s*OP\s*="[^"]*"\s*RIGHT="([^"]+)"'
)

# Tables named in a PBSELECT query: TABLE(NAME="customer_order" )
PBSELECT_TABLE_RE = re.compile(r'TABLE\(\s*NAME="([^"]+)"')


def split_dbname(dbname: str) -> tuple[str | None, str]:
    """Return (table, column) for a qualified dbname, else (None, expression)."""
    # Only treat simple ``identifier.identifier`` as a real table.column. Bare
    # names and expressions (e.g. "trimming_required", "getrow()") are computed.
    m = re.fullmatch(r'([A-Za-z0-9_]+)\.([A-Za-z0-9_]+)', dbname)
    if m:
        return m.group(1), m.group(2)
    return None, dbname


def main() -> int:
    root = Path(sys.argv[1] if len(sys.argv) > 1 else ".").resolve()

    # table -> column -> {types seen, sources}
    tables: dict[str, dict[str, dict]] = defaultdict(lambda: defaultdict(
        lambda: {"types": set(), "sources": set()}))
    # set of (table_a, col_a, table_b, col_b) join edges
    relationships: set[tuple[str, str, str, str]] = set()
    # table -> set of source files that query it (via PBSELECT)
    table_sources: dict[str, set[str]] = defaultdict(set)
    computed_only: set[str] = set()

    srcs = sorted(root.glob("*.srd")) + sorted(root.glob("*.srq"))
    for path in srcs:
        text = path.read_text(errors="replace")
        rel = path.name

        for db_type, _alias, dbname in COLUMN_RE.findall(text):
            table, column = split_dbname(dbname)
            if table is None:
                computed_only.add(column)
                continue
            entry = tables[table][column]
            entry["types"].add(db_type)
            entry["sources"].add(rel)

        for left, right in JOIN_RE.findall(text):
            lt, _ = split_dbname(left)
            rt, _ = split_dbname(right)
            if lt and rt:
                lc = left.split(".", 1)[1]
                rc = right.split(".", 1)[1]
                # store a canonical (sorted) edge so a<->b == b<->a
                edge = tuple(sorted([(lt, lc), (rt, rc)]))
                relationships.add((edge[0][0], edge[0][1], edge[1][0], edge[1][1]))

        for tname in PBSELECT_TABLE_RE.findall(text):
            table_sources[tname.lower()].add(rel)

    # ---- serialize -------------------------------------------------------
    out_tables = {}
    for tname in sorted(tables):
        cols = {}
        for cname in sorted(tables[tname]):
            e = tables[tname][cname]
            cols[cname] = {
                "types": sorted(e["types"]),
                "source_count": len(e["sources"]),
                "sources": sorted(e["sources"]),
            }
        out_tables[tname] = {
            "column_count": len(cols),
            "columns": cols,
            "queried_by": sorted(table_sources.get(tname, [])),
        }

    out_rels = [
        {"from_table": a, "from_column": b, "to_table": c, "to_column": d}
        for (a, b, c, d) in sorted(relationships)
    ]

    # Inferred relationships: the same column name appearing in 2+ tables is a
    # strong hint of a foreign-key link in a legacy schema (e.g. ab_job_num,
    # coil_abc_num). This is a HEURISTIC, not authoritative -- presented to guide
    # manual schema reconstruction, not to be trusted blindly.
    col_to_tables: dict[str, set[str]] = defaultdict(set)
    for tname, cols in tables.items():
        for cname in cols:
            col_to_tables[cname].add(tname)
    shared_columns = {
        cname: sorted(tabs)
        for cname, tabs in sorted(col_to_tables.items())
        if len(tabs) > 1
    }

    result = {
        "_meta": {
            "generated_by": "tools/extract_schema.py",
            "source_files_parsed": len(srcs),
            "note": (
                "Partial model recovered from exported DataWindow/query sources "
                "only. Not a live database introspection."
            ),
        },
        "table_count": len(out_tables),
        "relationship_count": len(out_rels),
        "tables": out_tables,
        "relationships": out_rels,
        "inferred_relationships_by_shared_column": shared_columns,
        "computed_or_unqualified_columns": sorted(computed_only),
    }

    out_dir = root / "docs" / "data-model"
    out_dir.mkdir(parents=True, exist_ok=True)
    (out_dir / "schema.json").write_text(json.dumps(result, indent=2) + "\n")

    print(f"Parsed {len(srcs)} DataWindow/query source files")
    print(f"Tables: {len(out_tables)}   Columns: "
          f"{sum(t['column_count'] for t in out_tables.values())}   "
          f"Relationships: {len(out_rels)}")
    print(f"Wrote {out_dir / 'schema.json'}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
