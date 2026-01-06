def is_triangle(sides):
    """Check if three sides can form a valid triangle."""
    a, b, c = sides
    # All sides must be positive
    if a <= 0 or b <= 0 or c <= 0:
        return False
    # Triangle inequality theorem
    return (a + b >= c) and (b + c >= a) and (a + c >= b)


def equilateral(sides):
    """Check if triangle is equilateral (all sides equal)."""
    if not is_triangle(sides):
        return False
    a, b, c = sides
    return a == b == c


def isosceles(sides):
    """Check if triangle is isosceles (at least two sides equal)."""
    if not is_triangle(sides):
        return False
    a, b, c = sides
    return a == b or b == c or a == c


def scalene(sides):
    """Check if triangle is scalene (all sides different)."""
    if not is_triangle(sides):
        return False
    a, b, c = sides
    return a != b and b != c and a != c