"""Functions used in preparing Guido's gorgeous lasagna.

Learn about Guido, the creator of the Python language:
https://en.wikipedia.org/wiki/Guido_van_Rossum

This is a module docstring, used to describe the functionality
of a module and its functions and/or classes.
"""


EXPECTED_BAKE_TIME = 40
PREPARATION_TIME = 2

def bake_time_remaining(bake_time_elapsed):
    """Calculate the bake time remaining.

    :param bake_time_elapsed: int - baking time already elapsed.
    :return: int - needed bake time (in minutes) based on the 'EXPECTED_BAKE_TIME' constant.

    Function that takes the actual minutes the lasagna has been in the oven as
    an argument and returns how many minutes the lasagna still needs to bake
    based on the `EXPECTED_BAKE_TIME`.
    """
    time_needed = EXPECTED_BAKE_TIME - bake_time_elapsed
    return time_needed

def preparation_time_in_minutes(number_of_layers):
    """Calculate the preparation time in minutes.

    :param number_of_layers: int - number of layers.
    :return: int - preparation time (in minutes) based on 'PREPARATION_TIME'.

    Function that takes the number of the lasagna layers as
    an argument and returns how many minutes you would need to prepare the lasagna 
    based on the `PREPARATION_TIME`.
    """
    return PREPARATION_TIME * number_of_layers

def elapsed_time_in_minutes(number_of_layers, elapsed_bake_time):
    """Calculate the elapsed time in minutes remaining.

    :param elapsed_bake_time: int - number of minutes spent already in oven.
    :param number_of_layers: int - number of layers.
    :return: int - remaining total minutes spent in kitchen cooking.

    Function that takes two arguments; the number of layers and the time already spent 
    baking and returns the total elapsed time in minutes.
    """
    return preparation_time_in_minutes(number_of_layers) + elapsed_bake_time
