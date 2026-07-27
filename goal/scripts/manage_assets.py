#!/usr/bin/env python3
"""校验、压缩和恢复 feature-copilot 本地资产。

默认只读检查；`compact --apply` 仅会删除已证明可重建的中间件和索引缓存。
"""
import argparse
import csv
import hashlib
import json
import os
import tarfile
import tempfile
from pathlib import Path, PurePosixPath
from typing import Dict, Iterable, List, Sequence


ROOT = Path(__file__).resolve().parents[2]
SCOPE = ROOT / "knowledge" / "config" / "maintenance_scope.json"
METADATA_DIR = ROOT / "goal" / "_metadata"
FEATURE_META_DIR = METADATA_DIR / "feature_meta"
FEATURE_META_ARCHIVE = METADATA_DIR / "feature_meta.snapshot.tar.gz"
FEATURE_META_CHECKSUM = METADATA_DIR / "feature_meta.snapshot.tar.gz.sha256"
BUILD_CACHE = (
    ROOT / "build" / "feature_copilot.sqlite",
    ROOT / "build" / "feature_copilot.manifest.json",
)
SUMMARY_FIELDS = (
    "featureCode",
    "featureName",
    "featureColumnName",
    "groupCode",
    "groupName",
    "domainCode",
    "includeTodayFlag",
    "timeRange",
)


def _read_json(path: Path):
    with path.open(encoding="utf-8") as handle:
        return json.load(handle)


def _digest(path: Path) -> str:
    sha256 = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            sha256.update(block)
    return sha256.hexdigest()


def _display_path(path: Path) -> str:
    try:
        return str(path.relative_to(ROOT))
    except ValueError:
        return str(path)


def _canonical_features(rows: Iterable[dict]) -> List[dict]:
    return sorted(rows, key=lambda row: json.dumps(row, ensure_ascii=False, sort_keys=True))


def _derived_groups(features: Sequence[dict]) -> Dict[str, dict]:
    result: Dict[str, dict] = {}
    for feature in features:
        code = feature["groupCode"]
        item = result.setdefault(
            code,
            {
                "groupName": feature.get("groupName", ""),
                "domainCode": feature.get("domainCode", ""),
                "featureCount": 0,
                "featureCodes": [],
            },
        )
        item["featureCount"] += 1
        item["featureCodes"].append(feature["featureCode"])
    return result


def _normalized_groups(groups: Dict[str, dict]) -> Dict[str, dict]:
    normalized = {}
    for code, item in groups.items():
        normalized[code] = {
            "groupName": item.get("groupName", ""),
            "domainCode": item.get("domainCode", ""),
            "featureCount": int(item.get("featureCount", 0)),
            "featureCodes": sorted(item.get("featureCodes", [])),
        }
    return normalized


def _package_paths() -> List[Path]:
    scope = _read_json(SCOPE)
    return [ROOT / item["feature_file"] for item in scope["packages"]]


def _verify_package(feature_path: Path) -> List[Path]:
    features = _read_json(feature_path)
    if not isinstance(features, list):
        raise ValueError(f"特征总表不是 JSON 数组: {feature_path}")
    package_dir = feature_path.parent
    prefix = feature_path.name.removesuffix("_all_features.json")
    removable: List[Path] = []

    page_paths = sorted(package_dir.glob("page_*.json"))
    if page_paths:
        paged = []
        for path in page_paths:
            payload = _read_json(path)
            rows = payload.get("features")
            if rows is None:
                rows = payload.get("data", {}).get("list", [])
            paged.extend(rows)
        if _canonical_features(paged) != _canonical_features(features):
            raise ValueError(f"分页快照与特征总表不一致: {package_dir}")
        removable.extend(page_paths)

    groups_path = package_dir / f"{prefix}_groups.json"
    if groups_path.exists():
        stored = _normalized_groups(_read_json(groups_path))
        derived = _normalized_groups(_derived_groups(features))
        if stored != derived:
            raise ValueError(f"分组快照不能由特征总表等价重建: {groups_path}")
        removable.append(groups_path)

    summary_path = package_dir / f"{prefix}_summary.csv"
    if summary_path.exists():
        with summary_path.open(encoding="utf-8-sig", newline="") as handle:
            stored_rows = list(csv.DictReader(handle))
        derived_rows = [
            {field: str(feature.get(field, "")) for field in SUMMARY_FIELDS}
            for feature in features
        ]
        if stored_rows != derived_rows:
            raise ValueError(f"CSV 摘要不能由特征总表等价重建: {summary_path}")
        removable.append(summary_path)

    codes_path = package_dir / f"{prefix}_group_codes.txt"
    if codes_path.exists():
        stored_codes = codes_path.read_text(encoding="utf-8").splitlines()
        derived_codes = sorted({feature["groupCode"] for feature in features})
        if stored_codes != derived_codes:
            raise ValueError(f"分组代码不能由特征总表等价重建: {codes_path}")
        removable.append(codes_path)
    return removable


