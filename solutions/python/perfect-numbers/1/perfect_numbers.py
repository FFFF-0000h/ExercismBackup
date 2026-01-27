def classify(number):
    """ A perfect number equals the sum of its positive divisors.

    :param number: int a positive integer
    :return: str the classification of the input integer
    """
    # Validate input
    if not isinstance(number, int) or number <= 0:
        raise ValueError("Classification is only possible for positive integers.")
    
    # Calculate aliquot sum (sum of proper divisors)
    aliquot_sum = 0
    for i in range(1, number):
        if number % i == 0:
            aliquot_sum += i
    
    # Classify based on aliquot sum
    if aliquot_sum == number:
        return "perfect"
    elif aliquot_sum > number:
        return "abundant"
    else:
        return "deficient"