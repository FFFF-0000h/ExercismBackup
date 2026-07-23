"""Calculate the number of grains of wheat on a chessboard.

- The number of grains doubles on each successive square, starting from the first square.
"""


def square(number: int) -> int:
    """Calculate the number of grains on a specific square.

    The first square has 1 grain, and each subsequent square doubles
    the previous amount: 1, 2, 4, 8, 16, ...

    :param number: int - The square number (1-64).
    :return: int - The number of grains on that square.
    :raises ValueError: If the square is not between 1 and 64.
    """
    if number < 1 or number > 64:
        raise ValueError("square must be between 1 and 64")
    return 2 ** (number - 1)

def total() -> int:
    """Calculate the total grains on all 64 squares.

    Uses the mathematical identity that the sum of powers of 2
    from 2^0 (first square) to 2^(n-1) (where n is the number of squares) equals 2^n - 1.

    :return: int - The sum of grains on every square.
    """
    return 2 ** 64 - 1