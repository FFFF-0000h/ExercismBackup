"""Provide the 'two-fer' dialogue."""


def two_fer(name: str = "you") -> str:
    """Return the two-fer dialogue for the given name.

    Args:
        name: The name of the person to give the extra cookie to.
              Defaults to "you".

    Returns:
        A string of the form "One for <name>, one for me."
    """
    return f"One for {name}, one for me."