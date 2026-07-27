import csv
import hashlib
from pathlib import Path
from typing import Dict, List, Tuple

from ..models import FEATURE_COLUMNS


def import_feature_csv(source: Path, existing: List[Dict[str, str]]) -> Tuple[List[Dict[str, str]], List[Dict[str, str]], Dict[str, object]]:
    """Map a contract-compatible CSV without modifying the source file.

    Existing manual-confirmed definitions win on feature_id conflict; all other
    conflicts are rejects rather than silent overwrites.
    """
    with source.open("r", encoding="utf-8", newline="") as handle:
        rows = list(csv.DictReader(handle))
    by_id = {row["feature_id"]: row for row in existing}
    accepted, rejects = [], []
    for number, row in enumerate(rows, 2):
        missing = [column for column in FEATURE_COLUMNS if column not in row]
        if missing:
            rejects.append({"row": str(number), "reason": "missing_columns:" + ",".join(missing), "raw": str(row)}); continue
        current = by_id.get(row["feature_id"])
        if current:
            reason = "conflict_preserved_manual" if current.get("definition_source") == "manual_confirmed" else "conflict_existing_feature_id"
            rejects.append({"row": str(number), "reason": reason, "raw": str(row)}); continue
        accepted.append({column: row.get(column, "") for column in FEATURE_COLUMNS})
    report = {"adapter": "feature_csv", "source": str(source), "source_sha256": hashlib.sha256(source.read_bytes()).hexdigest(), "read": len(rows), "accepted": len(accepted), "rejected": len(rejects), "mapping": "identity feature data contract"}
    return accepted, rejects, report
