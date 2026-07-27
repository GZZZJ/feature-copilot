import csv
import datetime as dt
from pathlib import Path
from typing import Dict, Iterable, List, Set, Tuple

from .models import (AVAILABILITY_COLUMNS, ENUMS, FEATURE_COLUMNS,
                     PERFORMANCE_COLUMNS, TABLE_COLUMNS, Finding)


FILE_COLUMNS = {"features.csv": FEATURE_COLUMNS, "tables.csv": TABLE_COLUMNS,
                "performance.csv": PERFORMANCE_COLUMNS, "availability.csv": AVAILABILITY_COLUMNS}


def load_csv(path: Path) -> List[Dict[str, str]]:
    with path.open("r", encoding="utf-8", newline="") as handle:
        return list(csv.DictReader(handle))


def _iso(value: str) -> bool:
    if not value:
        return True
    try:
        dt.datetime.fromisoformat(value.replace("Z", "+00:00"))
        return True
    except ValueError:
        try:
            dt.date.fromisoformat(value)
            return True
        except ValueError:
            return False


def _duplicates(rows: Iterable[Dict[str, str]], keys: Tuple[str, ...]) -> Set[Tuple[str, ...]]:
    seen, duplicates = set(), set()
    for row in rows:
        key = tuple(row.get(field, "") for field in keys)
        if key in seen:
            duplicates.add(key)
        seen.add(key)
    return duplicates


