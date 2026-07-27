import csv
import hashlib
from pathlib import Path
from typing import Dict, List, Tuple

from ..models import PERFORMANCE_COLUMNS


def import_performance_csv(source: Path) -> Tuple[List[Dict[str, str]], List[Dict[str, str]], Dict[str, object]]:
    with source.open("r", encoding="utf-8", newline="") as handle: rows = list(csv.DictReader(handle))
    accepted, rejects = [], []
    for number, row in enumerate(rows, 2):
        missing = [column for column in PERFORMANCE_COLUMNS if column not in row]
        if missing: rejects.append({"row": str(number), "reason": "missing_columns:" + ",".join(missing), "raw": str(row)})
        else: accepted.append({column: row.get(column, "") for column in PERFORMANCE_COLUMNS})
    return accepted, rejects, {"adapter": "performance_csv", "source": str(source), "source_sha256": hashlib.sha256(source.read_bytes()).hexdigest(), "read": len(rows), "accepted": len(accepted), "rejected": len(rejects), "mapping": "identity performance data contract"}
