#!/usr/bin/env python3
"""Ingest a live Oracle data-dictionary dump into a structured schema model.

Input  : the spool produced by tools/oracle_introspect.sql (default
         docs/data-model/oracle_schema.txt).
Outputs: docs/data-model/oracle_schema.json  (machine-readable, authoritative)
         docs/DATA_MODEL.md                   (regenerated narrative model)

The spool is SQL*Plus output. Sections 1/2/6/7 are one row per physical line;
sections 3/4/5 carry a very wide COLUMN_NAME and so SQL*Plus wraps each logical
row across a FIXED number of physical lines (3 for PK/UK, 5 for FKs, 2 for
indexes). We skip each section's header block, then chunk the remaining data
lines accordingly. Standard library only.
"""
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
DEFAULT_IN = os.path.join(ROOT, "docs", "data-model", "oracle_schema.txt")
OUT_JSON = os.path.join(ROOT, "docs", "data-model", "oracle_schema.json")
OUT_MD = os.path.join(ROOT, "docs", "DATA_MODEL.md")

SECTION_RE = re.compile(r"^=====\s*(\d+)\.\s*(.+?)\s*=====\s*$")
HEADER_TOKENS = {
    "TABLE_NAME", "NUM_ROWS", "LAST_ANAL", "LAST_ANALYZED", "CONSTRAINT_NAME",
    "COLUMN_NAME", "POSITION", "CHILD_TABLE", "CHILD_COLUMN", "PARENT_TABLE",
    "PARENT_COLUMN", "INDEX_NAME", "UNIQUENES", "UNIQUENESS", "COLUMN_POSITION",
    "SEQUENCE_NAME", "MIN_VALUE", "MAX_VALUE", "INCREMENT_BY", "LAST_NUMBER",
    "OWNER", "C", "COL", "DATA_TYPE", "DATA_LENGTH", "DATA_PRECISION",
    "DATA_SCALE", "NULLABLE", "DATA_DEFAULT", "COLUMN_ID",
}


def load(path):
    with open(path, "r", encoding="utf-8", errors="replace") as fh:
        return [ln.replace("\r", "").rstrip("\n") for ln in fh]


def split_sections(lines):
    sections, cur, buf = {}, None, []
    for ln in lines:
        m = SECTION_RE.match(ln)
        if m:
            if cur is not None:
                sections[cur] = buf
            cur, buf = int(m.group(1)), []
        elif cur is not None:
            buf.append(ln)
    if cur is not None:
        sections[cur] = buf
    return sections


def is_dashes(s):
    s = s.strip()
    return bool(s) and set(s) <= {"-", "|", "+"}


def is_footer(s):
    s = s.strip()
    return bool(re.match(r"^\d+\s+rows?\s+selected", s)) or s == "no rows selected"


def is_header_line(s):
    fields = [f.strip() for f in s.split("|") if f.strip()]
    return bool(fields) and any(f in HEADER_TOKENS for f in fields)


def single_line_rows(body, ncols):
    """Sections 1/2/6/7: one row per line; split on '|' into >= ncols fields."""
    rows = []
    for ln in body:
        if not ln.strip() or is_dashes(ln) or is_footer(ln) or is_header_line(ln):
            continue
        parts = [p.strip() for p in ln.split("|")]
        if len(parts) < ncols:
            continue  # continuation of a wrapped LONG default, etc.
        rows.append(parts)
    return rows


def data_lines_after_header(body):
    """Drop the leading header block (blank/dashes/header-token lines), then
    return the data lines (blanks and footer removed)."""
    out, in_data = [], False
    for ln in body:
        s = ln.strip()
        if not in_data:
            if not s or is_dashes(ln) or is_header_line(ln):
                continue
            in_data = True
        if not s or is_dashes(ln) or is_footer(ln):
            continue
        out.append(ln)
    return out


def chunk(seq, n):
    return [seq[i:i + n] for i in range(0, len(seq), n)]


