#!/usr/bin/env python3
"""Offline evaluation for the Chinese overdue-day semantic-search fixture."""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import sqlite3
import sys
from collections import Counter
from pathlib import Path
from typing import Any, Dict, Iterable, List, Mapping, Sequence


ROOT = Path(__file__).resolve().parents[1]
DEFAULT_FIXTURE = ROOT / "tests" / "fixtures" / "semantic_eval.json"
EXPECTED_BUCKETS = {"overdue": 60, "hard_negative": 30, "robustness": 30}
EXPECTED_CATEGORIES = {
    "direct": 6,
    "related": 6,
    "synonym": 6,
    "compound": 6,
    "ambiguous": 6,
    "no_result": 6,
}


def load_fixture(path: Path) -> Dict[str, Any]:
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError) as error:
        raise ValueError(f"cannot load fixture {path}: {error}") from error
    if not isinstance(value, dict):
        raise ValueError("fixture root must be an object")
    return value


def validate_fixture(fixture: Mapping[str, Any], root: Path, validate_sources: bool) -> Dict[str, Any]:
    errors: List[str] = []
    candidates = fixture.get("candidates")
    queries = fixture.get("lexical_diagnostics")
    release_gate = fixture.get("release_gate")
    if not isinstance(candidates, dict):
        errors.append("candidates must be an object keyed by feature_code")
        candidates = {}
    if not isinstance(queries, list):
        errors.append("lexical_diagnostics must be an array")
        queries = []
    if not isinstance(release_gate, dict):
        errors.append("release_gate must be an object")
        release_gate = {}

    bucket_counts: Counter[str] = Counter()
    for code, item in candidates.items():
        if not isinstance(code, str) or not code.startswith("ftr."):
            errors.append(f"invalid feature_code key: {code!r}")
            continue
        if not isinstance(item, dict):
            errors.append(f"candidate {code} must be an object")
            continue
        missing = {
            "bucket", "subtype", "relation", "relevance", "expected_dimensions",
            "rationale", "source_packages", "feature_column_name", "feature_name", "group_name",
        } - set(item)
        if missing:
            errors.append(f"candidate {code} missing keys: {sorted(missing)}")
        relevance = item.get("relevance")
        if isinstance(relevance, bool) or not isinstance(relevance, int) or relevance not in range(4):
            errors.append(f"candidate {code} relevance must be an integer from 0 to 3")
        if not isinstance(item.get("expected_dimensions"), list):
            errors.append(f"candidate {code} expected_dimensions must be an array")
        if not isinstance(item.get("rationale"), str) or not item.get("rationale", "").strip():
            errors.append(f"candidate {code} rationale must be non-empty")
        bucket_counts[str(item.get("bucket"))] += 1

    category_counts: Counter[str] = Counter()
    query_ids = set()
    for query in queries:
        if not isinstance(query, dict):
            errors.append("every query must be an object")
            continue
        query_id = query.get("id")
        if not isinstance(query_id, str) or not query_id:
            errors.append("query id must be a non-empty string")
        elif query_id in query_ids:
            errors.append(f"duplicate query id: {query_id}")
        query_ids.add(query_id)
        category_counts[str(query.get("category"))] += 1
        if not isinstance(query.get("question"), str) or not query.get("question", "").strip():
            errors.append(f"query {query_id} question must be non-empty")
        if not isinstance(query.get("search_terms"), list) or not all(
            isinstance(term, str) and term.strip() for term in query.get("search_terms", [])
        ):
            errors.append(f"query {query_id} search_terms must contain non-empty strings")
        if not isinstance(query.get("expected_dimensions"), list):
            errors.append(f"query {query_id} expected_dimensions must be an array")
        judgments = query.get("judgments")
        if not isinstance(judgments, dict):
            errors.append(f"query {query_id} judgments must be an object keyed by feature_code")
            continue
        for code, judgment in judgments.items():
            if code not in candidates:
                errors.append(f"query {query_id} references unknown candidate {code}")
            if not isinstance(judgment, dict):
                errors.append(f"query {query_id} judgment {code} must be an object")
                continue
            if set(judgment) != {"relevance", "expected_dimensions", "rationale"}:
                errors.append(f"query {query_id} judgment {code} has unstable keys")
            relevance = judgment.get("relevance")
            if isinstance(relevance, bool) or not isinstance(relevance, int) or relevance not in range(4):
                errors.append(f"query {query_id} judgment {code} has invalid relevance")
            if not isinstance(judgment.get("expected_dimensions"), list):
                errors.append(f"query {query_id} judgment {code} expected_dimensions must be an array")
            if not isinstance(judgment.get("rationale"), str) or not judgment.get("rationale", "").strip():
                errors.append(f"query {query_id} judgment {code} rationale must be non-empty")
        positives = [item for item in judgments.values() if isinstance(item, dict) and item.get("relevance", 0) > 0]
        if query.get("category") == "no_result" and positives:
            errors.append(f"no-result query {query_id} must not have positive judgments")
        if query.get("category") != "no_result" and not positives:
            errors.append(f"answerable query {query_id} must have a positive judgment")

    if len(candidates) != 120:
        errors.append(f"expected 120 candidates, found {len(candidates)}")
    if dict(bucket_counts) != EXPECTED_BUCKETS:
        errors.append(f"bucket counts differ: {dict(bucket_counts)}")
    if len(queries) != 36:
        errors.append(f"expected 36 queries, found {len(queries)}")
    if dict(category_counts) != EXPECTED_CATEGORIES:
        errors.append(f"query category counts differ: {dict(category_counts)}")

    scenarios = release_gate.get("scenarios", [])
    if not isinstance(scenarios, list) or [item.get("id") for item in scenarios if isinstance(item, dict)] != [
        "direct_overdue_days", "broad_related",
    ]:
        errors.append("release_gate must define direct_overdue_days then broad_related")
        scenarios = []
    if release_gate.get("retrieval_limit_per_call", 0) < 1000:
        errors.append("release_gate retrieval_limit_per_call must be at least 1000")
    question_suite = release_gate.get("question_suite")
    if not isinstance(question_suite, dict):
        errors.append("release_gate question_suite must be an object")
        question_suite = {}
    if question_suite.get("query_source") != "lexical_diagnostics":
        errors.append("question_suite query_source must be lexical_diagnostics")
    if not isinstance(question_suite.get("coverage_contract"), str) or not question_suite.get(
        "coverage_contract", ""
    ).strip():
        errors.append("question_suite coverage_contract must be non-empty")
    fallback_limit = question_suite.get("fallback_limit")
    if isinstance(fallback_limit, bool) or not isinstance(fallback_limit, int) or fallback_limit < 20:
        errors.append("question_suite fallback_limit must be an integer of at least 20")
    threshold_rationale = question_suite.get("threshold_rationale")
    if not isinstance(threshold_rationale, dict) or set(threshold_rationale) != set(EXPECTED_CATEGORIES):
        errors.append("question_suite threshold_rationale must cover all six query categories")
    elif not all(isinstance(value, str) and value.strip() for value in threshold_rationale.values()):
        errors.append("question_suite threshold_rationale values must be non-empty strings")
    category_thresholds = question_suite.get("category_thresholds")
    if not isinstance(category_thresholds, dict) or set(category_thresholds) != set(EXPECTED_CATEGORIES):
        errors.append("question_suite category_thresholds must cover all six query categories")
        category_thresholds = {}
    expected_metrics = {
        "direct": {
            "sampled_query_hit_rate_at_20", "macro_sampled_gold_recall_at_50",
            "macro_ndcg_at_20_lower_bound",
        },
        "related": {
            "sampled_query_hit_rate_at_20", "macro_sampled_gold_recall_at_50",
            "macro_ndcg_at_20_lower_bound",
        },
        "synonym": {
            "sampled_query_hit_rate_at_20", "macro_sampled_gold_recall_at_50",
            "macro_ndcg_at_20_lower_bound",
        },
        "compound": {
            "sampled_query_hit_rate_at_20", "macro_sampled_gold_recall_at_50",
            "macro_ndcg_at_20_lower_bound",
        },
        "ambiguous": {
            "sampled_query_hit_rate_at_20", "macro_sampled_gold_recall_at_50",
        },
        "no_result": {"raw_nonempty_rate"},
    }
    for category, expected in expected_metrics.items():
        thresholds = category_thresholds.get(category)
        if not isinstance(thresholds, dict) or set(thresholds) != expected:
            errors.append(
                f"question_suite {category} thresholds must be exactly {sorted(expected)}"
            )
            continue
        for metric, threshold in thresholds.items():
            if isinstance(threshold, bool) or not isinstance(threshold, (int, float)) or not 0 <= threshold <= 1:
                errors.append(
                    f"question_suite {category}.{metric} threshold must be between 0 and 1"
                )
    global_thresholds = question_suite.get("global_thresholds")
    if not isinstance(global_thresholds, dict) or set(global_thresholds) != {
        "known_hard_negative_pollution_at_20_lower_bound"
    }:
        errors.append(
            "question_suite global_thresholds must define "
            "known_hard_negative_pollution_at_20_lower_bound"
        )
    else:
        threshold = global_thresholds["known_hard_negative_pollution_at_20_lower_bound"]
        if isinstance(threshold, bool) or not isinstance(threshold, (int, float)) or not 0 <= threshold <= 1:
            errors.append("question_suite hard-negative threshold must be between 0 and 1")
    for scenario in scenarios:
        scenario_id = scenario["id"]
        calls = scenario.get("calls")
        if not isinstance(calls, list) or not calls:
            errors.append(f"release scenario {scenario_id} requires calls")
            continue
        for index, call in enumerate(calls):
            if not isinstance(call, dict):
                errors.append(f"release scenario {scenario_id} call {index} must be an object")
                continue
            if not isinstance(call.get("keywords", []), list) or not isinstance(call.get("tags", []), list):
                errors.append(f"release scenario {scenario_id} call {index} keywords/tags must be arrays")
            if not call.get("keywords") and not call.get("tags"):
                errors.append(f"release scenario {scenario_id} call {index} is empty")
            if call.get("metric_scope", "any") not in {"primary", "related", "any"}:
                errors.append(f"release scenario {scenario_id} call {index} has invalid metric_scope")
        selector = scenario.get("gold_selector", {})
        gold = [
            code for code, item in candidates.items()
            if (not selector.get("bucket") or item.get("bucket") == selector["bucket"])
            and (not selector.get("subtypes") or item.get("subtype") in selector["subtypes"])
            and item.get("relevance", 0) >= selector.get("minimum_global_relevance", 0)
        ]
        if len(gold) != selector.get("expected_count"):
            errors.append(
                f"release scenario {scenario_id} gold count is {len(gold)}, "
                f"expected {selector.get('expected_count')}"
            )
        expected_scenario_metrics = {
            "direct_overdue_days": {
                "p_at_20_lower_bound", "sampled_gold_recall_at_50",
                "known_hard_negative_pollution_at_20_lower_bound",
            },
            "broad_related": {
                "sampled_gold_recall_at_50", "ndcg_at_20_lower_bound",
                "known_hard_negative_pollution_at_20_lower_bound",
            },
        }[scenario_id]
        thresholds = scenario.get("thresholds")
        if not isinstance(thresholds, dict) or set(thresholds) != expected_scenario_metrics:
            errors.append(
                f"release scenario {scenario_id} thresholds must be exactly "
                f"{sorted(expected_scenario_metrics)}"
            )
        else:
            for metric, threshold in thresholds.items():
                if (
                    isinstance(threshold, bool)
                    or not isinstance(threshold, (int, float))
                    or not 0 <= threshold <= 1
                ):
                    errors.append(
                        f"release scenario {scenario_id}.{metric} threshold must be between 0 and 1"
                    )

    source_results = []
    source_snapshots = fixture.get("source_snapshots", [])
    if not isinstance(source_snapshots, list) or len(source_snapshots) != 4:
        errors.append("source_snapshots must contain exactly four entries")
    elif validate_sources:
        for source in source_snapshots:
            relative = source.get("path", "") if isinstance(source, dict) else ""
            path = root / relative
            if not path.is_file():
                errors.append(f"source snapshot does not exist: {relative}")
                continue
            digest = hashlib.sha256(path.read_bytes()).hexdigest()
            try:
                row_count = len(json.loads(path.read_text(encoding="utf-8")))
            except (OSError, json.JSONDecodeError) as error:
                errors.append(f"source snapshot cannot be parsed: {relative}: {error}")
                continue
            source_results.append({"path": relative, "sha256": digest, "row_count": row_count})
            if digest != source.get("sha256"):
                errors.append(f"source snapshot hash drifted: {relative}")
            if row_count != source.get("row_count"):
                errors.append(f"source snapshot row count drifted: {relative}")

    if errors:
        raise ValueError("fixture validation failed:\n- " + "\n- ".join(errors))
    return {
        "candidate_count": len(candidates),
        "bucket_counts": dict(bucket_counts),
        "query_count": len(queries),
        "category_counts": dict(category_counts),
        "release_scenario_count": len(scenarios),
        "release_question_count": len(queries),
        "source_snapshots_validated": len(source_results),
    }


