"""Index lifecycle and request-scoped service access for the optional Web UI."""
from contextlib import contextmanager
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any, Callable, Dict, Iterator, Optional

from feature_copilot.cache import (
    default_database,
    index_needs_rebuild,
)
from feature_copilot.errors import IndexUnavailableError
from feature_copilot.index_builder import build_index
from feature_copilot.service import FeatureService


PROJECT_ROOT = Path(__file__).resolve().parents[2]
ServiceFactory = Callable[[Path], Any]
BuildFunction = Callable[[Path, Path, Path], Dict[str, object]]
StalenessCheck = Callable[[Path, Path, Path], bool]


@dataclass
class WebRuntime:
    """Holds index state without sharing SQLite connections across requests."""

    project_root: Path
    knowledge_dir: Path
    database_path: Path
    service_factory: ServiceFactory = FeatureService
    available: bool = False
    stale: bool = False
    build_error: Optional[str] = None
    build_report: Dict[str, object] = field(default_factory=dict)

    @contextmanager
    def service(self) -> Iterator[Any]:
        """Open and always close an independent service for one request."""
        if not self.available:
            raise IndexUnavailableError(self.build_error or "index is unavailable")
        instance = self.service_factory(self.database_path)
        try:
            yield instance
        finally:
            instance.close()

    def health(self) -> Dict[str, Any]:
        """Return bounded index metadata through the service abstraction."""
        payload: Dict[str, Any] = {
            "status": "UNAVAILABLE" if not self.available else ("DEGRADED" if self.stale else "OK"),
            "index": {
                "available": self.available,
                "stale": self.stale,
                "database": str(self.database_path),
                "build_error": self.build_error,
            },
        }
        if not self.available:
            return payload

        with self.service() as service:
            stats = service.stats()
        metadata = {
            item.get("key", ""): item.get("value")
            for item in stats.get("metadata", [])
            if item.get("key")
        }
        payload["index"].update(
            {
                "built_at": metadata.get("built_at"),
                "managed_feature_count": stats.get(
                    "managed_features", metadata.get("managed_feature_count", 0)
                ),
            }
        )
        return payload


def _probe_index(runtime: WebRuntime) -> bool:
    """Confirm an existing database can be used without querying SQLite here."""
    try:
        instance = runtime.service_factory(runtime.database_path)
        try:
            instance.stats()
        finally:
            instance.close()
        return True
    except Exception as error:  # startup state is reported through health/API
        if not runtime.build_error:
            runtime.build_error = str(error)
        return False


def bootstrap_runtime(
    project_root: Path = PROJECT_ROOT,
    knowledge_dir: Optional[Path] = None,
    database_path: Optional[Path] = None,
    service_factory: ServiceFactory = FeatureService,
    build_function: BuildFunction = build_index,
    staleness_check: StalenessCheck = index_needs_rebuild,
) -> WebRuntime:
    """Build a stale index, falling back to a readable old index on failure."""
    root = Path(project_root)
    knowledge = Path(knowledge_dir) if knowledge_dir is not None else root / "knowledge"
    database = (
        Path(database_path) if database_path is not None else default_database(root)
    )
    runtime = WebRuntime(root, knowledge, database, service_factory=service_factory)
    old_index_exists = database.is_file()

    try:
        needs_rebuild = staleness_check(database, knowledge, root)
    except Exception as error:
        needs_rebuild = True
        runtime.build_error = str(error)

    if needs_rebuild:
        try:
            runtime.build_report = build_function(knowledge, database, root)
            runtime.build_error = None
        except Exception as error:
            runtime.build_error = str(error)
            runtime.stale = old_index_exists
    if runtime.database_path.is_file() and _probe_index(runtime):
        runtime.available = True
        # A failed rebuild intentionally serves the last readable snapshot.
        runtime.stale = bool(runtime.build_error)
    else:
        runtime.available = False
        runtime.stale = False
        if not runtime.build_error:
            runtime.build_error = "index is unavailable"
    return runtime
