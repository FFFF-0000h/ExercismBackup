import math

def score(x, y):
    """
    Calculate the score of a dart landing at position (x, y).
    
    Scoring rules:
    - Outside target (radius > 10): 0 points
    - Outer circle (5 < radius <= 10): 1 point
    - Middle circle (1 < radius <= 5): 5 points
    - Inner circle (radius <= 1): 10 points
    """
    # Calculate distance from center (0, 0)
    distance = math.sqrt(x**2 + y**2)
    
    # Determine score based on distance
    if distance > 10:
        return 0
    elif distance > 5:
        return 1
    elif distance > 1:
        return 5
    else:
        return 10