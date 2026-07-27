"""Read-only staged importer for the dz-feature-kb Markdown predecessor."""
import csv
import hashlib
import re
from pathlib import Path
from typing import Dict, Iterable, List, Tuple


REFERENCE_FILES = (
    "app-device-behavior.md", "external-data.md", "inner-behavior.md", "juejin.md",
    "operation.md", "pboc-offline.md", "repayment.md", "trade-credit-basic-dcp.md",
)
TABLE_HEADING = re.compile(r"^### (.+?) \| ([0-9,]+)特征", re.MULTILINE)
SUMMARY_ROW = re.compile(r"^\|\s*\d+\s*\|.*\|\s*([0-9,]+)\s*\|\s*~?([0-9,]+)", re.MULTILINE)


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _cells(line: str) -> List[str]:
    return [cell.strip() for cell in line.strip().strip("|").split("|")]


def _first_value(lines: Iterable[str], prefix: str) -> str:
    for line in lines:
        if line.startswith(prefix):
            return line.split(":", 1)[1].strip()
    return ""


def _extract_tables(reference_dir: Path) -> Tuple[List[Dict[str, str]], List[Dict[str, str]], List[Dict[str, str]], Dict[str, object]]:
    tables: List[Dict[str, str]] = []
    lineage: List[Dict[str, str]] = []
    naming_rules: List[Dict[str, str]] = []
    raw_headings, claimed_features = 0, 0
    for filename in REFERENCE_FILES:
        path = reference_dir / filename
        if not path.exists():
            continue
        lines = path.read_text(encoding="utf-8").splitlines()
        current_category = ""
        for index, line in enumerate(lines):
            if line.startswith("## "):
                current_category = re.sub(r"\s*\([^)]*\)", "", line[3:]).strip()
            match = re.match(r"^### (.+?) \| ([0-9,]+)特征", line)
            if not match:
                continue
            raw_headings += 1
            names = re.findall(r"`([^`]+)`", match.group(1))
            if not names:
                continue
            claimed = int(match.group(2).replace(",", ""))
            claimed_features += claimed
            block: List[str] = []
            for next_line in lines[index + 1:]:
                if next_line.startswith("### "):
                    break
                block.append(next_line)
            logic = _first_value(block, "衍生逻辑")
            rule = _first_value(block, "命名规则") or _first_value(block, "**命名规则**")
            upstream_line = _first_value(block, "上游表")
            upstream_tables = re.findall(r"`([^`]+)`", upstream_line)
            for name in names:
                source_ref = "%s:%d" % (filename, index + 1)
                tables.append({"table_name": name, "category": current_category, "feature_count_claimed": str(claimed), "description": logic, "naming_rule": rule, "source_ref": source_ref, "source_sha256": _sha256(path), "review_status": "pending_review"})
                if rule:
                    naming_rules.append({"category": current_category, "table_name": name, "rule": rule, "source_ref": source_ref, "source_sha256": _sha256(path), "review_status": "reference_only"})
                for upstream in upstream_tables:
                    # A documented "merged table" may list its own members as
                    # inputs. That is composition metadata, not table lineage.
                    if upstream in names:
                        continue
                    lineage.append({"downstream_type": "wide_table", "downstream_object": name, "upstream_type": "unclassified_upstream", "upstream_object": upstream, "relation_type": "documented_upstream_candidate", "source_ref": source_ref, "source_sha256": _sha256(path), "review_status": "pending_review"})
    unique_names = {row["table_name"] for row in tables}
    return tables, lineage, naming_rules, {"raw_table_headings": raw_headings, "table_candidate_rows": len(tables), "unique_physical_table_names": len(unique_names), "duplicate_table_candidate_rows": len(tables) - len(unique_names), "table_heading_feature_count_sum": claimed_features}


