from dataclasses import dataclass, asdict
from typing import Any, Dict


@dataclass(frozen=True)
class Finding:
    severity: str
    code: str
    message: str
    file: str = ""
    row: int = 0

    def to_dict(self) -> Dict[str, Any]:
        return asdict(self)


FEATURE_COLUMNS = [
    "feature_id", "feature_name", "cn_meaning", "technical_definition", "formula", "source_table",
    "category", "owner_team", "applicable_scene", "population", "sample_scope", "grain", "time_window",
    "stat_method", "derive_type", "logic_ref", "status", "version", "synced_at", "definition_source",
    "definition_confidence",
]
TABLE_COLUMNS = ["table_id", "table_name", "cn_name", "description", "category", "grain", "update_frequency", "owner_team", "applicable_scene", "population", "derive_type", "logic_ref", "status", "synced_at"]
PERFORMANCE_COLUMNS = ["record_id", "feature_id", "feature_name", "project", "model_version", "population", "label_definition", "observation_period", "performance_period", "eval_date", "iv", "importance", "psi", "auc_delta", "ks_delta", "tail_1pct_lift", "tail_5pct_lift", "tail_10pct_lift", "conclusion", "exclusion_reason", "source_ref"]
AVAILABILITY_COLUMNS = ["record_id", "feature_id", "feature_name", "scene", "population", "product", "available_from", "available_to", "observation_timing", "availability_status", "restriction", "evidence_ref", "updated_at"]

ENUMS = {
    "status": {"active", "deprecated", "draft"},
    "definition_source": {"sql", "python", "dictionary", "manual_confirmed", "name_inference"},
    "definition_confidence": {"verified", "reviewed", "unverified"},
    "availability_status": {"available", "unavailable", "conditional", "unknown"},
}
