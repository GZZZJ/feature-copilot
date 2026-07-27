import json

import pytest

from feature_copilot import index_builder
from feature_copilot.errors import ValidationError
from feature_copilot.index_builder import build_index


def test_build_is_idempotent_and_records_hashes(kb):
    knowledge, database = kb
    first = build_index(knowledge, database, __import__("pathlib").Path(__file__).parents[1])
    second = build_index(knowledge, database, __import__("pathlib").Path(__file__).parents[1])
    assert first["source_hashes"] == second["source_hashes"]
    assert first["fts5"] is True


def test_invalid_source_does_not_replace_old_index(kb):
    knowledge, database = kb; before = database.read_bytes()
    path = knowledge / "features.csv"; path.write_text(path.read_text(encoding="utf-8").replace("fixture_customer_wide", "missing_table", 1), encoding="utf-8")
    with pytest.raises(ValidationError): build_index(knowledge, database, __import__("pathlib").Path(__file__).parents[1])
    assert database.read_bytes() == before


def test_build_without_fts_uses_like_fallback(kb):
    knowledge, database = kb
    report = build_index(knowledge, database, __import__("pathlib").Path(__file__).parents[1], force_fts_unavailable=True)
    from feature_copilot.service import FeatureService
    service = FeatureService(database)
    try:
        assert report["fts5"] is False
        assert service.search(["fixture_income_avg_30d"])["search_mode"] == "like"
    finally:
        service.close()


def test_source_changed_after_read_aborts_publication(kb, monkeypatch):
    knowledge, database = kb
    manifest = database.with_suffix(".manifest.json")
    before_database = database.read_bytes()
    before_manifest = manifest.read_bytes()
    real_load_csv = index_builder.load_csv
    changed = False

    def load_then_change(path):
        nonlocal changed
        rows = real_load_csv(path)
        if path.name == "features.csv" and not changed:
            path.write_text(
                path.read_text(encoding="utf-8").replace(
                    "fixture_income_avg_30d", "fixture_income_avg_30d_changed", 1
                ),
                encoding="utf-8",
            )
            changed = True
        return rows

    monkeypatch.setattr(index_builder, "load_csv", load_then_change)
    with pytest.raises(ValidationError, match="sources changed during index build"):
        build_index(knowledge, database, __import__("pathlib").Path(__file__).parents[1])

    assert database.read_bytes() == before_database
    assert manifest.read_bytes() == before_manifest
