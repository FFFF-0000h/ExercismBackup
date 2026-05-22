def spiral_matrix(size):
    """Generate a square matrix filled in a clockwise spiral order."""
    if size == 0:
        return []

    matrix = [[0] * size for _ in range(size)]
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]  # right, down, left, up
    row, col, dir_idx = 0, 0, 0

    for num in range(1, size * size + 1):
        matrix[row][col] = num
        next_row = row + directions[dir_idx][0]
        next_col = col + directions[dir_idx][1]

        # Check if the next cell is out of bounds or already filled
        if (next_row < 0 or next_row >= size or
            next_col < 0 or next_col >= size or
            matrix[next_row][next_col] != 0):
            dir_idx = (dir_idx + 1) % 4  # turn right
            next_row = row + directions[dir_idx][0]
            next_col = col + directions[dir_idx][1]

        row, col = next_row, next_col

    return matrix