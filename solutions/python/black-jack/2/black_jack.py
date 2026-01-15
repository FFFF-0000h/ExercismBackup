"""Functions to help play and score a game of blackjack.

How to play blackjack:    https://bicyclecards.com/how-to-play/blackjack/
"Standard" playing cards: https://en.wikipedia.org/wiki/Standard_52-card_deck
"""


def value_of_card(card):
    """Determine the scoring value of a card.

    :param card: str - given card.
    :return: int - value of a given card.  See below for values.

    1.  'J', 'Q', or 'K' (otherwise known as "face cards") = 10
    2.  'A' (ace card) = 1
    3.  '2' - '10' = numerical value.
    """
    if card in ('J', 'Q', 'K'):
        return 10
    if card == 'A':
        return 1
    return int(card)


def higher_card(card_one, card_two):
    """Determine which card has a higher value in the hand.

    :param card_one, card_two: str - cards dealt in hand.  See below for values.
    :return: str or tuple - resulting Tuple contains both cards if they are of equal value.

    1.  'J', 'Q', or 'K' (otherwise known as "face cards") = 10
    2.  'A' (ace card) = 1
    3.  '2' - '10' = numerical value.
    """
    val_one = value_of_card(card_one)
    val_two = value_of_card(card_two)
    
    if val_one > val_two:
        return card_one
    if val_two > val_one:
        return card_two
    return card_one, card_two


def value_of_ace(card_one, card_two):
    """Calculate the most advantageous value for the ace card.

    :param card_one, card_two: str - card dealt. See below for values.
    :return: int - either 1 or 11 value of the upcoming ace card.

    1.  'J', 'Q', or 'K' (otherwise known as "face cards") = 10
    2.  'A' (ace card) = 11 (if already in hand)
    3.  '2' - '10' = numerical value.
    """
    # Calculate current hand value (ace in hand = 11)
    def card_value(card):
        if card in ('J', 'Q', 'K'):
            return 10
        if card == 'A':
            return 11  # For existing ace in hand
        return int(card)
    
    current_total = card_value(card_one) + card_value(card_two)
    
    # If adding 11 would bust, use 1; otherwise use 11
    if current_total + 11 > 21:
        return 1
    return 11


def is_blackjack(card_one, card_two):
    """Determine if the hand is a 'natural' or 'blackjack'.

    :param card_one, card_two: str - card dealt. See below for values.
    :return: bool - is the hand is a blackjack (two cards worth 21).

    1.  'J', 'Q', or 'K' (otherwise known as "face cards") = 10
    2.  'A' (ace card) = 11 (if already in hand)
    3.  '2' - '10' = numerical value.
    """
    # Check for ace and ten-value card combination
    is_ace = card_one == 'A' or card_two == 'A'
    is_ten_value = card_one in ('10', 'J', 'Q', 'K') or card_two in ('10', 'J', 'Q', 'K')
    
    return is_ace and is_ten_value


def can_split_pairs(card_one, card_two):
    """Determine if a player can split their hand into two hands.

    :param card_one, card_two: str - cards dealt.
    :return: bool - can the hand be split into two pairs? (i.e. cards are of the same value).
    """
    # Get values (face cards = 10, ace = 1, numeric cards as-is)
    def split_card_value(card):
        if card in ('J', 'Q', 'K'):
            return 10
        if card == 'A':
            return 1
        return int(card)
    
    return split_card_value(card_one) == split_card_value(card_two)


def can_double_down(card_one, card_two):
    """Determine if a blackjack player can place a double down bet.

    :param card_one, card_two: str - first and second cards in hand.
    :return: bool - can the hand can be doubled down? (i.e. totals 9, 10 or 11 points).
    """
    # Use value_of_card for ace = 1
    total = value_of_card(card_one) + value_of_card(card_two)
    return 9 <= total <= 11