def _deduplicate(values: Iterable[str]) -> List[str]:
    seen = set()
    result = []
    for value in values:
        if value and value not in seen:
            seen.add(value)
            result.append(value)
    return result


class SQLiteSearcher:
    def __init__(self, database: Path):
        self.connection = sqlite3.connect(str(database))
        self.connection.row_factory = sqlite3.Row
        tables = {row[0] for row in self.connection.execute("SELECT name FROM sqlite_master WHERE type='table'")}
        if "managed_features" not in tables:
            self.close()
            raise ValueError("database does not contain managed_features")
        self.semantic_tables = {
            "managed_feature_semantics", "managed_feature_tags", "managed_tags"
        }.issubset(tables)

    def search(self, call: Mapping[str, Any], limit: int) -> List[str]:
        terms = [str(value).strip() for value in call.get("keywords", []) if str(value).strip()]
        tags = [str(value).strip() for value in call.get("tags", []) if str(value).strip()]
        metric_scope = str(call.get("metric_scope", "any") or "any")
        if tags and not self.semantic_tables:
            raise ValueError("database does not contain semantic tag tables")
        fields = " || ' ' || ".join(
            f"coalesce(managed_features.{column}, '')" for column in (
                "feature_code", "feature_column_name", "feature_name", "feature_category",
                "business_subcategory_name", "group_name", "table_name",
            )
        )
        source = " FROM managed_features"
        if self.semantic_tables:
            source += " LEFT JOIN managed_feature_semantics semantic ON semantic.feature_code=managed_features.feature_code"
            fields += " || ' ' || coalesce(semantic.search_text_zh, '')"
        where_parts = [f"lower({fields}) LIKE lower(?)" for _ in terms]
        params: List[Any] = [f"%{term}%" for term in terms]
        for tag in tags:
            scope_clause = " AND relation.metric_scope=?" if metric_scope != "any" else ""
            where_parts.append(
                "EXISTS (SELECT 1 FROM managed_feature_tags relation "
                "JOIN managed_tags tag ON tag.tag_id=relation.tag_id "
                "WHERE relation.feature_code=managed_features.feature_code "
                "AND tag.code=?" + scope_clause + ")"
            )
            params.append(tag)
            if scope_clause:
                params.append(metric_scope)
        where = " AND ".join(where_parts) or "1=1"
        rows = self.connection.execute(
            f"SELECT managed_features.feature_code{source} WHERE {where} "
            "ORDER BY managed_features.feature_name, managed_features.feature_code LIMIT ?",
            tuple(params) + (limit,),
        ).fetchall()
        return [str(row["feature_code"]) for row in rows]

    def available_codes(self, codes: Sequence[str]) -> set[str]:
        found = set()
        for start in range(0, len(codes), 500):
            batch = codes[start:start + 500]
            placeholders = ",".join("?" for _ in batch)
            found.update(
                row[0] for row in self.connection.execute(
                    f"SELECT feature_code FROM managed_features WHERE feature_code IN ({placeholders})", batch
                )
            )
        return found

    def close(self) -> None:
        self.connection.close()


