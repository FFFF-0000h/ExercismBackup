"""Diamond kata: create a diamond shape from 'A' up to the given letter."""

def rows(letter: str) -> list[str]:
    """
    Return a list of strings that form a diamond shape from 'A' to `letter`.

    The diamond is horizontally and vertically symmetric, with the given
    letter at the widest point. Each row (except the first and last) contains
    two identical letters separated by spaces, and the shape is padded with
    spaces to be a square.
    """
    if not letter.isalpha() or len(letter) != 1:
        raise ValueError("Input must be a single letter from A-Z or a-z.")
    letter = letter.upper()

    max_idx = ord(letter) - ord('A')
    width = 2 * max_idx + 1
    top_rows = []

    # Build the top half (including the middle row)
    for i in range(max_idx + 1):
        current_letter = chr(ord('A') + i)
        line = [' '] * width
        left_pos = max_idx - i
        right_pos = max_idx + i

        line[left_pos] = current_letter
        if i != 0:                     # no second letter for the first row
            line[right_pos] = current_letter

        top_rows.append(''.join(line))

    # The full diamond is the top half plus the reversed top half without the middle row
    bottom_rows = top_rows[-2::-1] if max_idx > 0 else []
    return top_rows + bottom_rows