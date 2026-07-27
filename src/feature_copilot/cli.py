import argparse
import datetime as dt
import sys
from pathlib import Path
from typing import Any, Dict

from .cache import default_database, index_needs_rebuild
from .errors import FeatureKbError, ValidationError
from .index_builder import build_index
from .logic_catalog import load_managed_catalog
from .renderers import render
from .service import FeatureService
from .validators import validate_knowledge


ROOT = Path(__file__).resolve().parents[2]
EXIT_OK, EXIT_VALIDATION, EXIT_NOT_FOUND, EXIT_RUNTIME = 0, 2, 3, 4


def _common(parser: argparse.ArgumentParser) -> None:
    parser.add_argument("--format", choices=("text", "json"), default="text")
    parser.add_argument("--limit", type=int, default=20)
    parser.add_argument("--offset", type=int, default=0)
    parser.add_argument("--full", action="store_true", help="reserved for callers that explicitly request full detail")


def parser() -> argparse.ArgumentParser:
    root = argparse.ArgumentParser(prog="feature-copilot", description="Local deterministic feature knowledge queries")
    root.add_argument("--data-dir", type=Path, default=ROOT / "knowledge", help="CSV fact-source directory")
    root.add_argument("--db", type=Path, default=default_database(ROOT), help="generated SQLite index")
    sub = root.add_subparsers(dest="command", required=True)
    get = sub.add_parser("get"); get.add_argument("feature_name"); get.add_argument("--version"); _common(get)
    search = sub.add_parser("search"); search.add_argument("keywords", nargs="*")
    for option in ("category", "table", "scene", "population", "owner", "status", "window", "derive-type", "package", "group"):
        search.add_argument("--" + option, dest=option.replace("-", "_"))
    search.add_argument("--tag", action="append", default=[], help="stable tag code or exact Chinese standard name; repeat for AND")
    search.add_argument("--metric-scope", choices=("primary", "related", "any"), default="any")
    _common(search)
    tags = sub.add_parser("tags"); tags.add_argument("keywords", nargs="*")
    tags.add_argument("--dimension", choices=("feature_role", "business_stage", "business", "metric", "time", "derivation"))
    _common(tags)
    table = sub.add_parser("table"); table.add_argument("table_name"); _common(table)
    lineage = sub.add_parser("lineage"); lineage.add_argument("table_name"); lineage.add_argument("--direction", choices=("forward", "reverse", "both"), default="forward"); lineage.add_argument("--max-depth", type=int, default=3); _common(lineage)
    compare = sub.add_parser("compare"); compare.add_argument("feature_names", nargs="+"); _common(compare)
    explain = sub.add_parser("explain-logic"); explain.add_argument("feature_code"); explain.add_argument("--max-depth", type=int, default=3, help="upstream table depth; default: 3"); _common(explain)
    audit = sub.add_parser("audit-logic"); audit.add_argument("--max-depth", type=int, default=20, help="audit traversal depth; default: 20"); _common(audit)
    perf = sub.add_parser("perf")
    for option in ("project", "model-version", "population", "conclusion", "category", "date-from", "date-to"):
        perf.add_argument("--" + option, dest=option.replace("-", "_"))
    perf.add_argument("--min-iv", type=float); perf.add_argument("--max-psi", type=float); perf.add_argument("--min-tail-lift", type=float); _common(perf)
    availability = sub.add_parser("availability"); availability.add_argument("feature_name"); availability.add_argument("--scene"); availability.add_argument("--population"); availability.add_argument("--product"); availability.add_argument("--observation-timing"); availability.add_argument("--as-of", help="ISO date for availability interval evaluation"); _common(availability)
    stats = sub.add_parser("stats"); _common(stats)
    validate = sub.add_parser("validate"); _common(validate)
    build = sub.add_parser("build-index"); _common(build)
    return root


def _emit(data: Any, args: argparse.Namespace) -> None:
    print(render(data, args.format))


def _build_index(args: argparse.Namespace) -> Dict[str, object]:
    """Build only at the selected package or explicitly supplied index path."""
    return build_index(args.data_dir, args.db, ROOT)


