"""Calculate the difference between the square of the sum and the sum of squares."""


def square_of_sum(number: int) -> int:
    """Return the square of the sum of the first `number` natural numbers."""
    sum_of_n = number * (number + 1) // 2
    return sum_of_n ** 2


def sum_of_squares(number: int) -> int:
    """Return the sum of the squares of the first `number` natural numbers."""
    return number * (number + 1) * (2 * number + 1) // 6


def difference_of_squares(number: int) -> int:
    """Return the difference between the square of the sum and the sum of squares."""
    return square_of_sum(number) - sum_of_squares(number)