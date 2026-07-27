import importlib.util
import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def _load_script(name: str):
    path = ROOT / "goal" / "scripts" / f"{name}.py"
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


def test_direct_meta_refresh_derives_groups_from_feature_totals(tmp_path):
    script = _load_script("direct_fetch_meta")
    package = tmp_path / "package_sample"
    package.mkdir()
    rows = [
        {"featureCode": "ftr.a", "groupCode": "fg.b"},
        {"featureCode": "ftr.b", "groupCode": "fg.a"},
        {"featureCode": "ftr.c", "groupCode": "fg.b"},
    ]
    (package / "sample_all_features.json").write_text(json.dumps(rows), encoding="utf-8")
    assert script.load_existing_groups(str(tmp_path)) == ["fg.a", "fg.b"]


def test_group_batches_are_derived_without_sidecar_files(tmp_path):
    script = _load_script("gen_group_batches")
    package = tmp_path / "package_sample"
    package.mkdir()
    rows = [
        {"featureCode": "ftr.a", "groupCode": "fg.c"},
        {"featureCode": "ftr.b", "groupCode": "fg.a"},
        {"featureCode": "ftr.c", "groupCode": "fg.b"},
    ]
    (package / "sample_all_features.json").write_text(json.dumps(rows), encoding="utf-8")
    assert script.gen_batch_requests(str(package), "sample", 2) == [
        ["fg.a", "fg.b"],
        ["fg.c"],
    ]
    assert list(package.iterdir()) == [package / "sample_all_features.json"]


def test_feature_meta_archive_round_trip(tmp_path, monkeypatch):
    script = _load_script("manage_assets")
    metadata = tmp_path / "_metadata"
    source = metadata / "feature_meta"
    source.mkdir(parents=True)
    expected = {"a.json": [{"id": 1}], "b.json": [{"id": 2}]}
    for name, payload in expected.items():
        (source / name).write_text(json.dumps(payload), encoding="utf-8")

    monkeypatch.setattr(script, "METADATA_DIR", metadata)
    monkeypatch.setattr(script, "FEATURE_META_DIR", source)
    monkeypatch.setattr(script, "FEATURE_META_ARCHIVE", metadata / "feature_meta.snapshot.tar.gz")
    monkeypatch.setattr(script, "FEATURE_META_CHECKSUM", metadata / "feature_meta.snapshot.tar.gz.sha256")

    result = script.pack_feature_meta()
    assert result["json_files"] == 2
    for path in source.iterdir():
        path.unlink()
    source.rmdir()
    script.extract_feature_meta()
    restored = {
        path.name: json.loads(path.read_text(encoding="utf-8"))
        for path in source.iterdir()
    }
    assert restored == expected
