import shutil

from feature_copilot.cli import EXIT_NOT_FOUND, EXIT_OK, EXIT_RUNTIME, main


def test_cli_json_and_not_found(kb, capsys):
    _, database = kb
    assert main(["--db", str(database), "get", "fixture_income_avg_30d", "--format", "json"]) == EXIT_OK
    assert '"status": "OK"' in capsys.readouterr().out
    assert main(["--db", str(database), "get", "missing_feature", "--format", "json"]) == EXIT_NOT_FOUND
    assert '"status": "NOT_FOUND"' in capsys.readouterr().out


def test_cli_filters(kb, capsys):
    _, database = kb
    assert main(["--db", str(database), "search", "示例", "--category", "transaction", "--format", "json"]) == EXIT_OK
    assert 'fixture_payment_count_30d' in capsys.readouterr().out


def test_cli_full_and_invalid_as_of(kb, capsys):
    _, database = kb
    assert main(["--db", str(database), "table", "fixture_customer_wide", "--full", "--format", "json"]) == EXIT_OK
    full_output = capsys.readouterr().out
    assert '"full_requested": true' in full_output and '"limit": 100000' in full_output
    assert main(["--db", str(database), "availability", "fixture_income_avg_30d", "--as-of", "not-a-date", "--format", "json"]) == EXIT_RUNTIME
    assert 'as-of must be an ISO date' in capsys.readouterr().out


def test_cli_explain_logic_uses_managed_catalog(tmp_path, capsys):
    from pathlib import Path
    from feature_copilot.index_builder import build_index

    root = Path(__file__).resolve().parents[1]
    database = tmp_path / "managed.sqlite"; build_index(root / "knowledge", database, root)
    code = "ftr.off.usr.dwa_risk_tnd_feature_di.tnd_rsk_itm_d7_bnk_sml_lon"
    assert main(["--db", str(database), "explain-logic", code, "--format", "json"]) == EXIT_OK
    output = capsys.readouterr().out
    assert '"coverage_status": "recursive"' in output
    assert 'group_logic_fg_off_usr_dwa_risk_tnd_feature_di.json' in output


def test_cli_audit_logic_returns_compact_json(tmp_path, capsys):
    from pathlib import Path
    from feature_copilot.index_builder import build_index

    root = Path(__file__).resolve().parents[1]
    database = tmp_path / "managed.sqlite"; build_index(root / "knowledge", database, root)
    assert main(["--db", str(database), "audit-logic", "--max-depth", "20", "--format", "json"]) == EXIT_OK
    output = capsys.readouterr().out
    assert '"representative_feature_tables": 96' in output
    assert '"missing_nonstandard_tables"' in output
    assert '"sql"' not in output


def test_cli_lineage_uses_generated_table_edges(tmp_path, capsys):
    from pathlib import Path
    from feature_copilot.index_builder import build_index

    root = Path(__file__).resolve().parents[1]
    database = tmp_path / "lineage.sqlite"; build_index(root / "knowledge", database, root)
    assert main([
        "--db", str(database), "lineage", "dwa_risk.dwa_risk_tnd_feature_di",
        "--direction", "forward", "--max-depth", "3", "--format", "json",
    ]) == EXIT_OK
    output = capsys.readouterr().out
    assert '"table_name": "dwa_risk.dwa_risk_tnd_feature_di"' in output
    assert '"source_type": "group_logic"' in output


def test_cli_query_auto_builds_missing_index(tmp_path, capsys):
    from pathlib import Path

    root = Path(__file__).resolve().parents[1]
    knowledge = tmp_path / "knowledge"
    shutil.copytree(root / "knowledge", knowledge)
    database = tmp_path / "cache" / "feature_copilot.sqlite"
    assert not database.exists()
    assert main([
        "--data-dir", str(knowledge),
        "--db", str(database),
        "get", "fixture_income_avg_30d",
        "--format", "json",
    ]) == EXIT_OK
    assert database.is_file()
    assert database.with_suffix(".manifest.json").is_file()
    assert '"status": "OK"' in capsys.readouterr().out