class ServiceSearcher:
    def __init__(self, database: Path):
        source_root = str(ROOT / "src")
        if source_root not in sys.path:
            sys.path.insert(0, source_root)
        from feature_copilot.service import FeatureService
        self.service = FeatureService(database)

    def search(self, call: Mapping[str, Any], limit: int) -> List[str]:
        keywords = [str(value).strip() for value in call.get("keywords", []) if str(value).strip()]
        tags = [str(value).strip() for value in call.get("tags", []) if str(value).strip()]
        filters: Dict[str, Any] = {}
        if tags:
            filters["tag"] = tags
        if call.get("metric_scope"):
            filters["metric_scope"] = call["metric_scope"]
        response = self.service.search(keywords, filters, limit=limit)
        identities = []
        for item in response.get("items", []):
            code = item.get("feature_code")
            if code:
                identities.append(str(code))
            else:
                identities.append("fixture:" + str(item.get("feature_id", item.get("feature_name", "unknown"))))
        return _deduplicate(identities)

    def available_codes(self, codes: Sequence[str]) -> set[str]:
        found = set()
        repository = self.service.repository
        for start in range(0, len(codes), 500):
            batch = codes[start:start + 500]
            placeholders = ",".join("?" for _ in batch)
            found.update(
                row["feature_code"] for row in repository.rows(
                    f"SELECT feature_code FROM managed_features WHERE feature_code IN ({placeholders})", batch
                )
            )
        return found

    def close(self) -> None:
        self.service.close()


