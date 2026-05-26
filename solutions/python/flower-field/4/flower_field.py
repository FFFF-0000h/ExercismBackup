"""Flower field annotation module for counting adjacent flowers."""

def _validate_garden(garden):
    """Raise ValueError if garden is malformed, otherwise return dimensions."""
    if not isinstance(garden, list) or not all(isinstance(row, str) for row in garden):
        raise ValueError('The board is invalid with current input.')

    if not garden:
        return 0, 0

    row_count = len(garden)
    col_count = len(garden[0])

    # Check all rows have the same length and contain only valid characters
    invalid = any(
        len(row) != col_count or
        any(character not in (' ', '*') for character in row)
        for row in garden
    )
    if invalid:
        raise ValueError('The board is invalid with current input.')

    return row_count, col_count


def annotate(garden):
    """
    Annotate a flower garden board by replacing each empty square with
    the number of adjacent flowers, or leaving it empty if zero.

    Args:
        garden: A list of strings representing the garden rows.

    Returns:
        A list of strings with the annotated garden.

    Raises:
        ValueError: If the input is malformed.
    """
    num_rows, num_cols = _validate_garden(garden)
    if num_rows == 0:
        return []

    # --- Step 1: record all flower positions ---
    flower_positions = []
    for row_index in range(num_rows):
        for col_index in range(num_cols):
            if garden[row_index][col_index] == '*':
                flower_positions.append((row_index, col_index))

    # --- Step 2: count adjacent flowers for every square ---
    counts = []
    for row_index in range(num_rows):
        counts.append([0] * num_cols)

    directions = [
        (-1, -1), (-1, 0), (-1, 1),
        (0, -1),           (0, 1),
        (1, -1),  (1, 0),  (1, 1)
    ]

    for flower_row, flower_col in flower_positions:
        for delta_row, delta_col in directions:
            neighbor_row = flower_row + delta_row
            neighbor_col = flower_col + delta_col
            if (0 <= neighbor_row < num_rows and
                0 <= neighbor_col < num_cols):
                counts[neighbor_row][neighbor_col] += 1

    # --- Step 3: build the annotated garden ---
    result = []
    for row_index in range(num_rows):
        annotated_row = []
        for col_index in range(num_cols):
            if garden[row_index][col_index] == '*':
                annotated_row.append('*')
            else:
                count = counts[row_index][col_index]
                annotated_row.append(str(count) if count > 0 else ' ')
        result.append(''.join(annotated_row))

    return result