def distance(strand_a: str, strand_b: str) -> int:
    """Return the Hamming distance between two DNA strands.

    The Hamming distance is the number of differing characters
    when comparing two sequences of equal length.

    Args:
        strand_a: A string consisting of characters C, A, G, T.
        strand_b: Another string of the same length.

    Returns:
        The number of positions at which the two strands differ.

    Raises:
        ValueError: If the input strands have different lengths.
    """
    if len(strand_a) != len(strand_b):
        raise ValueError("Strands must be of equal length.")
    
    hamming_distance = sum(1 for base_a, base_b in zip(strand_a, strand_b) if base_a != base_b)
    return hamming_distance