def dcg(relevances: Sequence[int], limit: int) -> float:
    return sum((2 ** relevance - 1) / math.log2(index + 2) for index, relevance in enumerate(relevances[:limit]))


def _selector_codes(candidates: Mapping[str, Any], selector: Mapping[str, Any]) -> set[str]:
    return {
        code for code, item in candidates.items()
        if (not selector.get("bucket") or item["bucket"] == selector["bucket"])
        and (not selector.get("subtypes") or item["subtype"] in selector["subtypes"])
        and item["relevance"] >= selector.get("minimum_global_relevance", 0)
        and (selector.get("global_relevance") is None or item["relevance"] == selector["global_relevance"])
    }


def _run_calls(
    searcher: Any,
    calls: Sequence[Mapping[str, Any]],
    limit: int,
    judged_codes: set[str] | None = None,
) -> tuple[List[str], List[Dict[str, Any]]]:
    """Run a query plan and ordered-deduplicate the original full-corpus ranking.

    ``judged_codes`` is used only to annotate the trace.  In particular, it must
    never be used to filter or re-rank results before metric calculation: an
    unjudged production feature occupies a real rank and receives relevance 0.
    """
    judged_codes = judged_codes or set()
    merged: List[str] = []
    seen = set()
    contributions = []
    for index, call in enumerate(calls, 1):
        raw = _deduplicate(searcher.search(call, limit))
        incremental = [code for code in raw if code not in seen]
        merged.extend(incremental)
        seen.update(incremental)
        judged_incremental = [code for code in incremental if code in judged_codes]
        contributions.append({
            "call_index": index,
            "call": dict(call),
            "raw_result_count": len(raw),
            "incremental_result_count": len(incremental),
            "incremental_judged_count": len(judged_incremental),
            "merged_result_count_after_call": len(merged),
            "incremental_judged_codes": judged_incremental,
        })
    return merged, contributions


