"""Calculate the moment one gigasecond after a given moment."""

from datetime import datetime, timedelta


def add(moment: datetime) -> datetime:
    """Return the datetime one gigasecond after the given moment.

    Args:
        moment: The starting datetime.

    Returns:
        A new datetime one gigasecond (1e9 seconds) later.
    """
    gigasecond = timedelta(seconds=1_000_000_000)
    return moment + gigasecond