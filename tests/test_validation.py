from pathlib import Path

from feature_copilot.validators import validate_knowledge


def test_invalid_definition_inference_is_error(kb):
    knowledge, _ = kb
    path = knowledge / "features.csv"
    path.write_text(path.read_text(encoding="utf-8").replace("name_inference,unverified", "name_inference,verified"), encoding="utf-8")
    findings = validate_knowledge(knowledge, Path(__file__).parents[1])
    assert any(item.code == "INFERENCE_AS_OFFICIAL" for item in findings)


def test_missing_logic_reference_is_error(kb):
    knowledge, _ = kb
    path = knowledge / "features.csv"
    path.write_text(path.read_text(encoding="utf-8").replace("logic/sql/fixture_customer_features.sql", "logic/sql/missing.sql", 1), encoding="utf-8")
    findings = validate_knowledge(knowledge, Path(__file__).parents[1])
    assert any(item.code == "MISSING_LOGIC_REF" for item in findings)


def test_current_version_conflict_is_an_error(kb):
    knowledge, _ = kb
    features = knowledge / "features.csv"
    text = features.read_text(encoding="utf-8")
    duplicate_active = [line for line in text.splitlines() if line.startswith("feat_income_avg_v1,")][0].replace(",deprecated,1.0.0,", ",active,1.0.1,")
    features.write_text(text + "\n" + duplicate_active, encoding="utf-8")
    findings = validate_knowledge(knowledge, Path(__file__).parents[1])
    assert any(item.code == "CURRENT_VERSION_CONFLICT" for item in findings)
