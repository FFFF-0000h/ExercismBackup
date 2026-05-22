"""Flower field annotation module for counting adjacent flowers."""

def _validate_garden(garden):
    """Raise ValueError if garden is malformed, otherwise return dimensions."""
    if not isinstance(garden, list) or not all(isinstance(row, str) for row in garden):
        raise ValueError('The board is invalid with current input.')
    if not garden:
        return 0, 0
    row_count = len(garden)
    col_count = len(garden[0])
    # All rows must have the same length and contain only ' ' or '*'
    if any(len(row) != col_count or any(ch not in (' ', '*') for ch in row) for row in garden):
        raise ValueError('The board is invalid with current input.')
    return row_count, col_count


def annotate(garden):
    """
    Annotate a flower garden board by replacing each empty square with
    the number of adjacent flowers ('*'), or leaving it empty if zero.

    Args:
        garden: A list of strings representing the garden rows.
                Each string contains only ' ' (empty) or '*' (flower).

    Returns:
        A list of strings with the annotated garden.

    Raises:
        ValueError: If the input is malformed.
    """
    num_rows, num_cols = _validate_garden(garden)
    if num_rows == 0:
        return []

    # Convert to mutable form
    result = [list(row) for row in garden]

    # 8 possible adjacent directions
    directions = [(-1, -1), (-1, 0), (-1, 1),
                  (0, -1),           (0, 1),
                  (1, -1),  (1, 0),  (1, 1)]

    for r in range(num_rows):
        for c in range(num_cols):
            if garden[r][c] == ' ':
                # Count adjacent flowers
                cnt = 0
                for dr, dc in directions:
                    nr, nc = r + dr, c + dc
                    if 0 <= nr < num_rows and 0 <= nc < num_cols:
                        if garden[nr][nc] == '*':
                            cnt += 1
                if cnt > 0:
                    result[r][c] = str(cnt)

    return [''.join(row) for row in result]