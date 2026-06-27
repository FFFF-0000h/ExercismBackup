"""Generate lyrics for the song 'Ten Green Bottles'."""

_NUMBER_WORDS = [
    "no", "One", "Two", "Three", "Four",
    "Five", "Six", "Seven", "Eight", "Nine", "Ten"
]


def _bottle_word(count: int) -> str:
    """Return 'bottle' or 'bottles' based on count."""
    return "bottles" if count != 1 else "bottle"


def _verse(number: int) -> list[str]:
    """Return a single verse as a list of lines."""
    current_word = _NUMBER_WORDS[number]
    current_bottles = _bottle_word(number)

    next_number = number - 1
    next_word = _NUMBER_WORDS[next_number].lower()
    next_bottles = _bottle_word(next_number)

    return [
        f"{current_word} green {current_bottles} hanging on the wall,",
        f"{current_word} green {current_bottles} hanging on the wall,",
        "And if one green bottle should accidentally fall,",
        f"There'll be {next_word} green {next_bottles} hanging on the wall.",
    ]


def recite(start: int, take: int = 1) -> list[str]:
    """Return the lyrics for 'take' verses starting from 'start' bottles.

    Args:
        start: The number of bottles to start with (1-10).
        take: The number of verses to recite (default 1).

    Returns:
        A list of strings, each representing one line of the song.
    """
    result = []
    for offset in range(take):
        current = start - offset
        if offset > 0:
            result.append("")
        result.extend(_verse(current))
    return result