def parse(path):
    sec = split_sections(load(path))
    model = {"owner": "DBO", "source": os.path.basename(path), "tables": {},
             "skipped_non_tables": []}

    # 1. Tables — the authoritative set (all_tables = real tables, not views).
    # Sections 2-5 draw from all_tab_columns/all_constraints/all_indexes, which
    # also cover VIEWS (e.g. Oracle EM SM*_V); attach only to real tables and
    # record anything else so the model stays pinned to the canonical table set.
    canon = set()
    for r in single_line_rows(sec.get(1, []), 1):
        name = r[0]
        canon.add(name)
        model["tables"][name] = {
            "columns": [], "primary_key": [], "unique_keys": {},
            "foreign_keys": [], "indexes": {},
            "num_rows": int(r[1]) if len(r) > 1 and r[1].isdigit() else None,
        }
    skipped = set()

    def T(name):
        if name in model["tables"]:
            return model["tables"][name]
        skipped.add(name)
        return None

    # 2. Columns: table|col_id|name|type|len|prec|scale|nullable|default
    col_start = re.compile(r"^[A-Za-z0-9_$#]+\s*\|\s*\d+\s*\|")
    for ln in sec.get(2, []):
        if not col_start.match(ln) or is_header_line(ln):
            continue
        p = [x.strip() for x in ln.split("|")]
        t = T(p[0])
        if t is None:
            continue
        t["columns"].append({
            "id": int(p[1]), "name": p[2], "type": p[3],
            "length": p[4] or None,
            "precision": p[5] or None if len(p) > 5 else None,
            "scale": p[6] or None if len(p) > 6 else None,
            "nullable": (p[7] == "Y") if len(p) > 7 else None,
            "default": (p[8] if len(p) > 8 and p[8] else None),
        })

    # 3. PK / UK: 3 lines/record -> [table|const|type|], [column], [position]
    for rec in chunk(data_lines_after_header(sec.get(3, [])), 3):
        if len(rec) < 3:
            continue
        head = [x.strip() for x in rec[0].split("|")]
        table, const, ctype = head[0], head[1], head[2]
        col = rec[1].strip()
        t = T(table)
        if t is None:
            continue
        if ctype == "P":
            t["primary_key"].append(col)
        else:
            t["unique_keys"].setdefault(const, []).append(col)

    # 4. FKs: 5 lines/record -> [child|],[child_col],[pos|parent|],[parent_col],[const]
    for rec in chunk(data_lines_after_header(sec.get(4, [])), 5):
        if len(rec) < 5:
            continue
        child = rec[0].split("|")[0].strip()
        child_col = rec[1].strip()
        midp = [x.strip() for x in rec[2].split("|")]
        parent = midp[1] if len(midp) > 1 else ""
        parent_col = rec[3].strip()
        const = rec[4].strip()
        t = T(child)
        if t is None:
            continue
        fk = next((f for f in t["foreign_keys"] if f["constraint"] == const), None)
        if fk is None:
            fk = {"constraint": const, "parent_table": parent,
                  "columns": [], "parent_columns": []}
            t["foreign_keys"].append(fk)
        fk["columns"].append(child_col)
        fk["parent_columns"].append(parent_col)

    # 5. Indexes: 2 lines/record -> [table|index|uniq|pos|], [column]
    for rec in chunk(data_lines_after_header(sec.get(5, [])), 2):
        if len(rec) < 2:
            continue
        head = [x.strip() for x in rec[0].split("|")]
        table, idx, uniq = head[0], head[1], head[2]
        col = rec[1].strip()
        t = T(table)
        if t is None:
            continue
        info = t["indexes"].setdefault(idx, {"unique": uniq == "UNIQUE", "columns": []})
        info["columns"].append(col)

    # 6. Sequences
    model["sequences"] = [
        {"name": r[0], "min": r[1], "max": r[2], "increment": r[3], "last_number": r[4]}
        for r in single_line_rows(sec.get(6, []), 5)
    ]

    # 7. Audit / log tables (all schemas)
    model["log_tables"] = [
        {"owner": r[0], "table": r[1]} for r in single_line_rows(sec.get(7, []), 2)
    ]
    model["skipped_non_tables"] = sorted(skipped)
    return model


def fmt_type(c):
    t = c["type"]
    if t in ("NUMBER",) and c.get("precision"):
        return f"NUMBER({c['precision']},{c['scale'] or 0})"
    if t in ("VARCHAR2", "CHAR", "RAW") and c.get("length"):
        return f"{t}({c['length']})"
    return t


