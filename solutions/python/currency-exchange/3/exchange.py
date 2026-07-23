"""Functions for calculating steps in exchanging currency.

Python numbers documentation: https://docs.python.org/3/library/stdtypes.html#numeric-types-int-float-complex

Overview of exchanging currency when travelling: https://www.compareremit.com/money-transfer-tips/guide-to-exchanging-currency-for-overseas-travel/
"""



def exchange_money(budget, exchange_rate):
    """Calculate the value of exchanged currency.

    :param budget: float - amount of money you are planning to exchange.
    :param exchange_rate: float - unit value of the foreign currency in domestic currency.
    :return: float - exchanged value of the foreign currency you can receive.
    """
    return budget / exchange_rate


def get_change(budget, exchange_amount):
    """Calculate the amount of money that is left from the budget.

    :param budget: float - amount of money before exchange.
    :param exchange_amount: float - amount of money that is taken from the budget to be exchanged.
    :return: float - amount left of starting currency after exchanging.
    """
    return budget - exchange_amount


def get_value_of_bills(denomination, number_of_bills):
    """Calculate the total value of bills, excluding the fractional amounts)

    :param denomination: int - the value of a bill.
    :param number_of_bills: int - total number of bills.
    :return: int - calculated value of the bills.
    """
    return denomination * number_of_bills


def get_number_of_bills(amount, denomination):
    """Calculate the number of currency bills that you can receive with the given amount.

    :param amount: float - the total starting value.
    :param denomination: int - the value of a single bill.
    :return: int - number of bills that can be obtained from the amount.
    """
    return amount // denomination


def get_leftover_of_bills(amount, denomination):
    """Calculate the leftover amount that cannot be returned from the starting amount given the denomination of bills.

    :param amount: float - the total starting value.
    :param denomination: int - the value of a single bill.
    :return: float - the amount that is "leftover", given the current denomination.
    """
    return amount % denomination


def exchangeable_value(budget, exchange_rate, spread, denomination):
    """Calculate the maximum value of the new currency after calculating the exchange rate plus the spread.

    :param budget: float - the amount of your money you are planning to exchange.
    :param exchange_rate: float - the unit value of the foreign currency.
    :param spread: int - percentage that is taken as an exchange fee.
    :param denomination: int - the value of a single bill.
    :return: int - maximum value you can get.
    """
    actual_rate = (spread / 100 * exchange_rate) + exchange_rate
    total_new_currency = budget / actual_rate
    whole_bills_value = int(total_new_currency // denomination * denomination)
    return whole_bills_value
