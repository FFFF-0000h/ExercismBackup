"""Recite the nursery rhyme 'This is the House that Jack Built'."""

def recite(start_verse: int, end_verse: int) -> list[str]:
    """
    Return a list of verses from start_verse to end_verse inclusive.

    Each verse is a complete sentence of the rhyme, with the first verse
    being "This is the house that Jack built.".
    """
    # Pairs of (noun, verb) for verses 2 through 12, in order.
    # Index 0 corresponds to verse 2, index 1 to verse 3, etc.
    verse_parts = [
        ("malt", "lay in"),
        ("rat", "ate"),
        ("cat", "killed"),
        ("dog", "worried"),
        ("cow with the crumpled horn", "tossed"),
        ("maiden all forlorn", "milked"),
        ("man all tattered and torn", "kissed"),
        ("priest all shaven and shorn", "married"),
        ("rooster that crowed in the morn", "woke"),
        ("farmer sowing his corn", "kept"),
        ("horse and the hound and the horn", "belonged to"),
    ]

    def build_phrase(verse_number: int) -> str:
        """Recursively construct the trailing phrase for a given verse."""
        if verse_number == 1:
            return "the house that Jack built."
        # verse_number 2 -> verse_parts[0], 3 -> [1], …
        noun, verb = verse_parts[verse_number - 2]
        previous_phrase = build_phrase(verse_number - 1)
        return f"the {noun} that {verb} {previous_phrase}"

    # Generate the requested range of verses
    verses = []
    for current_verse in range(start_verse, end_verse + 1):
        full_verse = f"This is {build_phrase(current_verse)}"
        verses.append(full_verse)

    return verses