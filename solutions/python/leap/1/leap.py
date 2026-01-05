def leap_year(year):
    """
    Determine if a given year is a leap year.
    
    A leap year occurs:
    1. If the year is divisible by 4
    2. Unless it's divisible by 100, then it must also be divisible by 400
    
    Args:
        year (int): The year to check
        
    Returns:
        bool: True if it's a leap year, False otherwise
    """
    return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)