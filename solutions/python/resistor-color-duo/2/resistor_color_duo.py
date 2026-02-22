"""Module for decoding resistor color codes.

This module provides a function to convert the first two color bands
of a resistor into a two-digit resistance value.
"""

def value(colors):
    """Return the numerical value of the first two resistor color bands.

    Parameters
    ----------
    colors : list of str
        A list of color names, at least two elements long.

    Returns
    -------
    int
        The two-digit value represented by the first two colors.
    """
    color_map = {
        "black": 0,
        "brown": 1,
        "red": 2,
        "orange": 3,
        "yellow": 4,
        "green": 5,
        "blue": 6,
        "violet": 7,
        "grey": 8,
        "white": 9
    }
    return color_map[colors[0]] * 10 + color_map[colors[1]]