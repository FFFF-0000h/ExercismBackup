"""Evaluate a given year to check if it is a leap year"""

def leap_year(year):
    """Determine if a given year is a leap year.
    
    A leap year occurs:
    1. If the year is divisible by 4
    2. Unless it's divisible by 100, then it must also be divisible by 400
    
    :param int: year: The year to check
    :return: bool: True if it's a leap year, False otherwise
    """
    return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)