def _release_metrics(
    ranked: Sequence[str], gold: set[str], grades: Mapping[str, int], hard_negatives: set[str]
) -> Dict[str, float]:
    top20 = list(ranked[:20])
    top50 = list(ranked[:50])
    judged_top20 = [code for code in top20 if code in grades]
    judged_top50 = [code for code in top50 if code in grades]
    positive_top20 = sum(code in gold for code in top20)
    positive_top50 = sum(code in gold for code in top50)
    ideal = dcg(sorted(grades.values(), reverse=True), 20)
    return {
        # The fixture is sampled, not exhaustive.  Treating unjudged rows as
        # zero yields conservative lower bounds, not exact corpus precision.
        "p_at_20_lower_bound": positive_top20 / 20.0,
        "sampled_gold_recall_at_50": (
            sum(code in gold for code in ranked[:50]) / len(gold) if gold else 0.0
        ),
        "ndcg_at_20_lower_bound": (
            dcg([grades.get(code, 0) for code in ranked], 20) / ideal if ideal else 0.0
        ),
        "judgment_coverage_at_20": len(judged_top20) / len(top20) if top20 else 0.0,
        "judgment_coverage_at_50": len(judged_top50) / len(top50) if top50 else 0.0,
        "precision_among_judged_at_20": (
            positive_top20 / len(judged_top20) if judged_top20 else 0.0
        ),
        "precision_among_judged_at_50": (
            positive_top50 / len(judged_top50) if judged_top50 else 0.0
        ),
        "known_hard_negative_pollution_at_20_lower_bound": (
            sum(code in hard_negatives for code in top20) / len(top20) if top20 else 0.0
        ),
    }


def _evaluate_release_gate(
    fixture: Mapping[str, Any], searcher: Any, candidate_pool: set[str]
) -> Dict[str, Any]:
    candidates = fixture["candidates"]
    hard_negatives = {code for code, item in candidates.items() if item["bucket"] == "hard_negative"}
    limit = int(fixture["release_gate"]["retrieval_limit_per_call"])
    results = []
    for scenario in fixture["release_gate"]["scenarios"]:
        ranked, contributions = _run_calls(
            searcher, scenario["calls"], limit, judged_codes=candidate_pool
        )
        gold = _selector_codes(candidates, scenario["gold_selector"])
        grades = {code: int(item["relevance"]) for code, item in candidates.items()}
        metrics = _release_metrics(ranked, gold, grades, hard_negatives)
        retrieved_gold = gold.intersection(ranked[:50])
        final_top50 = set(ranked[:50])
        for contribution in contributions:
            incremental = set(contribution["incremental_judged_codes"])
            contribution["incremental_gold_count"] = len(incremental.intersection(gold))
            contribution["incremental_hard_negative_count"] = len(incremental.intersection(hard_negatives))
            contribution["incremental_judged_count_in_final_top_50"] = len(
                incremental.intersection(final_top50)
            )
            contribution["incremental_gold_count_in_final_top_50"] = len(
                incremental.intersection(retrieved_gold)
            )
        checks = {}
        for metric, threshold in scenario["thresholds"].items():
            comparator = "<=" if "pollution" in metric else ">="
            passed = metrics[metric] <= threshold if comparator == "<=" else metrics[metric] >= threshold
            checks[metric] = {
                "actual": metrics[metric], "comparator": comparator,
                "threshold": threshold, "passed": passed,
            }
        results.append({
            "id": scenario["id"],
            "passed": all(item["passed"] for item in checks.values()),
            "gold_count": len(gold),
            "retrieved_gold_at_50": len(retrieved_gold),
            "missing_gold_at_50": sorted(gold - retrieved_gold),
            "raw_ranked_result_count": len(ranked),
            "judged_result_count": sum(code in candidate_pool for code in ranked),
            "call_contributions": contributions,
            "top_50": list(ranked[:50]),
            "metrics": metrics,
            "checks": checks,
        })
    maximum_pollution = max(
        item["metrics"]["known_hard_negative_pollution_at_20_lower_bound"]
        for item in results
    )
    pollution_check = {
        "actual": maximum_pollution, "comparator": "<=", "threshold": 0.10,
        "passed": maximum_pollution <= 0.10,
    }
    return {
        "passed": all(item["passed"] for item in results) and pollution_check["passed"],
        "note": (
            "Metrics use the unfiltered full-corpus ranking. P@20/nDCG and known-hard-negative "
            "pollution are lower bounds; Recall@50 covers the sampled gold only."
        ),
        "known_hard_negative_pollution_gate": pollution_check,
        "scenarios": results,
    }


def _question_plan(
    fixture: Mapping[str, Any],
    query: Mapping[str, Any],
    searcher: Any,
    judged_codes: set[str],
) -> tuple[List[str], List[Dict[str, Any]], str]:
    """Replay one deterministic, non-gold-aware representative Skill path.

    Complex questions are not required to succeed as one rigid AND query.  We
    try that high-precision form first; only if the full corpus returns nothing
    do we relax one phrase at a time, longest first, stopping at the first
    non-empty result.  This uses result emptiness, never gold labels, to decide.
    """
    main_limit = int(fixture["release_gate"]["retrieval_limit_per_call"])
    fallback_limit = int(fixture["release_gate"]["question_suite"]["fallback_limit"])
    exact_call = {
        "keywords": list(query["search_terms"]), "tags": [], "metric_scope": "any",
    }
    ranked, trace = _run_calls(searcher, [exact_call], main_limit, judged_codes)
    trace[0]["plan_stage"] = "exact_terms_and"
    if ranked or query["category"] == "no_result":
        return ranked, trace, "exact_terms_and"

    attempted = set()
    for term in sorted(query["search_terms"], key=lambda value: (-len(value), value)):
        if term in attempted:
            continue
        attempted.add(term)
        fallback_call = {"keywords": [term], "tags": [], "metric_scope": "any"}
        fallback_ranked, fallback_trace = _run_calls(
            searcher, [fallback_call], fallback_limit, judged_codes
        )
        fallback_trace[0]["plan_stage"] = "single_term_fallback"
        trace.extend(fallback_trace)
        if fallback_ranked:
            return fallback_ranked, trace, "single_term_fallback"
    return [], trace, "fallback_exhausted"


