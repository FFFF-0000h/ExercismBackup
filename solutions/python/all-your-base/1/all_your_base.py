def rebase(input_base, digits, output_base):
    # Validate input and output bases
    if input_base < 2:
        raise ValueError("input base must be >= 2")
    if output_base < 2:
        raise ValueError("output base must be >= 2")
    
    # Validate digits
    if not digits:
        return [0]
    
    for digit in digits:
        if digit < 0 or digit >= input_base:
            raise ValueError("all digits must satisfy 0 <= d < input base")
    
    # Convert from input base to decimal (base 10)
    decimal_value = 0
    for i, digit in enumerate(reversed(digits)):
        decimal_value += digit * (input_base ** i)
    
    # Special case: if decimal value is 0, return [0]
    if decimal_value == 0:
        return [0]
    
    # Convert from decimal to output base
    output_digits = []
    while decimal_value > 0:
        remainder = decimal_value % output_base
        output_digits.insert(0, remainder)  # Insert at beginning to maintain correct order
        decimal_value //= output_base
    
    return output_digits