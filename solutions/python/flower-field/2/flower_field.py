"""Flower field annotation module for counting adjacent flowers."""

def annotate(garden):
    """
    Annotates a flower garden board by replacing each empty square with
    the number of adjacent flowers ('*'), or leaving it empty if zero.

    Args:
        garden: A list of strings representing the garden rows.
                Each string contains only ' ' (empty) or '*' (flower).

    Returns:
        A list of strings with the annotated garden.

    Raises:
        ValueError: If the input is malformed (rows of different lengths,
                    or invalid characters).
    """
    # Validate input
    if not isinstance(garden, list) or not all(isinstance(row, str) for row in garden):
        raise ValueError('The board is invalid with current input.')

    if garden:
        num_rows = len(garden)
        num_cols = len(garden[0])
        # Check all rows have the same length and contain only valid chars
        for row_index, row in enumerate(garden):
            if len(row) != num_cols:
                raise ValueError('The board is invalid with current input.')
            for col_index, ch in enumerate(row):
                if ch not in (' ', '*'):
                    raise ValueError('The board is invalid with current input.')
    else:
        return []  # empty garden is valid, return empty list

    # Convert to a list of lists of characters for easy modification
    result = [list(row) for row in garden]

    # Directions for adjacent cells: 8 compass directions
    directions = [(-1, -1), (-1, 0), (-1, 1),
                  (0, -1),           (0, 1),
                  (1, -1),  (1, 0),  (1, 1)]

    for row_index in range(num_rows):
        for col_index in range(num_cols):
            if garden[row_index][col_index] == ' ':
                # Count adjacent flowers
                count = 0
                for drow, dcol in directions:
                    nrow, ncol = row_index + drow, col_index + dcol
                    if 0 <= nrow < num_rows and 0 <= ncol < num_cols:
                        if garden[nrow][ncol] == '*':
                            count += 1
                if count > 0:
                    result[row_index][col_index] = str(count)
            # else it's a flower, keep as '*'

    # Convert back to list of strings
    return [''.join(row) for row in result]