def _evaluate_question_suite(
    fixture: Mapping[str, Any], searcher: Any, candidate_pool: set[str]
) -> Dict[str, Any]:
    """Gate all 36 Chinese questions by scenario category on full-corpus ranks."""
    candidates = fixture["candidates"]
    hard_negatives = {code for code, item in candidates.items() if item["bucket"] == "hard_negative"}
    category_rows: Dict[str, List[Dict[str, Any]]] = {
        category: [] for category in EXPECTED_CATEGORIES
    }
    per_query: List[Dict[str, Any]] = []
    total_hard_negatives = 0
    total_answerable_top20 = 0

    for query in fixture["lexical_diagnostics"]:
        ranked, trace, strategy = _question_plan(fixture, query, searcher, candidate_pool)
        judgments = {
            code: int(item["relevance"]) for code, item in query["judgments"].items()
        }
        positives = {code for code, relevance in judgments.items() if relevance > 0}
        top20 = list(ranked[:20])
        hard_negative_count = sum(code in hard_negatives for code in top20)
        row: Dict[str, Any] = {
            "id": query["id"],
            "category": query["category"],
            "question": query["question"],
            "strategy_used": strategy,
            "raw_result_count": len(ranked),
            "judged_result_count": sum(code in candidate_pool for code in ranked),
            "hard_negative_count_at_20": hard_negative_count,
            "trace": trace,
            "top_20": top20,
        }
        if positives:
            ideal = dcg(sorted(judgments.values(), reverse=True), 20)
            judged_top20 = [code for code in top20 if code in judgments]
            positive_top20 = sum(code in positives for code in top20)
            row.update({
                "sampled_query_hit_at_20": float(bool(positive_top20)),
                "p_at_20_lower_bound": positive_top20 / 20.0,
                "sampled_gold_recall_at_50": (
                    sum(code in positives for code in ranked[:50]) / len(positives)
                ),
                "ndcg_at_20_lower_bound": (
                    dcg([judgments.get(code, 0) for code in ranked], 20) / ideal if ideal else 0.0
                ),
                "judgment_coverage_at_20": (
                    len(judged_top20) / len(top20) if top20 else 0.0
                ),
                "precision_among_judged_at_20": (
                    positive_top20 / len(judged_top20) if judged_top20 else 0.0
                ),
                "missing_positive_at_50": sorted(positives - set(ranked[:50])),
            })
            total_hard_negatives += hard_negative_count
            total_answerable_top20 += len(top20)
        else:
            row["raw_nonempty"] = float(bool(ranked))
        category_rows[query["category"]].append(row)
        per_query.append(row)

    configured_thresholds = fixture["release_gate"]["question_suite"]["category_thresholds"]
    categories = []
    for category in EXPECTED_CATEGORIES:
        rows = category_rows[category]
        if category == "no_result":
            metrics = {
                "raw_nonempty_rate": sum(row["raw_nonempty"] for row in rows) / len(rows)
            }
        else:
            metrics = {
                "sampled_query_hit_rate_at_20": (
                    sum(row["sampled_query_hit_at_20"] for row in rows) / len(rows)
                ),
                "macro_sampled_gold_recall_at_50": (
                    sum(row["sampled_gold_recall_at_50"] for row in rows) / len(rows)
                ),
                "macro_ndcg_at_20_lower_bound": (
                    sum(row["ndcg_at_20_lower_bound"] for row in rows) / len(rows)
                ),
                "macro_judgment_coverage_at_20": (
                    sum(row["judgment_coverage_at_20"] for row in rows) / len(rows)
                ),
                "macro_precision_among_judged_at_20": (
                    sum(row["precision_among_judged_at_20"] for row in rows) / len(rows)
                ),
            }
        checks = {}
        for metric, threshold in configured_thresholds[category].items():
            comparator = "<=" if metric == "raw_nonempty_rate" else ">="
            passed = metrics[metric] <= threshold if comparator == "<=" else metrics[metric] >= threshold
            checks[metric] = {
                "actual": metrics[metric], "comparator": comparator,
                "threshold": threshold, "passed": passed,
            }
        categories.append({
            "category": category,
            "question_count": len(rows),
            "threshold_rationale": fixture["release_gate"]["question_suite"][
                "threshold_rationale"
            ][category],
            "passed": all(check["passed"] for check in checks.values()),
            "metrics": metrics,
            "checks": checks,
        })

    pollution = (
        total_hard_negatives / total_answerable_top20 if total_answerable_top20 else 0.0
    )
    pollution_threshold = fixture["release_gate"]["question_suite"]["global_thresholds"][
        "known_hard_negative_pollution_at_20_lower_bound"
    ]
    pollution_check = {
        "actual": pollution, "comparator": "<=", "threshold": pollution_threshold,
        "passed": pollution <= pollution_threshold,
    }
    return {
        "passed": all(item["passed"] for item in categories) and pollution_check["passed"],
        "question_count": len(per_query),
        "planning_contract": fixture["release_gate"]["question_suite"]["coverage_contract"],
        "ranking_contract": (
            "Full-corpus ranks are scored before any gold lookup. P@20/nDCG are conservative "
            "lower bounds with unjudged rows scored zero; Recall@50 is sampled-gold recall; "
            "pollution counts sampled known hard negatives and is also a lower bound."
        ),
        "known_hard_negative_pollution_gate": pollution_check,
        "categories": categories,
        "per_query": per_query,
    }


