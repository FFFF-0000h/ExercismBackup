"""Transform legacy Scrabble score data into the new one-to-one format."""

from typing import Dict, List


def transform(legacy_data: Dict[int, List[str]]) -> Dict[str, int]:
    """Convert a legacy score-to-letters mapping into a letter-to-score mapping.

    Args:
        legacy_data: A dictionary mapping point values to lists of uppercase letters.

    Returns:
        A dictionary mapping each lowercase letter to its point value.
    """
    new_format: Dict[str, int] = {}

    for score, letters in legacy_data.items():
        for letter in letters:
            new_format[letter.lower()] = score

    return new_format