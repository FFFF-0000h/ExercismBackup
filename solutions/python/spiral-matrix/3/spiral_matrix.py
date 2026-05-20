"""Spiral matrix generation module."""

def spiral_matrix(matrix_size):
    """Return a square matrix of given size filled in clockwise spiral order.

    Args:
        matrix_size: size of the square matrix (0 returns an empty list).

    Returns:
        A list of lists representing the spiral matrix.
    """
    if matrix_size == 0:
        return []

    matrix = [[0] * matrix_size for __ in range(matrix_size)]
    # Right, down, left, up
    direction_offsets = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    direction_index = 0
    current_row, current_col = 0, 0

    for current_number in range(1, matrix_size * matrix_size + 1):
        matrix[current_row][current_col] = current_number

        delta_row, delta_col = direction_offsets[direction_index]
        next_row = current_row + delta_row
        next_col = current_col + delta_col

        # If next cell is out of bounds or already filled, change direction
        if (next_row < 0 or next_row >= matrix_size or
            next_col < 0 or next_col >= matrix_size or
            matrix[next_row][next_col] != 0):
            direction_index = (direction_index + 1) % 4
            delta_row, delta_col = direction_offsets[direction_index]
            next_row = current_row + delta_row
            next_col = current_col + delta_col

        current_row, current_col = next_row, next_col

    return matrix