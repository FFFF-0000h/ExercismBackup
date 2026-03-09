"""Module for decoding resistor color bands to resistance value and tolerance."""

def resistor_label(colors):
    """
    Convert a list of resistor color bands into a human-readable label.

    Supports 1-band (black only), 4-band, and 5-band resistors.
    Returns a string like "33 ohms ±5%" or "2.2 kiloohms ±1%".
    """
    digit_map = {
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
    tolerance_map = {
        "grey": "0.05",
        "violet": "0.1",
        "blue": "0.25",
        "green": "0.5",
        "brown": "1",
        "red": "2",
        "gold": "5",
        "silver": "10"
    }

    band_count = len(colors)

    # One‑band resistor: only black is valid, value 0
    if band_count == 1:
        return "0 ohms"

    # Four‑band resistor
    if band_count == 4:
        first_digit = digit_map[colors[0]]
        second_digit = digit_map[colors[1]]
        multiplier = digit_map[colors[2]]
        tolerance = tolerance_map[colors[3]]
        raw_value = (first_digit * 10 + second_digit) * (10 ** multiplier)

    # Five‑band resistor
    elif band_count == 5:
        first_digit = digit_map[colors[0]]
        second_digit = digit_map[colors[1]]
        third_digit = digit_map[colors[2]]
        multiplier = digit_map[colors[3]]
        tolerance = tolerance_map[colors[4]]
        raw_value = (first_digit * 100 + second_digit * 10 + third_digit) * (10 ** multiplier)

    else:
        # Input is guaranteed to be 1, 4, or 5 bands by problem statement
        return ""

    # Choose the appropriate metric prefix
    if raw_value >= 1_000_000:
        divisor = 1_000_000
        unit = "megaohms"
    elif raw_value >= 1000:
        divisor = 1000
        unit = "kiloohms"
    else:
        divisor = 1
        unit = "ohms"

    # Format the numeric part
    if divisor == 1:
        value_str = str(raw_value)
    else:
        whole_part = raw_value // divisor
        remainder = raw_value % divisor
        if remainder == 0:
            value_str = str(whole_part)
        else:
            # Number of digits needed for the fractional part
            width = len(str(divisor - 1))
            fractional = str(remainder).zfill(width).rstrip("0")
            value_str = f"{whole_part}.{fractional}"

    return f"{value_str} {unit} ±{tolerance}%"