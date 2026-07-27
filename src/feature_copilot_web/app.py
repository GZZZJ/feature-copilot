"""Flask application for the optional read-only feature management UI."""
import argparse
import sqlite3
from typing import Any, Dict, Optional, Tuple, Union

from flask import Flask, Response, jsonify, redirect, render_template, request, url_for

from feature_copilot.errors import FeatureKbError

from .runtime import WebRuntime, bootstrap_runtime


PAGE_SIZES = (20, 50, 100)
MAX_QUERY_LENGTH = 512
MAX_SQLITE_OFFSET = (1 << 63) - 1
INDEX_ERRORS = (FeatureKbError, sqlite3.Error, OSError)


def _error(error: str, message: str, status_code: int) -> Tuple[Response, int]:
    return jsonify(status="ERROR", error=error, message=message), status_code


def _positive_integer(name: str, default: int) -> int:
    raw = _single_query_value(name)
    if raw is None:
        return default
    try:
        value = int(raw)
    except (TypeError, ValueError) as error:
        raise ValueError(f"{name} must be an integer") from error
    if value < 1:
        raise ValueError(f"{name} must be positive")
    return value


def _single_query_value(name: str) -> Optional[str]:
    values = request.args.getlist(name)
    if len(values) > 1:
        raise ValueError(f"{name} must not be repeated")
    return values[0] if values else None


