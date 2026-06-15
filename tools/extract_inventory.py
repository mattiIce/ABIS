#!/usr/bin/env python3
"""Recover an approximate object inventory from compiled PowerBuilder libraries.

The ``.pbl`` files in this repo are compiled binaries; their PowerScript source
cannot be read here. They do, however, contain the *names* of the objects they
define and reference. This script runs the equivalent of ``strings`` over each
library and harvests tokens that follow PowerBuilder's Hungarian naming
conventions, grouping them by object type.

This is deliberately conservative -- it only keeps all-lowercase tokens that
start with a known prefix, which filters out most binary noise. Because the
compiled format does not cleanly separate "defined here" from "referenced from
another library", per-library counts should be read as "names appearing in this
library", and the de-duplicated global list as the application's object set.

Outputs:
  * ``docs/inventory/objects.json`` -- per-library and global object names.
  * a summary table on stdout.

Usage:
    python3 tools/extract_inventory.py [repo_root]
"""
from __future__ import annotations

import json
import re
import string
import sys
from collections import defaultdict
from pathlib import Path

# PowerBuilder naming conventions -> object kind.
PREFIXES = {
    "w_": "window",
    "m_": "menu",
    "d_": "datawindow",
    "n_": "class_nvo",       # non-visual user object
    "nvo_": "class_nvo",
    "u_": "userobject",      # visual user object / control
    "s_": "structure",
    "f_": "global_function",
}
# Framework objects (PowerBuilder Foundation Classes) are tracked separately so
# they don't drown out application-specific objects.
FRAMEWORK_PREFIXES = ("pfc_", "pfe_")

TOKEN_RE = re.compile(rb"[A-Za-z_][A-Za-z0-9_]{2,48}")
PRINTABLE = set(bytes(string.printable, "ascii"))


def iter_ascii_strings(data: bytes, min_len: int = 4):
    """Yield printable single-byte (ANSI/ASCII) runs, like classic `strings`.

    This finds names in the older, pre-migration ANSI ``.pbl`` files.
    """
    run = bytearray()
    for byte in data:
        if byte in PRINTABLE and byte not in b"\t\n\r\x0b\x0c":
            run.append(byte)
        else:
            if len(run) >= min_len:
                yield bytes(run)
            run.clear()
    if len(run) >= min_len:
        yield bytes(run)


def iter_utf16le_strings(data: bytes, min_len: int = 4):
    """Yield printable UTF-16LE runs (each char as ``<byte>\\x00``).

    The 2025 PowerBuilder migration converted the live libraries to Unicode,
    so their object names are stored as UTF-16LE and are invisible to a plain
    ASCII scan. We walk the buffer advancing by 2 while a ``printable, 0x00``
    pair continues, and by 1 otherwise so we can re-acquire 2-byte alignment.
    """
    run = bytearray()
    i, n = 0, len(data) - 1
    while i < n:
        lo, hi = data[i], data[i + 1]
        if hi == 0 and lo in PRINTABLE and lo not in b"\t\n\r\x0b\x0c":
            run.append(lo)
            i += 2
        else:
            if len(run) >= min_len:
                yield bytes(run)
            run.clear()
            i += 1
    if len(run) >= min_len:
        yield bytes(run)


def iter_strings(data: bytes, min_len: int = 4):
    """Yield candidate name strings from both ANSI and UTF-16LE encodings."""
    yield from iter_ascii_strings(data, min_len)
    yield from iter_utf16le_strings(data, min_len)


def classify(token: str) -> tuple[str, str] | None:
    """Return (scope, kind) where scope is 'app' or 'framework', else None."""
    if token != token.lower():
        return None  # PB object names are lowercase; uppercase = binary noise
    for fp in FRAMEWORK_PREFIXES:
        if token.startswith(fp):
            # framework objects still carry a w_/n_/u_/etc kind after the prefix
            return "framework", "framework"
    for pfx, kind in PREFIXES.items():
        if token.startswith(pfx) and len(token) > len(pfx) + 1:
            return "app", kind
    return None


