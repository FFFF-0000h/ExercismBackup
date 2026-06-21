"""Calculate the sum of unique multiples of given factors below a limit."""


def sum_of_multiples(limit: int, multiples: list[int]) -> int:
    """Return the sum of all unique multiples of the given factors below limit.

    Args:
        limit: The upper bound (exclusive).
        multiples: A list of base values (factors).

    Returns:
        The sum of all unique multiples of the factors less than limit.
    """
    unique_multiples = set()

    for factor in multiples:
        if factor == 0:
            continue
        for value in range(factor, limit, factor):
            unique_multiples.add(value)

    return sum(unique_multiples)