def create_app(runtime: Optional[WebRuntime] = None) -> Flask:
    """Create an application with an injectable runtime for deterministic tests."""
    app = Flask(__name__)
    app.config["WEB_RUNTIME"] = runtime or bootstrap_runtime()
    app.config["TRUSTED_HOSTS"] = ["127.0.0.1", "localhost"]
    app.json.ensure_ascii = False

    @app.before_request
    def reject_untrusted_host() -> Optional[Tuple[Response, int]]:
        # Flask versions differ in when TRUSTED_HOSTS is enforced.  Keep the
        # loopback-only contract explicit because this UI has no remote surface.
        host = request.host.partition(":")[0].lower()
        if host not in app.config["TRUSTED_HOSTS"]:
            return _error("INVALID_HOST", "untrusted host", 400)
        return None

    @app.after_request
    def secure_response(response: Response) -> Response:
        response.headers["Content-Security-Policy"] = (
            "default-src 'self'; script-src 'self'; style-src 'self'; "
            "img-src 'self' data:; object-src 'none'; base-uri 'none'; "
            "frame-ancestors 'none'; form-action 'self'"
        )
        response.headers["X-Content-Type-Options"] = "nosniff"
        response.headers["X-Frame-Options"] = "DENY"
        response.headers["Referrer-Policy"] = "no-referrer"
        response.headers["Permissions-Policy"] = (
            "camera=(), microphone=(), geolocation=(), payment=()"
        )
        if request.path.startswith("/api/"):
            response.headers["Cache-Control"] = "no-store"
        return response

    def current_runtime() -> WebRuntime:
        return app.config["WEB_RUNTIME"]

    @app.get("/")
    def index() -> Response:
        return redirect(url_for("feature_list"))

    @app.get("/features")
    def feature_list() -> str:
        return render_template("list.html")

    @app.get("/features/<feature_key>")
    def feature_detail(feature_key: str) -> str:
        return render_template("detail.html", feature_key=feature_key)

    @app.get("/api/v1/features")
    def list_features() -> Union[Tuple[Response, int], Response]:
        web_runtime = current_runtime()
        if not web_runtime.available:
            return _error(
                "INDEX_UNAVAILABLE",
                web_runtime.build_error or "index is unavailable",
                503,
            )
        try:
            page = _positive_integer("page", 1)
            page_size = _positive_integer("page_size", 50)
            if page_size not in PAGE_SIZES:
                raise ValueError("page_size must be one of 20, 50, 100")
            query_values = {
                name: (_single_query_value(name) or "").strip()
                for name in (
                    "feature_key",
                    "feature_name",
                    "feature_category",
                    "business_subcategory",
                    "feature_group",
                    "feature_subcategory",
                )
            }
        except ValueError as error:
            return _error("INVALID_ARGUMENT", str(error), 400)

        feature_key = query_values["feature_key"]
        feature_name = query_values["feature_name"]
        feature_category = query_values["feature_category"]
        business_subcategory = query_values["business_subcategory"]
        feature_group = query_values["feature_group"]
        feature_subcategory = query_values["feature_subcategory"]
        too_long = [name for name, value in query_values.items() if len(value) > MAX_QUERY_LENGTH]
        if too_long:
            return _error(
                "INVALID_ARGUMENT",
                f"{', '.join(too_long)} must be at most {MAX_QUERY_LENGTH} characters",
                400,
            )
        if feature_group and feature_subcategory and feature_group != feature_subcategory:
            return _error(
                "INVALID_ARGUMENT",
                "feature_group conflicts with feature_subcategory",
                400,
            )
        effective_group = feature_group or feature_subcategory
        offset = (page - 1) * page_size
        if offset > MAX_SQLITE_OFFSET:
            return _error("INVALID_ARGUMENT", "page is too large", 400)
        try:
            with web_runtime.service() as service:
                if business_subcategory and not service.business_subcategory_exists(business_subcategory):
                    return _error(
                        "INVALID_ARGUMENT",
                        "business_subcategory does not exist: " + business_subcategory,
                        400,
                    )
                if effective_group and not service.feature_group_exists(effective_group):
                    return _error(
                        "INVALID_ARGUMENT",
                        "feature_group does not exist: " + effective_group,
                        400,
                    )
                if (
                    effective_group
                    and feature_category
                    and not service.feature_group_belongs_to_category(effective_group, feature_category)
                ):
                    return _error(
                        "INVALID_ARGUMENT",
                        "feature_group does not belong to feature_category",
                        400,
                    )
                result = service.list_managed_features(
                    feature_key=feature_key,
                    feature_name=feature_name,
                    feature_category=feature_category,
                    business_subcategory=business_subcategory,
                    feature_group=effective_group,
                    limit=page_size,
                    offset=offset,
                )
        except INDEX_ERRORS as error:
            return _error("INDEX_UNAVAILABLE", str(error), 503)

        total = int(result.get("total", 0))
        payload: Dict[str, Any] = {
            "status": "OK",
            "total": total,
            "page": page,
            "page_size": page_size,
            "items": result.get("items", []),
        }
        return jsonify(payload)

    @app.get("/api/v1/feature-taxonomy")
    def feature_taxonomy() -> Union[Tuple[Response, int], Response]:
        web_runtime = current_runtime()
        if not web_runtime.available:
            return _error(
                "INDEX_UNAVAILABLE",
                web_runtime.build_error or "index is unavailable",
                503,
            )
        try:
            with web_runtime.service() as service:
                result = service.list_managed_feature_taxonomy()
        except (ValueError,) + INDEX_ERRORS as error:
            return _error("INDEX_UNAVAILABLE", str(error), 503)
        return jsonify(result)

    @app.get("/api/v1/features/<feature_key>")
    def get_feature_detail(
        feature_key: str,
    ) -> Union[Tuple[Response, int], Response]:
        web_runtime = current_runtime()
        if len(feature_key) > MAX_QUERY_LENGTH:
            return _error(
                "INVALID_ARGUMENT",
                f"feature_key must be at most {MAX_QUERY_LENGTH} characters",
                400,
            )
        if not web_runtime.available:
            return _error(
                "INDEX_UNAVAILABLE",
                web_runtime.build_error or "index is unavailable",
                503,
            )
        try:
            with web_runtime.service() as service:
                result = service.get_managed_feature_detail(feature_key, max_depth=3)
        except INDEX_ERRORS as error:
            return _error("INDEX_UNAVAILABLE", str(error), 503)
        if result.get("status") == "NOT_FOUND":
            return _error(
                "FEATURE_NOT_FOUND", f"feature does not exist: {feature_key}", 404
            )
        # A partial logic chain is a valid feature detail, not a transport error.
        return jsonify(result)

    @app.get("/api/v1/health")
    def health() -> Union[Tuple[Response, int], Response]:
        web_runtime = current_runtime()
        try:
            payload = web_runtime.health()
        except Exception as error:
            return _error("INDEX_UNAVAILABLE", str(error), 503)
        return jsonify(payload), (200 if web_runtime.available else 503)

    return app


def _port(value: str) -> int:
    try:
        port = int(value)
    except ValueError as error:
        raise argparse.ArgumentTypeError("port must be an integer") from error
    if not 1 <= port <= 65535:
        raise argparse.ArgumentTypeError("port must be between 1 and 65535")
    return port


def main(argv: Any = None) -> int:
    parser = argparse.ArgumentParser(prog="feature-copilot-web")
    parser.add_argument("--port", type=_port, default=8765)
    args = parser.parse_args(argv)
    try:
        from waitress import serve
    except ModuleNotFoundError as error:
        raise SystemExit(
            "Web dependencies are not installed; run: pip install -e '.[web]'"
        ) from error
    application = create_app()
    serve(application, host="127.0.0.1", port=args.port)
    return 0