def _evaluate_lexical_diagnostics(
    fixture: Mapping[str, Any], searcher: Any, candidate_pool: set[str]
) -> Dict[str, Any]:
    """Measure deterministic term-AND behavior; this is not an end-to-end LLM gate."""
    hard_negatives = {
        code for code, item in fixture["candidates"].items() if item["bucket"] == "hard_negative"
    }
    per_query = []
    answerable_metrics = []
    total_hard, total_top20 = 0, 0
    no_result_with_hits = 0
    no_result_count = 0
    limit = int(fixture["release_gate"]["retrieval_limit_per_call"])
    for query in fixture["lexical_diagnostics"]:
        call = {"keywords": query["search_terms"], "tags": [], "metric_scope": "any"}
        ranked, _ = _run_calls(searcher, [call], limit, judged_codes=candidate_pool)
        ranked = ranked[:50]
        relevance = {code: item["relevance"] for code, item in query["judgments"].items()}
        positive = {code for code, grade in relevance.items() if grade > 0}
        top20 = ranked[:20]
        hard_count = sum(code in hard_negatives for code in top20)
        total_hard += hard_count
        total_top20 += len(top20)
        row: Dict[str, Any] = {
            "id": query["id"], "category": query["category"],
            "result_count_at_50": len(ranked), "hard_negative_count_at_20": hard_count,
        }
        if positive:
            ideal = dcg(sorted(relevance.values(), reverse=True), 20)
            row.update({
                "p_at_20_lower_bound": sum(code in positive for code in top20) / 20.0,
                "sampled_gold_recall_at_50": (
                    sum(code in positive for code in ranked) / len(positive)
                ),
                "ndcg_at_20_lower_bound": (
                    dcg([relevance.get(code, 0) for code in ranked], 20) / ideal if ideal else 0.0
                ),
            })
            answerable_metrics.append(row)
        else:
            no_result_count += 1
            no_result_with_hits += bool(ranked)
            row["no_result_has_hits"] = bool(ranked)
        per_query.append(row)

    def mean(key: str) -> float:
        return sum(row[key] for row in answerable_metrics) / len(answerable_metrics)

    return {
        "is_release_gate": False,
        "scope_note": "Strict keyword-AND diagnostics only; not an end-to-end LLM evaluation.",
        "aggregate": {
            "macro_p_at_20_lower_bound": mean("p_at_20_lower_bound"),
            "macro_sampled_gold_recall_at_50": mean("sampled_gold_recall_at_50"),
            "macro_ndcg_at_20_lower_bound": mean("ndcg_at_20_lower_bound"),
            "known_hard_negative_pollution_at_20_lower_bound": (
                total_hard / total_top20 if total_top20 else 0.0
            ),
            "no_result_raw_nonempty_rate": (
                no_result_with_hits / no_result_count if no_result_count else 0.0
            ),
        },
        "evaluated_answerable_queries": len(answerable_metrics),
        "evaluated_no_result_queries": no_result_count,
        "per_query": per_query,
    }


def evaluate(fixture: Mapping[str, Any], searcher: Any, strict_candidates: bool) -> Dict[str, Any]:
    candidate_codes = list(fixture["candidates"])
    candidate_pool = set(candidate_codes)
    available = searcher.available_codes(candidate_codes)
    missing = sorted(set(candidate_codes) - available)
    if strict_candidates and missing:
        raise ValueError(f"database is missing {len(missing)} fixture candidates; first: {missing[0]}")
    release_gate = _evaluate_release_gate(fixture, searcher, candidate_pool)
    question_suite = _evaluate_question_suite(fixture, searcher, candidate_pool)
    release_gate["question_suite"] = question_suite
    release_gate["passed"] = release_gate["passed"] and question_suite["passed"]
    return {
        "release_gate": release_gate,
        "lexical_diagnostics": _evaluate_lexical_diagnostics(fixture, searcher, candidate_pool),
        "database_candidate_coverage": len(available) / len(candidate_codes),
        "missing_candidate_count": len(missing),
        "missing_candidates": missing,
    }


