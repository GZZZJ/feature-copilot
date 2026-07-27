"""Optional Web management UI for feature-copilot.

Imports are deliberately lazy so installing the core package does not require
the ``web`` optional dependencies.
"""
from typing import Any


def create_app(*args: Any, **kwargs: Any) -> Any:
    """Create the Flask application when the Web extra is installed."""
    try:
        from .app import create_app as app_factory
    except ModuleNotFoundError as error:
        if error.name == "flask":
            raise RuntimeError(
                "Web dependencies are not installed; run: pip install -e '.[web]'"
            ) from error
        raise
    return app_factory(*args, **kwargs)


def main(argv: Any = None) -> int:
    """Run the local-only Web server."""
    try:
        from .app import main as app_main
    except ModuleNotFoundError as error:
        if error.name == "flask":
            raise SystemExit(
                "Web dependencies are not installed; run: pip install -e '.[web]'"
            ) from error
        raise
    return app_main(argv)


__all__ = ["create_app", "main"]
