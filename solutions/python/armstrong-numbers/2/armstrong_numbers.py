"""Verify an Armstrong number.

An Armstrong number is a number that equals the sum of its own digits
each raised to the power of the number of digits.

Examples:
    9 is an Armstrong number: 9 = 9^1 = 9
    153 is an Armstrong number: 153 = 1^3 + 5^3 + 3^3 = 153
    154 is not an Armstrong number: 154 != 1^3 + 5^3 + 4^3 = 190
"""

def is_armstrong_number(number):
    """Determine whether a given integer is an Armstrong number.

    :param number: int - the number to check.
    :return: bool - True if the number is an Armstrong number, False otherwise.
    """

    str_num = str(number)
    num_digits = len(str_num)
    
    sum_of_powers = sum(int(digit) ** num_digits for digit in str_num)
    
    return sum_of_powers == number