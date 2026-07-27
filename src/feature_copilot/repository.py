import sqlite3
from pathlib import Path
from typing import Any, Dict, List, Sequence

from .errors import IndexUnavailableError


class Repository:
    def __init__(self, database_path: Path):
        if not database_path.exists():
            raise IndexUnavailableError("index does not exist; run build-index")
        self.connection = sqlite3.connect(str(database_path))
        self.connection.row_factory = sqlite3.Row

    def close(self) -> None:
        self.connection.close()

    def rows(self, sql: str, params: Sequence[Any] = ()) -> List[Dict[str, Any]]:
        return [dict(row) for row in self.connection.execute(sql, params).fetchall()]

    def row(self, sql: str, params: Sequence[Any] = ()) -> Dict[str, Any]:
        found = self.connection.execute(sql, params).fetchone()
        return dict(found) if found else {}
