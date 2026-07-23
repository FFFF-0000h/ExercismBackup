"""Evaluate Collatz Conjecture.

The Collatz conjecture states that for any positive integer:
- If the number is even, divide it by 2.
- If the number is odd, multiply by 3 and add 1.
The conjecture claims this sequence always reaches 1.

This module provides a function to count the steps required.
"""

def steps(number):
    """Calculate the number of steps to reach 1 in the Collatz sequence.

    Starting from a positive integer, repeatedly apply:
    - n → n/2 if n is even
    - n → 3n + 1 if n is odd
    until reaching 1.

    :param number: int - the starting positive integer.
    :return: int - the number of steps taken to reach 1.
    :raises ValueError: if `number` is not a positive integer.
    """
    
    
    # Validate input
    if number <= 0:
        raise ValueError("Only positive integers are allowed")
    
    current = number
    step_count = 0
    
    while current != 1:
        if current % 2 == 0:
            current = current // 2  # Even
        else:
            current = current * 3 + 1  # Odd
        step_count += 1
    
    return step_count