
def label(colors):
    # Map color names to their digit values
    color_map = {
        "black": 0, "brown": 1, "red": 2, "orange": 3, "yellow": 4,
        "green": 5, "blue": 6, "violet": 7, "grey": 8, "white": 9
    }

    # Convert each color to its digit (case‑insensitive)
    first = color_map[colors[0].lower()]
    second = color_map[colors[1].lower()]
    third = color_map[colors[2].lower()]

    # Main value from the first two bands
    main = first * 10 + second

    # Multiplier from the third band (10^third)
    multiplier = 10 ** third

    # Total resistance in ohms
    ohms = main * multiplier

    # Metric prefixes for ohms (powers of 1000)
    prefixes = ["", "kilo", "mega", "giga"]

    # Find the largest exponent k such that ohms >= 1000^k
    k = 0
    while ohms >= 1000 ** (k + 1) and k < len(prefixes) - 1:
        k += 1

    power = 1000 ** k
    prefix = prefixes[k]

    quotient = ohms // power
    remainder = ohms % power

    if remainder == 0:
        return f"{quotient} {prefix}ohms"

    # Format the decimal part: remainder has exactly 3*k digits (with leading zeros)
    digits = 3 * k
    remainder_str = str(remainder).zfill(digits).rstrip('0')
    if remainder_str == "":
        return f"{quotient} {prefix}ohms"
    return f"{quotient}.{remainder_str} {prefix}ohms"