def render_text(report: Mapping[str, Any], include_per_query: bool) -> str:
    gate = report["release_gate"]
    lexical = report["lexical_diagnostics"]
    lines = [
        "Chinese overdue-day semantic-search evaluation",
        f"Release gate: {'PASS' if gate['passed'] else 'FAIL'}",
        f"Database candidate coverage: {report['database_candidate_coverage']:.6f}",
    ]
    for scenario in gate["scenarios"]:
        metrics = scenario["metrics"]
        lines.append(
            f"{scenario['id']}: {'PASS' if scenario['passed'] else 'FAIL'}; "
            f"P@20-LB={metrics['p_at_20_lower_bound']:.6f}; "
            f"sampled Recall@50={metrics['sampled_gold_recall_at_50']:.6f}; "
            f"nDCG@20-LB={metrics['ndcg_at_20_lower_bound']:.6f}; "
            f"judgment coverage@20={metrics['judgment_coverage_at_20']:.6f}; "
            f"judgment coverage@50={metrics['judgment_coverage_at_50']:.6f}; "
            f"judged Precision@20={metrics['precision_among_judged_at_20']:.6f}; "
            f"known hard-negative pollution@20-LB="
            f"{metrics['known_hard_negative_pollution_at_20_lower_bound']:.6f}"
        )
    question_suite = gate["question_suite"]
    lines.append(
        f"36-question scenario gate: {'PASS' if question_suite['passed'] else 'FAIL'}; "
        f"known hard-negative pollution@20-LB="
        f"{question_suite['known_hard_negative_pollution_gate']['actual']:.6f}"
    )
    for category in question_suite["categories"]:
        metrics = category["metrics"]
        metric_text = "; ".join(f"{key}={value:.6f}" for key, value in metrics.items())
        lines.append(
            f"question/{category['category']}: {'PASS' if category['passed'] else 'FAIL'}; "
            f"{metric_text}"
        )
    aggregate = lexical["aggregate"]
    lines.extend([
        "",
        "Lexical diagnostics (strict keyword-AND; NOT a release gate)",
        f"Macro P@20 lower bound: {aggregate['macro_p_at_20_lower_bound']:.6f}",
        f"Macro sampled-gold Recall@50: {aggregate['macro_sampled_gold_recall_at_50']:.6f}",
        f"Macro nDCG@20 lower bound: {aggregate['macro_ndcg_at_20_lower_bound']:.6f}",
        "Known hard-negative pollution@20 lower bound: "
        f"{aggregate['known_hard_negative_pollution_at_20_lower_bound']:.6f}",
        f"No-result raw non-empty rate: {aggregate['no_result_raw_nonempty_rate']:.6f}",
    ])
    if include_per_query:
        lines.append("")
        lines.append("id\tcategory\tP@20\tRecall@50\tnDCG@20\thard-neg@20\tresults@50")
        for row in lexical["per_query"]:
            lines.append("\t".join([
                row["id"], row["category"],
                f"{row.get('p_at_20_lower_bound', 0.0):.4f}",
                f"{row.get('sampled_gold_recall_at_50', 0.0):.4f}",
                f"{row.get('ndcg_at_20_lower_bound', 0.0):.4f}",
                str(row["hard_negative_count_at_20"]),
                str(row["result_count_at_50"]),
            ]))
    return "\n".join(lines)


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--fixture", type=Path, default=DEFAULT_FIXTURE)
    parser.add_argument("--database", type=Path, help="path to an already-built SQLite index")
    parser.add_argument("--backend", choices=("service", "sqlite"), default="service")
    parser.add_argument("--format", choices=("json", "text"), default="json")
    parser.add_argument("--per-query", action="store_true", help="include per-query details")
    parser.add_argument("--validate-only", action="store_true")
    parser.add_argument("--skip-source-validation", action="store_true")
    parser.add_argument("--allow-missing-candidates", action="store_true")
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(argv)
    fixture = load_fixture(args.fixture)
    validation = validate_fixture(fixture, ROOT, not args.skip_source_validation)
    if args.validate_only:
        print(json.dumps({"status": "OK", "validation": validation}, ensure_ascii=False, indent=2))
        return 0
    if args.database is None:
        raise ValueError("--database is required unless --validate-only is used")
    if not args.database.is_file():
        raise ValueError(f"database does not exist: {args.database}")
    searcher = ServiceSearcher(args.database) if args.backend == "service" else SQLiteSearcher(args.database)
    try:
        report = evaluate(fixture, searcher, strict_candidates=not args.allow_missing_candidates)
    finally:
        searcher.close()
    report["backend"] = args.backend
    report["database"] = str(args.database)
    report["validation"] = validation
    if not args.per_query:
        report["lexical_diagnostics"].pop("per_query", None)
        report["release_gate"]["question_suite"].pop("per_query", None)
    if args.format == "json":
        print(json.dumps(report, ensure_ascii=False, indent=2))
    else:
        print(render_text(report, args.per_query))
    return 0 if report["release_gate"]["passed"] else 1


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ValueError, sqlite3.Error) as error:
        print(f"ERROR: {error}", file=sys.stderr)
        raise SystemExit(2)
