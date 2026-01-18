def is_valid(isbn: str) -> bool:
    """
    Check if a given string is a valid ISBN-10.
    
    Valid ISBN-10 format:
    - 9 digits (0-9) followed by a check character (0-9 or X)
    - May contain hyphens in any position
    - X represents 10
    
    Validation formula:
    (d1*10 + d2*9 + d3*8 + d4*7 + d5*6 + d6*5 + d7*4 + d8*3 + d9*2 + d10*1) mod 11 == 0
    """
    # Remove hyphens
    cleaned = isbn.replace('-', '')
    
    # Check length
    if len(cleaned) != 10:
        return False
    
    # Check first 9 characters are digits
    if not cleaned[:9].isdigit():
        return False
    
    # Check last character is digit or X
    if not (cleaned[9].isdigit() or cleaned[9].upper() == 'X'):
        return False
    
    # Calculate weighted sum
    total = 0
    for i in range(10):
        if i == 9 and cleaned[i].upper() == 'X':
            # X represents 10
            value = 10
        else:
            value = int(cleaned[i])
        
        # Weight: 10, 9, 8, ..., 1
        weight = 10 - i
        total += value * weight
    
    # Check if divisible by 11
    return total % 11 == 0


# Alternative more concise version
def is_valid_alt(isbn: str) -> bool:
    # Remove hyphens and convert to uppercase
    chars = list(isbn.replace('-', '').upper())
    
    # Check length
    if len(chars) != 10:
        return False
    
    # Validate characters
    for i in range(9):
        if not chars[i].isdigit():
            return False
    
    if chars[9] not in '0123456789X':
        return False
    
    # Calculate sum with list comprehension
    digits = [int(chars[i]) for i in range(9)]
    if chars[9] == 'X':
        digits.append(10)
    else:
        digits.append(int(chars[9]))
    
    total = sum(digits[i] * (10 - i) for i in range(10))
    return total % 11 == 0