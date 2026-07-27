#!/usr/bin/env python3
"""Export downloaded DP task JSON snapshots to self-contained table SQL files."""

import argparse
import hashlib
import json
from pathlib import Path
from typing import Dict, Iterable, List, Tuple


ROOT = Path(__file__).resolve().parents[1]
DP_ROOT = ROOT / "goal" / "dp_table_logic"
MARKER_PREFIX = "-- feature-copilot:"
UNAVAILABLE_MARKER = MARKER_PREFIX + "logic-unavailable"
SNAPSHOT_DIRECTORIES = (
    Path("."),
    Path("pdm_risk_upstream"),
    Path("dwa_risk_upstream"),
    Path("dwa_risk_first_upstream"),
    Path("dwa_risk_internal_upstream"),
)


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _snapshot_sources(dp_root: Path) -> Iterable[Tuple[Path, Path]]:
    for relative_directory in SNAPSHOT_DIRECTORIES:
        directory = dp_root / relative_directory
        if not directory.is_dir():
            raise ValueError("missing snapshot directory: " + str(directory))
        for json_path in sorted(directory.glob("*.json")):
            if json_path.name != "summary.json":
                yield directory, json_path


def _render_sql(table_name: str, json_path: Path, payload: Dict[str, object]) -> str:
    nodes = payload.get("data", [])
    if not isinstance(nodes, list):
        nodes = [nodes]
    if not nodes:
        raise ValueError("snapshot has no task nodes: " + str(json_path))
    source_hash = _sha256(json_path)
    if not any(isinstance(node, dict) and str(node.get("sql", "")).strip() for node in nodes):
        return "\n".join([
            UNAVAILABLE_MARKER,
            "-- table_name: " + table_name,
            "-- source_json: " + str(json_path.relative_to(ROOT)),
            "-- source_json_sha256: " + source_hash,
            "-- reason: snapshot contains no SQL task node",
            "",
        ])
    sections: List[str] = []
    for ordinal, node in enumerate(nodes):
        if not isinstance(node, dict) or not str(node.get("sql", "")).strip():
            raise ValueError("snapshot node has no SQL: " + str(json_path) + "#" + str(ordinal))
        upstreams = node.get("upstreamTables", []) or []
        if not isinstance(upstreams, list):
            raise ValueError("snapshot upstreamTables is not a list: " + str(json_path) + "#" + str(ordinal))
        header = [
            MARKER_PREFIX + "node-begin ordinal=" + str(ordinal),
            "-- table_name: " + table_name,
            "-- node_id: " + str(node.get("nodeId", "")),
            "-- task_name: " + str(node.get("taskName", "")),
            "-- owner_name: " + str(node.get("ownerName", "")),
            "-- source_json: " + str(json_path.relative_to(ROOT)),
            "-- source_json_sha256: " + source_hash,
        ]
        header.extend("-- upstream_table: " + str(upstream) for upstream in upstreams)
        sql = str(node["sql"]).rstrip()
        sections.append("\n".join(header) + "\n\n" + sql + "\n" + MARKER_PREFIX + "node-end ordinal=" + str(ordinal))
    return "\n\n".join(sections) + "\n"


def export_sql(dp_root: Path = DP_ROOT, check: bool = False) -> Dict[str, int]:
    written = unchanged = 0
    sources = list(_snapshot_sources(dp_root))
    if not sources:
        raise ValueError("no downloaded DP JSON snapshots found; the runtime catalog reads SQL directly")
    for directory, json_path in sources:
        table_name = json_path.stem
        sql_path = directory / (table_name + ".sql")
        payload = json.loads(json_path.read_text(encoding="utf-8"))
        rendered = _render_sql(table_name, json_path, payload)
        existing = sql_path.read_text(encoding="utf-8") if sql_path.exists() else None
        if existing == rendered:
            unchanged += 1
        elif check:
            raise ValueError("SQL export is missing or stale: " + str(sql_path.relative_to(ROOT)))
        else:
            sql_path.write_text(rendered, encoding="utf-8")
            written += 1
    return {"written": written, "unchanged": unchanged, "total": written + unchanged}


def main() -> int:
    parser = argparse.ArgumentParser(description="Export DP JSON task snapshots to table-named SQL files")
    parser.add_argument("--check", action="store_true", help="fail when a SQL export is missing or stale; requires downloaded JSON snapshots")
    args = parser.parse_args()
    result = export_sql(check=args.check)
    print(json.dumps(result, ensure_ascii=False, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
