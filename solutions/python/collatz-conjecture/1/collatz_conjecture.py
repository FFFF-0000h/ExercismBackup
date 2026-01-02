def steps(number):
    # Validate input
    if number <= 0:
        raise ValueError("Only positive integers are allowed")
    
    current = number
    step_count = 0
    
    while current != 1:
        if current % 2 == 0:
            current = current // 2  # Even: divide by 2
        else:
            current = current * 3 + 1  # Odd: multiply by 3 and add 1
        step_count += 1
    
    return step_count