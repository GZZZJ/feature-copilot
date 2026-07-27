import csv

from feature_copilot.importers.feature_csv import import_feature_csv
from feature_copilot.models import FEATURE_COLUMNS


def test_feature_import_rejects_conflict_and_keeps_valid_row(tmp_path):
    source = tmp_path / "incoming.csv"
    existing = [{"feature_id": "keep", "definition_source": "manual_confirmed"}]
    row = {field: "x" for field in FEATURE_COLUMNS}; row.update({"feature_id": "new", "feature_name": "new_feature"})
    conflict = dict(row); conflict["feature_id"] = "keep"
    with source.open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=FEATURE_COLUMNS); writer.writeheader(); writer.writerow(row); writer.writerow(conflict)
    accepted, rejects, report = import_feature_csv(source, existing)
    assert [item["feature_id"] for item in accepted] == ["new"]
    assert rejects[0]["reason"] == "conflict_preserved_manual"
    assert report["source_sha256"] and source.exists()