def validate_knowledge(knowledge_dir: Path, project_root: Path) -> List[Finding]:
    findings: List[Finding] = []
    data: Dict[str, List[Dict[str, str]]] = {}
    for filename, columns in FILE_COLUMNS.items():
        path = knowledge_dir / filename
        if not path.exists():
            findings.append(Finding("ERROR", "MISSING_FILE", f"missing {filename}", filename)); continue
        try:
            rows = load_csv(path)
            data[filename] = rows
            headers = set(rows[0].keys()) if rows else set()
            for column in columns:
                if column not in headers:
                    findings.append(Finding("ERROR", "MISSING_COLUMN", f"missing column {column}", filename))
            for row_num, row in enumerate(rows, 2):
                for column in columns:
                    if column not in row or row[column] is None:
                        findings.append(Finding("ERROR", "MISSING_VALUE", f"missing value for {column}", filename, row_num))
        except (OSError, csv.Error) as error:
            findings.append(Finding("ERROR", "CSV_READ", str(error), filename))
    if any(item.severity == "ERROR" for item in findings):
        return findings
    features, tables = data["features.csv"], data["tables.csv"]
    nonempty = {
        "features.csv": ("feature_id", "feature_name", "source_table", "status", "version", "synced_at", "definition_source", "definition_confidence"),
        "tables.csv": ("table_id", "table_name", "status", "synced_at"),
        "performance.csv": ("record_id", "feature_id", "feature_name", "project", "eval_date"),
        "availability.csv": ("record_id", "feature_id", "feature_name", "scene", "population", "observation_timing", "availability_status", "updated_at"),
    }
    for filename, columns in nonempty.items():
        for row_num, row in enumerate(data[filename], 2):
            for column in columns:
                if not (row.get(column) or "").strip():
                    findings.append(Finding("ERROR", "REQUIRED_EMPTY", f"required field {column} is empty", filename, row_num))
    for filename, rows, key in (("features.csv", features, ("feature_id",)), ("tables.csv", tables, ("table_id",)),
                                ("performance.csv", data["performance.csv"], ("record_id",)),
                                ("availability.csv", data["availability.csv"], ("record_id",))):
        for duplicate in _duplicates(rows, key):
            findings.append(Finding("ERROR", "DUPLICATE_KEY", f"duplicate {key}: {duplicate}", filename))
    for duplicate in _duplicates(features, ("feature_name", "version")):
        findings.append(Finding("ERROR", "DUPLICATE_FEATURE_VERSION", f"duplicate feature/version: {duplicate}", "features.csv"))
    table_names = {row["table_name"] for row in tables}
    feature_ids = {row["feature_id"] for row in features}
    for row_num, row in enumerate(features, 2):
        for field in ("status", "definition_source", "definition_confidence"):
            if row[field] not in ENUMS[field]: findings.append(Finding("ERROR", "INVALID_ENUM", f"invalid {field}", "features.csv", row_num))
        if not _iso(row["synced_at"]): findings.append(Finding("ERROR", "INVALID_DATE", "invalid synced_at", "features.csv", row_num))
        if row["source_table"] not in table_names: findings.append(Finding("ERROR", "UNKNOWN_SOURCE_TABLE", "source_table does not exist", "features.csv", row_num))
        if "|" in row["feature_name"]: findings.append(Finding("ERROR", "INVALID_MULTIVALUE", "feature_name cannot contain |", "features.csv", row_num))
        source, confidence = row["definition_source"], row["definition_confidence"]
        if source == "name_inference" and confidence != "unverified": findings.append(Finding("ERROR", "INFERENCE_AS_OFFICIAL", "name inference must be unverified", "features.csv", row_num))
        if source != "name_inference" and (confidence not in {"verified", "reviewed"} or not row["technical_definition"] or not (row["logic_ref"] or source == "manual_confirmed")):
            findings.append(Finding("ERROR", "FORMAL_DEFINITION_EVIDENCE", "formal definition lacks evidence", "features.csv", row_num))
        if row["logic_ref"]:
            candidate = (project_root / row["logic_ref"]).resolve()
            try: candidate.relative_to(project_root.resolve()); contained = True
            except ValueError: contained = False
            if not contained or not candidate.is_file(): findings.append(Finding("ERROR", "MISSING_LOGIC_REF", "logic_ref must be an existing repository-relative file", "features.csv", row_num))
    for row_num, row in enumerate(tables, 2):
        if row["status"] not in ENUMS["status"]: findings.append(Finding("ERROR", "INVALID_ENUM", "invalid table status", "tables.csv", row_num))
        if not _iso(row["synced_at"]): findings.append(Finding("ERROR", "INVALID_DATE", "invalid synced_at", "tables.csv", row_num))
        if row["logic_ref"]:
            candidate = (project_root / row["logic_ref"]).resolve()
            try: candidate.relative_to(project_root.resolve()); contained = True
            except ValueError: contained = False
            if not contained or not candidate.is_file(): findings.append(Finding("ERROR", "MISSING_LOGIC_REF", "logic_ref must be an existing repository-relative file", "tables.csv", row_num))
    table_status = {r["table_name"]: r["status"] for r in tables}
    active_by_name: Dict[str, List[Dict[str, str]]] = {}
    for row in features:
        if row["status"] == "active": active_by_name.setdefault(row["feature_name"].casefold(), []).append(row)
    for name, rows in active_by_name.items():
        if len(rows) > 1:
            findings.append(Finding("ERROR", "CURRENT_VERSION_CONFLICT", f"multiple active versions for {name}", "features.csv"))
    for row in features:
        if row["status"] == "active" and table_status.get(row["source_table"]) == "deprecated": findings.append(Finding("ERROR", "ACTIVE_ON_RETIRED_TABLE", "active feature points to retired table", "features.csv"))
    for filename in ("performance.csv", "availability.csv"):
        for row_num, row in enumerate(data[filename], 2):
            if row["feature_id"] not in feature_ids: findings.append(Finding("ERROR", "UNKNOWN_FEATURE", "record cannot link feature", filename, row_num))
            date_field = "eval_date" if filename == "performance.csv" else "updated_at"
            if not _iso(row[date_field]): findings.append(Finding("ERROR", "INVALID_DATE", f"invalid {date_field}", filename, row_num))
            if filename == "availability.csv":
                if row["availability_status"] not in ENUMS["availability_status"]: findings.append(Finding("ERROR", "INVALID_ENUM", "invalid availability status", filename, row_num))
                for date_field in ("available_from", "available_to"):
                    if not _iso(row[date_field]): findings.append(Finding("ERROR", "INVALID_DATE", f"invalid {date_field}", filename, row_num))
    return findings
