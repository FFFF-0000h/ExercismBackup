def is_armstrong_number(number):
    # Convert the number to string to get individual digits and count them
    str_num = str(number)
    num_digits = len(str_num)
    
    # Calculate the sum of each digit raised to the power of num_digits
    sum_of_powers = sum(int(digit) ** num_digits for digit in str_num)
    
    # Check if the sum equals the original number
    return sum_of_powers == number
