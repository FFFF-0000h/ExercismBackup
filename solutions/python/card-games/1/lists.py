"""Functions for tracking poker hands and assorted card tasks.

Python list documentation: https://docs.python.org/3/tutorial/datastructures.html
"""


def get_rounds(number):
    """Create a list containing the current and next two round numbers.

    :param number: int - current round number.
    :return: list - current round and the two that follow.
    """
    return [number, number + 1, number + 2]


def concatenate_rounds(rounds_1, rounds_2):
    """Concatenate two lists of round numbers.

    :param rounds_1: list - first rounds played.
    :param rounds_2: list - second set of rounds played.
    :return: list - all rounds played.
    """
    return rounds_1 + rounds_2


def list_contains_round(rounds, number):
    """Check if the list of rounds contains the specified number.

    :param rounds: list - rounds played.
    :param number: int - round number.
    :return: bool - was the round played?
    """
    return number in rounds


def card_average(hand):
    """Calculate and returns the average card value from the list.

    :param hand: list - cards in hand.
    :return: float - average value of the cards in the hand.
    """
    return sum(hand) / len(hand)


def approx_average_is_average(hand):
    """Return if the (average of first and last card values) OR ('middle' card) == calculated average.

    :param hand: list - cards in hand.
    :return: bool - does one of the approximate averages equal the `true average`?
    """
    true_average = card_average(hand)
    
    # Strategy 1: Average of first and last card
    first_last_average = (hand[0] + hand[-1]) / 2
    
    # Strategy 2: Median (middle card)
    # Since hand length is always odd, middle index is len(hand)//2
    middle_index = len(hand) // 2
    median = hand[middle_index]
    
    return true_average == first_last_average or true_average == median


def average_even_is_average_odd(hand):
    """Return if the (average of even indexed card values) == (average of odd indexed card values).

    :param hand: list - cards in hand.
    :return: bool - are even and odd averages equal?
    """
    even_values = []
    odd_values = []
    
    for i, value in enumerate(hand):
        if i % 2 == 0:  # Even index
            even_values.append(value)
        else:  # Odd index
            odd_values.append(value)
    
    if not odd_values:  # If no odd-indexed cards, return False
        return False
    
    even_average = sum(even_values) / len(even_values)
    odd_average = sum(odd_values) / len(odd_values)
    
    return even_average == odd_average


def maybe_double_last(hand):
    """Multiply a Jack card value in the last index position by 2.

    :param hand: list - cards in hand.
    :return: list - hand with Jacks (if present) value doubled.
    """
    # Create a copy of the hand to avoid modifying the original
    result = hand.copy()
    
    if result and result[-1] == 11:  # Check if last card is Jack (11)
        result[-1] = result[-1] * 2
    
    return result