def collapse_fragments(names: set[str]) -> set[str]:
    """Drop names that are a strict prefix of a longer recovered name.

    String-scanning a binary recovers truncated reads of the same object as a
    prefix ladder (``m_appli`` -> ``m_applic`` -> ... -> ``m_applicationtopics``),
    which badly over-counts. Keeping only the maximal strings removes most of
    that noise. This can slightly under-count genuinely distinct names where one
    is a prefix of another (``m_close`` vs ``m_closeall``); that error is far
    smaller than the fragmentation it removes, so counts remain *approximate*.
    """
    ordered = sorted(names)
    keep: set[str] = set()
    for i, name in enumerate(ordered):
        nxt = ordered[i + 1] if i + 1 < len(ordered) else ""
        if nxt.startswith(name):
            continue  # 'name' is a prefix of the next (longer) string -> fragment
        keep.add(name)
    return keep


def main() -> int:
    root = Path(sys.argv[1] if len(sys.argv) > 1 else ".").resolve()
    pbls = sorted(root.glob("*.pbl"))

    per_lib: dict[str, dict[str, set]] = {}
    global_objs: dict[str, set] = defaultdict(set)        # kind -> names (app)
    framework_names: set[str] = set()

    for pbl in pbls:
        data = pbl.read_bytes()
        lib_kinds: dict[str, set] = defaultdict(set)
        for s in iter_strings(data):
            for m in TOKEN_RE.findall(s):
                token = m.decode("ascii")
                res = classify(token)
                if not res:
                    continue
                scope, kind = res
                if scope == "framework":
                    framework_names.add(token)
                else:
                    lib_kinds[kind].add(token)
        per_lib[pbl.name] = lib_kinds

    # Collapse fragmentation noise, then rebuild the global de-duplicated sets
    # from the cleaned per-library results.
    for name in per_lib:
        for kind in list(per_lib[name]):
            cleaned = collapse_fragments(per_lib[name][kind])
            per_lib[name][kind] = cleaned
            global_objs[kind] |= cleaned
    framework_names = collapse_fragments(framework_names)

    # ---- serialize -------------------------------------------------------
    libraries = {}
    for name in sorted(per_lib):
        kinds = per_lib[name]
        libraries[name] = {
            "size_bytes": (root / name).stat().st_size,
            "counts": {k: len(v) for k, v in sorted(kinds.items())},
            "total": sum(len(v) for v in kinds.values()),
        }

    global_summary = {k: sorted(v) for k, v in sorted(global_objs.items())}
    global_counts = {k: len(v) for k, v in sorted(global_objs.items())}

    result = {
        "_meta": {
            "generated_by": "tools/extract_inventory.py",
            "libraries_scanned": len(pbls),
            "note": (
                "Approximate. Object NAMES recovered from compiled binaries via "
                "string scanning; PowerScript bodies are not recoverable here. "
                "Per-library counts include referenced (not only defined) names."
            ),
            "reliable_kinds": ["datawindow", "window", "class_nvo",
                               "userobject", "global_function"],
            "unreliable_kinds_note": (
                "'menu' and 'structure' are NOT reliable object counts: the m_ "
                "prefix conflates menu objects with their menu items, and both "
                "m_/s_ are short prefixes prone to false positives. Reported for "
                "transparency only."
            ),
        },
        "global_counts": global_counts,
        "framework_object_count": len(framework_names),
        "libraries": libraries,
        "global_objects": global_summary,
    }

    out_dir = root / "docs" / "inventory"
    out_dir.mkdir(parents=True, exist_ok=True)
    (out_dir / "objects.json").write_text(json.dumps(result, indent=2) + "\n")

    print(f"Scanned {len(pbls)} libraries")
    for kind, n in global_counts.items():
        print(f"  {kind:16s} {n}")
    print(f"  {'(framework)':16s} {len(framework_names)}")
    print(f"Wrote {out_dir / 'objects.json'}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
