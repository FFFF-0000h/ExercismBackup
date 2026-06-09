"""Generate a customer greeting with an ordinal number."""


def line_up(name: str, number: int) -> str:
    """Create a personalized sentence for the deli customer.

    Args:
        name: The customer's name.
        number: The customer's position in line (1 to 999).

    Returns:
        A string like "Mary, you are the 1st customer we serve today. Thank you!"
    """
    # Determine the correct ordinal suffix
    if 11 <= (number % 100) <= 13:
        suffix = "th"
    else:
        last_digit = number % 10
        if last_digit == 1:
            suffix = "st"
        elif last_digit == 2:
            suffix = "nd"
        elif last_digit == 3:
            suffix = "rd"
        else:
            suffix = "th"

    return f"{name}, you are the {number}{suffix} customer we serve today. Thank you!"