def _extract_feature_dictionary(path: Path) -> Tuple[List[Dict[str, str]], List[Dict[str, str]]]:
    records: List[Dict[str, str]] = []
    rejects: List[Dict[str, str]] = []
    category, headers = "", []
    source_hash = _sha256(path)
    for number, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        if line.startswith("## "):
            category = re.sub(r"\s*\([^)]*\)", "", line[3:]).strip()
            headers = []
        if not line.startswith("|"):
            continue
        cells = _cells(line)
        if cells and cells[0] == "特征名":
            headers = cells; continue
        if re.match(r"^\|[- :|]+\|$", line) or not headers:
            continue
        if len(cells) != len(headers):
            rejects.append({"row": str(number), "reason": "column_count_mismatch", "raw": line}); continue
        mapped = dict(zip(headers, cells))
        name = mapped.get("特征名", "")
        meaning = mapped.get("修正含义") or mapped.get("中文含义") or mapped.get("原始含义", "")
        if not name or not meaning:
            rejects.append({"row": str(number), "reason": "missing_feature_name_or_meaning", "raw": line}); continue
        records.append({"feature_name": name, "cn_meaning": meaning, "category": category, "definition_source": "legacy_dictionary_candidate", "definition_confidence": "pending_review", "source_ref": "feature-dict.md:%d" % number, "source_sha256": source_hash, "review_status": "pending_review"})
    return records, rejects


def _summary_counts(source_root: Path) -> Dict[str, object]:
    summary: Dict[str, object] = {}
    for relative in ("README.md", "references/index.md"):
        path = source_root / relative
        rows = SUMMARY_ROW.findall(path.read_text(encoding="utf-8"))
        summary[relative] = {"category_rows": len(rows), "table_count_sum": sum(int(table.replace(",", "")) for table, _ in rows), "feature_count_sum": sum(int(feature.replace(",", "")) for _, feature in rows), "headline": "127 tables / approximately 48,000+ features"}
    return summary


def import_dz_markdown(source_root: Path, output_dir: Path) -> Dict[str, object]:
    """Extract candidates only; never modifies the predecessor or active knowledge CSVs."""
    source_root = source_root.resolve()
    output_dir = output_dir.resolve()
    try:
        output_dir.relative_to(source_root)
    except ValueError:
        pass
    else:
        raise ValueError("output_dir must not be the predecessor source directory or a child of it")
    try:
        source_root.relative_to(output_dir)
    except ValueError:
        pass
    else:
        raise ValueError("output_dir must not be an ancestor of the predecessor source directory")
    reference_dir = source_root / "references"
    feature_dict = reference_dir / "feature-dict.md"
    required_paths = [source_root / "README.md", reference_dir / "index.md", feature_dict] + [reference_dir / filename for filename in REFERENCE_FILES]
    missing = [str(path.relative_to(source_root)) for path in required_paths if not path.exists()]
    if missing:
        raise FileNotFoundError("missing required predecessor files: " + ", ".join(missing))
    output_dir.mkdir(parents=True, exist_ok=True)
    tables, lineage, rules, table_stats = _extract_tables(reference_dir)
    features, rejects = _extract_feature_dictionary(feature_dict)
    outputs = {
        "dz_feature_candidates.csv": (features, ["feature_name", "cn_meaning", "category", "definition_source", "definition_confidence", "source_ref", "source_sha256", "review_status"]),
        "dz_table_candidates.csv": (tables, ["table_name", "category", "feature_count_claimed", "description", "naming_rule", "source_ref", "source_sha256", "review_status"]),
        "dz_lineage_candidates.csv": (lineage, ["downstream_type", "downstream_object", "upstream_type", "upstream_object", "relation_type", "source_ref", "source_sha256", "review_status"]),
        "dz_naming_rule_candidates.csv": (rules, ["category", "table_name", "rule", "source_ref", "source_sha256", "review_status"]),
        "import-rejects.csv": (rejects, ["row", "reason", "raw"]),
    }
    for filename, (rows, fields) in outputs.items():
        with (output_dir / filename).open("w", encoding="utf-8", newline="") as handle:
            writer = csv.DictWriter(handle, fieldnames=fields); writer.writeheader(); writer.writerows(rows)
    source_files = [source_root / "README.md", source_root / "references" / "index.md", feature_dict] + [reference_dir / name for name in REFERENCE_FILES]
    report = {"adapter": "dz_markdown", "source": str(source_root), "source_hashes": {str(path.relative_to(source_root)): _sha256(path) for path in source_files if path.exists()}, "mode": "staging_only", "active_knowledge_modified": False, "counts": {"feature_candidates": len(features), "table_candidates": len(tables), "lineage_candidates": len(lineage), "naming_rule_candidates": len(rules), "rejects": len(rejects), **table_stats}, "summary_reconciliation": _summary_counts(source_root)}
    return report
