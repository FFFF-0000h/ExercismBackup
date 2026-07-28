"""Evaluate the type of triangle"""


def is_triangle(sides):
    """Check if three sides can form a valid triangle."""
    
    a_Side, b_Side, c_Side = sides
    # All sides must be positive
    if a_Side <= 0 or b_Side <= 0 or c_Side <= 0:
        return False
    # Triangle inequality theorem
    return (a_Side + b_Side >= c_Side) and (b_Side + c_Side >= a_Side) and (a_Side + c_Side >= b_Side)


def equilateral(sides):
    """Check if triangle is equilateral (all sides equal)."""
    
    if not is_triangle(sides):
        return False
    a_Side, b_Side, c_Side = sides
    return a_Side == b_Side == c_Side


def isosceles(sides):
    """Check if triangle is isosceles (at least two sides equal)."""
    
    if not is_triangle(sides):
        return False
    a_Side, b_Side, c_Side = sides
    return a_Side == b_Side or b_Side == c_Side or a_Side == c_Side


def scalene(sides):
    """Check if triangle is scalene (all sides different)."""
    
    if not is_triangle(sides):
        return False
    a_Side, b_Side, c_Side = sides
    return a_Side != b_Side and b_Side != c_Side and a_Side != c_Side