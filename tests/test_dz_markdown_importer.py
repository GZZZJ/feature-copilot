import pytest

from feature_copilot.importers.dz_markdown import REFERENCE_FILES, import_dz_markdown


def test_dz_markdown_stages_candidates_without_active_knowledge(tmp_path):
    source = tmp_path / "dz"; references = source / "references"; references.mkdir(parents=True)
    (source / "README.md").write_text("| 1 | 示例 | 2 | ~3 | 客群 |\n", encoding="utf-8")
    (references / "index.md").write_text("| 1 | 示例 | 2 | ~3 | 客群 |\n", encoding="utf-8")
    (references / "feature-dict.md").write_text("# 字典\n## 示例类 (2)\n| 特征名 | 中文含义 |\n|---|---|\n| `legacy_a` | 示例A |\n", encoding="utf-8")
    (references / "app-device-behavior.md").write_text("# 示例\n## 示例类 (2表)\n### `legacy_table_a` + `legacy_table_b` (合并表) | 2特征\n衍生逻辑: 示例逻辑\n命名规则: `x_{window}`\n上游表: `legacy_table_a`, `legacy_table_b`\n", encoding="utf-8")
    for filename in REFERENCE_FILES:
        (references / filename).touch(exist_ok=True)
    output = tmp_path / "out"
    report = import_dz_markdown(source, output)
    assert report["mode"] == "staging_only" and report["active_knowledge_modified"] is False
    assert report["counts"]["feature_candidates"] == 1
    assert report["counts"]["raw_table_headings"] == 1
    assert report["counts"]["table_candidates"] == 2
    assert report["counts"]["lineage_candidates"] == 0
    assert report["counts"]["unique_physical_table_names"] == 2
    assert (output / "dz_feature_candidates.csv").exists()
    assert "legacy_a" in (output / "dz_feature_candidates.csv").read_text(encoding="utf-8")


def test_dz_markdown_rejects_source_tree_as_output(tmp_path):
    source = tmp_path / "dz"; references = source / "references"; references.mkdir(parents=True)
    (source / "README.md").write_text("", encoding="utf-8")
    (references / "index.md").write_text("", encoding="utf-8")
    (references / "feature-dict.md").write_text("", encoding="utf-8")
    for filename in REFERENCE_FILES:
        (references / filename).touch(exist_ok=True)
    with pytest.raises(ValueError, match="must not be"):
        import_dz_markdown(source, source / "staging")
    with pytest.raises(ValueError, match="ancestor"):
        import_dz_markdown(source, tmp_path)


def test_dz_markdown_rejects_missing_sources_before_writing(tmp_path):
    source = tmp_path / "dz"; (source / "references").mkdir(parents=True)
    output = tmp_path / "out"
    with pytest.raises(FileNotFoundError, match="README.md"):
        import_dz_markdown(source, output)
    assert not output.exists()
