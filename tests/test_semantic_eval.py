import copy
import importlib.util
import json
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]
FIXTURE = ROOT / "tests" / "fixtures" / "semantic_eval.json"
MODULE_SPEC = importlib.util.spec_from_file_location(
    "evaluate_semantic_search", ROOT / "scripts" / "evaluate_semantic_search.py"
)
assert MODULE_SPEC and MODULE_SPEC.loader
semantic_eval = importlib.util.module_from_spec(MODULE_SPEC)
MODULE_SPEC.loader.exec_module(semantic_eval)


class FakeSearcher:
    def __init__(self, results=None):
        self.results = results or {}

    def search(self, call, limit):
        key = tuple(call.get("keywords", []))
        return list(self.results.get(key, []))[:limit]

    def close(self):
        pass


def test_run_calls_keeps_unjudged_full_corpus_ranks():
    searcher = FakeSearcher({("query",): ["unjudged.a", "gold", "unjudged.b"]})

    ranked, trace = semantic_eval._run_calls(
        searcher,
        [{"keywords": ["query"], "tags": [], "metric_scope": "any"}],
        limit=20,
        judged_codes={"gold"},
    )

    assert ranked == ["unjudged.a", "gold", "unjudged.b"]
    assert trace[0]["raw_result_count"] == 3
    assert trace[0]["incremental_judged_count"] == 1
    assert trace[0]["incremental_judged_codes"] == ["gold"]


def test_release_metrics_penalize_unjudged_results_ahead_of_gold():
    noise = [f"unjudged.{index}" for index in range(20)]
    gold = {f"gold.{index}" for index in range(20)}
    ranked = noise + sorted(gold)
    grades = {code: 3 for code in gold}

    metrics = semantic_eval._release_metrics(
        ranked, gold, grades, hard_negatives={"unjudged.0"}
    )

    assert metrics["p_at_20_lower_bound"] == 0.0
    assert metrics["sampled_gold_recall_at_50"] == 1.0
    assert metrics["ndcg_at_20_lower_bound"] == 0.0
    assert metrics["judgment_coverage_at_20"] == 0.0
    assert metrics["precision_among_judged_at_20"] == 0.0
    assert metrics["known_hard_negative_pollution_at_20_lower_bound"] == pytest.approx(0.05)


def test_question_plan_relaxes_only_after_empty_result_without_gold_filtering():
    fixture = {
        "release_gate": {
            "retrieval_limit_per_call": 1000,
            "question_suite": {"fallback_limit": 50},
        }
    }
    query = {
        "category": "synonym",
        "search_terms": ["短词", "更长的同义词"],
    }
    searcher = FakeSearcher({
        ("短词", "更长的同义词"): [],
        ("更长的同义词",): ["unjudged", "gold"],
    })

    ranked, trace, strategy = semantic_eval._question_plan(
        fixture, query, searcher, {"gold"}
    )

    assert strategy == "single_term_fallback"
    assert ranked == ["unjudged", "gold"]
    assert [item["plan_stage"] for item in trace] == [
        "exact_terms_and", "single_term_fallback",
    ]


def test_fixture_promotes_all_36_questions_into_category_gates():
    fixture = semantic_eval.load_fixture(FIXTURE)

    validation = semantic_eval.validate_fixture(fixture, ROOT, validate_sources=False)

    assert validation["release_question_count"] == 36
    assert set(fixture["release_gate"]["question_suite"]["category_thresholds"]) == set(
        semantic_eval.EXPECTED_CATEGORIES
    )


def test_fixture_rejects_missing_question_category_threshold():
    fixture = semantic_eval.load_fixture(FIXTURE)
    invalid = copy.deepcopy(fixture)
    del invalid["release_gate"]["question_suite"]["category_thresholds"]["synonym"]

    with pytest.raises(ValueError, match="cover all six query categories"):
        semantic_eval.validate_fixture(invalid, ROOT, validate_sources=False)


def test_fixture_rejects_empty_release_scenario_thresholds():
    fixture = semantic_eval.load_fixture(FIXTURE)
    invalid = copy.deepcopy(fixture)
    invalid["release_gate"]["scenarios"][0]["thresholds"] = {}

    with pytest.raises(ValueError, match="direct_overdue_days thresholds must be exactly"):
        semantic_eval.validate_fixture(invalid, ROOT, validate_sources=False)


def test_render_text_labels_sampled_gold_and_conservative_lower_bounds():
    report = {
        "release_gate": {
            "passed": False,
            "scenarios": [{
                "id": "direct_overdue_days",
                "passed": True,
                "metrics": {
                    "p_at_20_lower_bound": 0.9,
                    "sampled_gold_recall_at_50": 0.95,
                    "ndcg_at_20_lower_bound": 0.85,
                    "judgment_coverage_at_20": 0.5,
                    "judgment_coverage_at_50": 0.4,
                    "precision_among_judged_at_20": 1.0,
                    "precision_among_judged_at_50": 1.0,
                    "known_hard_negative_pollution_at_20_lower_bound": 0.0,
                },
            }],
            "question_suite": {
                "passed": False,
                "known_hard_negative_pollution_gate": {"actual": 0.01},
                "categories": [{
                    "category": "synonym",
                    "passed": False,
                    "metrics": {
                        "sampled_query_hit_rate_at_20": 0.33,
                        "macro_sampled_gold_recall_at_50": 0.2,
                    },
                }],
            },
        },
        "database_candidate_coverage": 1.0,
        "lexical_diagnostics": {
            "aggregate": {
                "macro_p_at_20_lower_bound": 0.1,
                "macro_sampled_gold_recall_at_50": 0.2,
                "macro_ndcg_at_20_lower_bound": 0.3,
                "known_hard_negative_pollution_at_20_lower_bound": 0.0,
                "no_result_raw_nonempty_rate": 0.0,
            },
        },
    }

    rendered = semantic_eval.render_text(report, include_per_query=False)

    assert "P@20-LB=0.900000" in rendered
    assert "sampled Recall@50=0.950000" in rendered
    assert "judgment coverage@20=0.500000" in rendered
    assert "Macro sampled-gold Recall@50: 0.200000" in rendered


def test_main_returns_nonzero_when_any_release_gate_fails(tmp_path, monkeypatch, capsys):
    database = tmp_path / "index.sqlite"
    database.touch()
    report = {
        "release_gate": {
            "passed": False,
            "question_suite": {"per_query": []},
        },
        "lexical_diagnostics": {"per_query": []},
    }
    monkeypatch.setattr(semantic_eval, "load_fixture", lambda path: {})
    monkeypatch.setattr(semantic_eval, "validate_fixture", lambda *args: {})
    monkeypatch.setattr(semantic_eval, "ServiceSearcher", lambda path: FakeSearcher())
    monkeypatch.setattr(semantic_eval, "evaluate", lambda *args, **kwargs: copy.deepcopy(report))

    exit_code = semantic_eval.main([
        "--fixture", str(tmp_path / "fixture.json"),
        "--database", str(database),
        "--backend", "service",
        "--format", "json",
    ])

    assert exit_code == 1
    rendered = json.loads(capsys.readouterr().out)
    assert rendered["release_gate"]["passed"] is False
