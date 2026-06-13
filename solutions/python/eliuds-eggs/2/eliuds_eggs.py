"""Module providing a function to count eggs from an encoded display value."""


def egg_count(display_value):
    """
    Count the number of 1 bits in the binary representation of a number.
    
    This represents the actual number of eggs in the coop, where each 1 bit
    corresponds to a nest box containing an egg.
    
    Args:
        display_value: The decimal number shown on the display
        
    Returns:
        int: The count of 1 bits (actual number of eggs)
    
    Examples:
        >>> egg_count(89)   # binary: 1011001
        4
        >>> egg_count(8)    # binary: 0001000
        1
        >>> egg_count(0)
        0
        >>> egg_count(7)    # binary: 111
        3
    """
    egg_total = 0
    
    # Continue until all bits have been processed
    while display_value > 0:
        # Check if the least significant bit is 1
        if display_value & 1:
            egg_total += 1
        
        # Shift right by 1 to check the next bit
        display_value >>= 1
    
    return egg_total