def square_root(number):
    """
    Return the integer square root of a positive whole number.
    
    The integer square root is the largest integer n such that n^2 <= number.
    """
    if number == 0:
        return 0
    if number == 1:
        return 1
    
    # Binary search approach
    left = 1
    right = number // 2 + 1  # Square root can't be more than number/2 for number > 2
    
    while left <= right:
        mid = (left + right) // 2
        square = mid * mid
        
        if square == number:
            return mid
        elif square < number:
            left = mid + 1
        else:  # square > number
            right = mid - 1
    
    # If we exit the loop without finding an exact square root,
    # we've found the floor of the square root, but according to
    # the problem statement, we only need to handle cases where
    # the result is a positive whole number, so we should have
    # found an exact match
    return right  # This would be the floor for non-perfect squares