def _archive_members(archive: tarfile.TarFile) -> List[tarfile.TarInfo]:
    members = archive.getmembers()
    for member in members:
        path = PurePosixPath(member.name)
        if path.is_absolute() or ".." in path.parts:
            raise ValueError(f"归档包含不安全路径: {member.name}")
        if not member.isfile() or len(path.parts) != 2 or path.parts[0] != "feature_meta" or path.suffix != ".json":
            raise ValueError(f"归档包含非预期成员: {member.name}")
    if not members:
        raise ValueError("特征元数据归档为空")
    return members


def pack_feature_meta() -> dict:
    if not FEATURE_META_DIR.is_dir():
        if FEATURE_META_ARCHIVE.exists():
            return verify_feature_meta_archive()
        raise FileNotFoundError(f"特征元数据目录不存在: {FEATURE_META_DIR}")
    files = sorted(FEATURE_META_DIR.glob("*.json"))
    unexpected = sorted(path for path in FEATURE_META_DIR.iterdir() if path not in files)
    if unexpected:
        raise ValueError("特征元数据目录含非 JSON 文件: " + ", ".join(map(str, unexpected)))
    for path in files:
        _read_json(path)

    descriptor, temporary_name = tempfile.mkstemp(
        prefix="feature_meta_", suffix=".tar.gz", dir=str(METADATA_DIR)
    )
    os.close(descriptor)
    temporary = Path(temporary_name)
    try:
        with tarfile.open(temporary, "w:gz", compresslevel=9) as archive:
            for path in files:
                archive.add(path, arcname=f"feature_meta/{path.name}", recursive=False)
        temporary.replace(FEATURE_META_ARCHIVE)
    finally:
        temporary.unlink(missing_ok=True)
    digest = _digest(FEATURE_META_ARCHIVE)
    FEATURE_META_CHECKSUM.write_text(
        f"{digest}  {FEATURE_META_ARCHIVE.name}\n", encoding="ascii"
    )
    result = verify_feature_meta_archive()
    result["source_files"] = len(files)
    return result


def verify_feature_meta_archive() -> dict:
    expected = FEATURE_META_CHECKSUM.read_text(encoding="ascii").split()[0]
    actual = _digest(FEATURE_META_ARCHIVE)
    if actual != expected:
        raise ValueError("特征元数据归档 SHA-256 不匹配")
    with tarfile.open(FEATURE_META_ARCHIVE, "r:gz") as archive:
        members = _archive_members(archive)
        for member in members:
            extracted = archive.extractfile(member)
            if extracted is None:
                raise ValueError(f"无法读取归档成员: {member.name}")
            json.load(extracted)
    return {
        "archive": _display_path(FEATURE_META_ARCHIVE),
        "sha256": actual,
        "json_files": len(members),
        "bytes": FEATURE_META_ARCHIVE.stat().st_size,
    }


def extract_feature_meta() -> dict:
    verification = verify_feature_meta_archive()
    if FEATURE_META_DIR.exists():
        raise FileExistsError(f"目标目录已存在: {FEATURE_META_DIR}")
    with tempfile.TemporaryDirectory(prefix="feature_meta_extract_", dir=str(METADATA_DIR)) as temporary:
        temporary_root = Path(temporary)
        with tarfile.open(FEATURE_META_ARCHIVE, "r:gz") as archive:
            members = _archive_members(archive)
            for member in members:
                archive.extract(member, path=temporary_root)
        (temporary_root / "feature_meta").replace(FEATURE_META_DIR)
    verification["extracted_to"] = _display_path(FEATURE_META_DIR)
    return verification


def compact(apply: bool) -> dict:
    removable: List[Path] = []
    for feature_path in _package_paths():
        removable.extend(_verify_package(feature_path))
    archive = pack_feature_meta() if apply else {
        "source": _display_path(FEATURE_META_DIR) if FEATURE_META_DIR.exists() else None,
        "archive": _display_path(FEATURE_META_ARCHIVE) if FEATURE_META_ARCHIVE.exists() else None,
    }
    existing_cache = [path for path in BUILD_CACHE if path.exists()]
    if apply:
        for path in removable + existing_cache:
            path.unlink()
        if FEATURE_META_DIR.exists():
            for path in FEATURE_META_DIR.iterdir():
                path.unlink()
            FEATURE_META_DIR.rmdir()
        archive = verify_feature_meta_archive()
    return {
        "status": "applied" if apply else "checked",
        "archive": archive,
        "derived_files": len(removable),
        "build_cache_files": len(existing_cache),
        "paths": [_display_path(path) for path in removable + existing_cache],
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="command", required=True)
    compact_parser = subparsers.add_parser("compact", help="检查或清理可重建资产")
    compact_parser.add_argument("--apply", action="store_true", help="执行压缩和清理")
    subparsers.add_parser("verify", help="校验特征元数据归档")
    subparsers.add_parser("extract-meta", help="恢复特征元数据目录")
    args = parser.parse_args()
    if args.command == "compact":
        result = compact(args.apply)
    elif args.command == "verify":
        result = verify_feature_meta_archive()
    else:
        result = extract_feature_meta()
    print(json.dumps(result, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
