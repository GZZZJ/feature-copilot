import shutil
from pathlib import Path

import pytest

from feature_copilot.index_builder import build_index
from feature_copilot.service import FeatureService

ROOT = Path(__file__).resolve().parents[1]


@pytest.fixture
def kb(tmp_path):
    knowledge = tmp_path / "knowledge"; shutil.copytree(ROOT / "knowledge", knowledge)
    database = tmp_path / "feature_copilot.sqlite"; build_index(knowledge, database, ROOT)
    return knowledge, database


@pytest.fixture
def service(kb):
    instance = FeatureService(kb[1]); yield instance; instance.close()
