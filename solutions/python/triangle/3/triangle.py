"""Evaluate the type of triangle"""


def is_triangle(sides):
    """Check if three sides can form a valid triangle."""
    
    aSide, bSide, cSide = sides
    # All sides must be positive
    if aSide <= 0 or bSide <= 0 or cSide <= 0:
        return False
    # Triangle inequality theorem
    return (aSide + bSide >= cSide) and (bSide + cSide >= aSide) and (aSide + cSide >= bSide)


def equilateral(sides):
    """Check if triangle is equilateral (all sides equal)."""
    
    if not is_triangle(sides):
        return False
    aSide, bSide, cSide = sides
    return aSide == bSide == cSide


def isosceles(sides):
    """Check if triangle is isosceles (at least two sides equal)."""
    
    if not is_triangle(sides):
        return False
    aSide, bSide, cSide = sides
    return aSide == bSide or bSide == cSide or aSide == cSide


def scalene(sides):
    """Check if triangle is scalene (all sides different)."""
    
    if not is_triangle(sides):
        return False
    aSide, bSide, cSide = sides
    return aSide != bSide and bSide != cSide and aSide != cSide