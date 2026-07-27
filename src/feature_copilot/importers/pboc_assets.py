import csv
import hashlib
from pathlib import Path
from typing import Dict, List, Tuple


def import_pboc_assets(source: Path) -> Tuple[List[Dict[str, str]], List[Dict[str, str]], Dict[str, object]]:
    """Read a PBOC field dictionary as evidence candidates, not feature definitions."""
    with source.open("r", encoding="utf-8", newline="") as handle: rows = list(csv.DictReader(handle))
    accepted, rejects = [], []
    for number, row in enumerate(rows, 2):
        field = row.get("field_name") or row.get("字段名")
        if not field: rejects.append({"row": str(number), "reason": "missing_field_name", "raw": str(row)})
        else: accepted.append({"pboc_field": field, "description": row.get("description") or row.get("说明", ""), "source_row": str(number)})
    return accepted, rejects, {"adapter": "pboc_assets", "source": str(source), "source_sha256": hashlib.sha256(source.read_bytes()).hexdigest(), "read": len(rows), "accepted": len(accepted), "rejected": len(rejects), "mapping": "field dictionary -> evidence candidates; no inferred feature definition"}
