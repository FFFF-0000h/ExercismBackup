def resistor_label(colors):
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

    n = len(colors)

    # One‑band resistor: only black is allowed, value 0
    if n == 1:
        return "0 ohms"

    # Four‑band resistor
    if n == 4:
        d1 = digit_map[colors[0]]
        d2 = digit_map[colors[1]]
        mult = digit_map[colors[2]]
        tol = tolerance_map[colors[3]]
        value = (d1 * 10 + d2) * (10 ** mult)

    # Five‑band resistor
    elif n == 5:
        d1 = digit_map[colors[0]]
        d2 = digit_map[colors[1]]
        d3 = digit_map[colors[2]]
        mult = digit_map[colors[3]]
        tol = tolerance_map[colors[4]]
        value = (d1 * 100 + d2 * 10 + d3) * (10 ** mult)

    else:
        # The problem guarantees 1, 4 or 5 bands, so this line is never reached
        return ""

    # Choose the appropriate metric prefix
    if value >= 1_000_000:
        divisor = 1_000_000
        unit = "megaohms"
    elif value >= 1000:
        divisor = 1000
        unit = "kiloohms"
    else:
        divisor = 1
        unit = "ohms"

    # Format the numeric part
    if divisor == 1:
        val_str = str(value)
    else:
        q = value // divisor
        r = value % divisor
        if r == 0:
            val_str = str(q)
        else:
            # Number of digits needed for the fractional part
            width = len(str(divisor - 1))
            frac = str(r).zfill(width).rstrip('0')
            val_str = f"{q}.{frac}"

    return f"{val_str} {unit} ±{tol}%"