def render_md(model):
    tables = model["tables"]
    names = sorted(tables)
    L = []
    L.append("# ABIS — Data Model (live Oracle schema)")
    L.append("")
    L.append("> **Source of truth.** Regenerated from a live Oracle data-dictionary")
    L.append(f"> dump of the **`{model['owner']}`** schema "
             f"(`{model['source']}`, via `tools/oracle_introspect.sql`) by")
    L.append("> `tools/ingest_oracle_schema.py`. This **supersedes** the earlier partial")
    L.append("> model inferred from ~40 DataWindows. Machine-readable form:")
    L.append("> [`data-model/oracle_schema.json`](data-model/oracle_schema.json).")
    L.append("")
    npk = sum(1 for t in tables.values() if t["primary_key"])
    nfk = sum(len(t["foreign_keys"]) for t in tables.values())
    L.append(f"- **{len(names)}** tables · **{npk}** with a primary key · "
             f"**{nfk}** foreign keys · **{len(model['sequences'])}** sequences")
    L.append("")
    L.append("## Table index")
    L.append("")
    L.append("| Table | Rows | Cols | PK | FKs |")
    L.append("|---|--:|--:|---|--:|")
    for n in names:
        t = tables[n]
        pk = ", ".join(t["primary_key"]) or "—"
        rows = "" if t["num_rows"] is None else f"{t['num_rows']:,}"
        L.append(f"| [`{n}`](#{n.lower()}) | {rows} | {len(t['columns'])} "
                 f"| {pk} | {len(t['foreign_keys'])} |")
    L.append("")
    L.append("## Tables")
    L.append("")
    for n in names:
        t = tables[n]
        L.append(f"### {n}")
        L.append("")
        if t["num_rows"] is not None:
            L.append(f"_~{t['num_rows']:,} rows_")
            L.append("")
        L.append("| # | Column | Type | Null | Default |")
        L.append("|--:|---|---|:--:|---|")
        pkset = set(t["primary_key"])
        for c in sorted(t["columns"], key=lambda x: x["id"]):
            key = " 🔑" if c["name"] in pkset else ""
            nn = "" if c["nullable"] else "NOT NULL"
            dflt = (c["default"] or "").strip()
            dflt = (dflt[:40] + "…") if len(dflt) > 40 else dflt
            L.append(f"| {c['id']} | `{c['name']}`{key} | {fmt_type(c)} | {nn} | {dflt} |")
        L.append("")
        if t["primary_key"]:
            L.append(f"- **PK:** {', '.join('`%s`' % c for c in t['primary_key'])}")
        for const, cols in t["unique_keys"].items():
            L.append(f"- **Unique** ({const}): {', '.join('`%s`' % c for c in cols)}")
        for fk in t["foreign_keys"]:
            cols = ", ".join("`%s`" % c for c in fk["columns"])
            pcols = ", ".join("`%s`" % c for c in fk["parent_columns"])
            L.append(f"- **FK:** ({cols}) → `{fk['parent_table']}` ({pcols})")
        idx = {k: v for k, v in t["indexes"].items() if k not in t["unique_keys"]}
        for name, info in idx.items():
            u = "unique " if info["unique"] else ""
            L.append(f"- **Index** {u}`{name}`: {', '.join('`%s`' % c for c in info['columns'])}")
        L.append("")
    L.append("## Sequences")
    L.append("")
    L.append("| Sequence | Last number |")
    L.append("|---|--:|")
    for s in model["sequences"]:
        L.append(f"| `{s['name']}` | {s['last_number']} |")
    L.append("")
    return "\n".join(L) + "\n"


def main():
    path = sys.argv[1] if len(sys.argv) > 1 else DEFAULT_IN
    model = parse(path)
    os.makedirs(os.path.dirname(OUT_JSON), exist_ok=True)
    with open(OUT_JSON, "w", encoding="utf-8") as fh:
        json.dump(model, fh, indent=2, sort_keys=True)
    with open(OUT_MD, "w", encoding="utf-8") as fh:
        fh.write(render_md(model))
    t = model["tables"]
    print(f"tables={len(t)} sequences={len(model['sequences'])} "
          f"log_tables={len(model['log_tables'])}")
    oi = t.get("ORDER_ITEM", {})
    print("ORDER_ITEM pk =", oi.get("primary_key"))
    print("COIL pk =", t.get("COIL", {}).get("primary_key"))
    print("ORDER_ITEM cols =", len(oi.get("columns", [])))


if __name__ == "__main__":
    main()