def main(argv: Any = None) -> int:
    raw_argv = list(sys.argv[1:] if argv is None else argv)
    args = parser().parse_args(raw_argv)
    if args.limit < 1 or args.offset < 0 or getattr(args, "max_depth", 1) < 1:
        _emit({"status": "ERROR", "message": "limit must be positive and offset non-negative"}, args); return EXIT_RUNTIME
    if getattr(args, "as_of", None):
        try: dt.date.fromisoformat(args.as_of)
        except ValueError:
            _emit({"status": "ERROR", "message": "as-of must be an ISO date"}, args); return EXIT_RUNTIME
    if args.command == "validate":
        findings = validate_knowledge(args.data_dir, ROOT)
        managed = {"checked": False}
        if args.data_dir.resolve() == (ROOT / "knowledge").resolve() and not any(f.severity == "ERROR" for f in findings):
            try:
                catalog = load_managed_catalog(ROOT, ROOT / "knowledge" / "config" / "maintenance_scope.json")
                managed = {"checked": True, "source_feature_rows": catalog["source_feature_rows"], "unique_features": len(catalog["features"]), "group_logic": len(catalog["group_logic"]), "dp_logic_nodes": len(catalog["dp_nodes"]), "taxonomy_audit": catalog["taxonomy_audit"], "semantic_audit": catalog.get("semantic_audit", {})}
            except ValidationError as error:
                managed = {"checked": True, "error": str(error)}
        status = "ERROR" if any(f.severity == "ERROR" for f in findings) or managed.get("error") else "OK"
        _emit({"status": status, "findings": [f.to_dict() for f in findings], "managed_catalog": managed}, args)
        return EXIT_VALIDATION if status == "ERROR" else EXIT_OK
    if args.command == "build-index":
        try:
            report = _build_index(args)
            _emit({"status": "OK", **report}, args); return EXIT_OK
        except ValidationError as error:
            _emit({"status": "ERROR", "error": "VALIDATION_ERROR", "details": str(error)}, args); return EXIT_VALIDATION
        except Exception as error:
            _emit({"status": "ERROR", "error": "BUILD_ERROR", "details": str(error)}, args); return EXIT_RUNTIME
    try:
        if index_needs_rebuild(args.db, args.data_dir, ROOT):
            _build_index(args)
        service = FeatureService(args.db)
        try:
            if args.command == "get": data = service.get(args.feature_name, args.version)
            elif args.command == "search": data = service.search(args.keywords, vars(args), 100000 if args.full else args.limit, args.offset)
            elif args.command == "tags": data = service.list_tags(args.keywords, args.dimension or "", 100000 if args.full else args.limit, args.offset)
            elif args.command == "table": data = service.table(args.table_name, 100000 if args.full else args.limit, args.offset)
            elif args.command == "lineage": data = service.lineage(args.table_name, args.direction, args.max_depth)
            elif args.command == "compare": data = service.compare(args.feature_names)
            elif args.command == "explain-logic": data = service.explain_logic(args.feature_code, args.max_depth, args.full)
            elif args.command == "audit-logic": data = service.audit_logic(args.max_depth)
            elif args.command == "perf": data = service.perf(vars(args), 100000 if args.full else args.limit, args.offset)
            elif args.command == "availability": data = service.availability(args.feature_name, args.scene, args.population, args.product, args.observation_timing, args.as_of)
            else: data = service.stats()
        finally:
            service.close()
        data["full_requested"] = args.full
        _emit(data, args)
        return EXIT_NOT_FOUND if data.get("status") == "NOT_FOUND" else EXIT_OK
    except FeatureKbError as error:
        _emit({"status": "ERROR", "error": str(error)}, args); return EXIT_RUNTIME
    except Exception as error:
        _emit({"status": "ERROR", "error": "AUTO_INDEX_ERROR", "details": str(error)}, args); return EXIT_RUNTIME


if __name__ == "__main__":
    raise SystemExit(main())
