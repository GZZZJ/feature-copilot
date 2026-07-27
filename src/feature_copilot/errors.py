class FeatureKbError(Exception):
    """Base application error."""


class NotFoundError(FeatureKbError):
    """The requested object does not exist in the indexed knowledge."""


class ValidationError(FeatureKbError):
    """Source knowledge violates the data contract."""


class IndexUnavailableError(FeatureKbError):
    """The generated SQLite index cannot be opened."""
