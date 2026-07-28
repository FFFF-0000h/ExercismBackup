"""Evaluate the type of triangle"""


def is_triangle(sides):
    """Check if three sides can form a valid triangle."""
    
    a_side, b_side, c_side = sides
    # All sides must be positive
    if a_side <= 0 or b_side <= 0 or c_side <= 0:
        return False
    # Triangle inequality theorem
    return (a_side + b_side >= c_side) and (b_side + c_side >= a_side) and (a_side + c_side >= b_side)


def equilateral(sides):
    """Check if triangle is equilateral (all sides equal)."""
    
    if not is_triangle(sides):
        return False
    a_side, b_side, c_side = sides
    return a_side == b_side == c_side


def isosceles(sides):
    """Check if triangle is isosceles (at least two sides equal)."""
    
    if not is_triangle(sides):
        return False
    a_side, b_side, c_side = sides
    return a_side == b_side or b_side == c_side or a_side == c_side


def scalene(sides):
    """Check if triangle is scalene (all sides different)."""
    
    if not is_triangle(sides):
        return False
    a_side, b_side, c_side = sides
    return a_side != b_side and b_side != c_side and a_side != c_side