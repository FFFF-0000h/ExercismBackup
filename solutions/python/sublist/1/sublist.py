"""
This exercise stub and the test suite contain several enumerated constants.

Enumerated constants can be done with a NAME assigned to an arbitrary,
but unique value. An integer is traditionally used because it's memory
efficient.
It is a common practice to export both constants and functions that work with
those constants (ex. the constants in the os, subprocess and re modules).

You can learn more here: https://en.wikipedia.org/wiki/Enumerated_type
"""

# Possible sublist categories.
# Change the values as you see fit.
SUBLIST = 1
SUPERLIST = 2
EQUAL = 3
UNEQUAL = 4


def sublist(list_one, list_two):
    """Determine the relationship between two lists."""
    # Helper function to check if list_a is contained in list_b
    def is_sublist(list_a, list_b):
        len_a = len(list_a)
        len_b = len(list_b)
        
        # An empty list is always a sublist
        if len_a == 0:
            return True
        
        # If list_a is longer than list_b, it can't be a sublist
        if len_a > len_b:
            return False
        
        # Check each possible starting position in list_b
        for i in range(len_b - len_a + 1):
            # Check if the slice of list_b matches list_a
            if list_b[i:i+len_a] == list_a:
                return True
        return False
    
    # Check for equality first (most specific case)
    if list_one == list_two:
        return EQUAL
    
    # Check if list_one is a sublist of list_two
    if is_sublist(list_one, list_two):
        return SUBLIST
    
    # Check if list_one is a superlist of list_two
    if is_sublist(list_two, list_one):
        return SUPERLIST
    
    # None of the above
    return UNEQUAL