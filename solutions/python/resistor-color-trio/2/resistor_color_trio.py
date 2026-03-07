"""Resistor color code decoder with metric prefixes.

This module provides a function to decode three color bands into a human-readable
resistance value with appropriate metric prefixes (kilo, mega, giga).
"""

def label(colors):
    """Convert three color bands to a resistance label.

    Args:
        colors: A list of three color names (case-insensitive).

    Returns:
        A string representing the resistance with metric prefix, e.g. "33 ohms",
        "33 kiloohms", "1.2 megaohms".
    """
    color_map = {
        "black": 0, "brown": 1, "red": 2, "orange": 3, "yellow": 4,
        "green": 5, "blue": 6, "violet": 7, "grey": 8, "white": 9
    }

    first = color_map[colors[0].lower()]
    second = color_map[colors[1].lower()]
    third = color_map[colors[2].lower()]

    main_value = first * 10 + second
    multiplier = 10 ** third
    ohms = main_value * multiplier

    prefixes = ["", "kilo", "mega", "giga"]
    prefix_index = 0
    while ohms >= 1000 ** (prefix_index + 1) and prefix_index < len(prefixes) - 1:
        prefix_index += 1

    power = 1000 ** prefix_index
    prefix = prefixes[prefix_index]

    quotient = ohms // power
    remainder = ohms % power

    if remainder == 0:
        return f"{quotient} {prefix}ohms"

    # Format decimal part: remainder should have up to 3*prefix_index digits
    digits = 3 * prefix_index
    remainder_str = str(remainder).zfill(digits).rstrip("0")
    if remainder_str == "":
        return f"{quotient} {prefix}ohms"
    return f"{quotient}.{remainder_str} {prefix}ohms"