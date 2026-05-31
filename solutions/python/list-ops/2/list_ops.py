"""Basic list operations implemented from scratch."""

from typing import Any, Callable, List, TypeVar

T = TypeVar("T")
U = TypeVar("U")


def append(list1: List[T], list2: List[T]) -> List[T]:
    """Return a new list that is the concatenation of list1 and list2."""
    result = list(list1)          # shallow copy
    for item in list2:
        result.append(item)
    return result


def concat(lists: List[List[T]]) -> List[T]:
    """Flatten a list of lists into a single list."""
    result: List[T] = []
    for sublist in lists:
        for item in sublist:
            result.append(item)
    return result


def filter(function: Callable[[T], bool], lst: List[T]) -> List[T]:
    """Return a list of items from lst for which function(item) is True."""
    result: List[T] = []
    for item in lst:
        if function(item):
            result.append(item)
    return result


def length(lst: List[Any]) -> int:
    """Return the number of items in lst."""
    count = 0
    for _ in lst:
        count += 1
    return count


def map(function: Callable[[T], U], lst: List[T]) -> List[U]:
    """Apply function to each item of lst and return a list of the results."""
    result: List[U] = []
    for item in lst:
        result.append(function(item))
    return result


def foldl(function: Callable[[U, T], U], lst: List[T], initial: U) -> U:
    """Left fold: reduce lst from the left using function, starting with initial.
    function takes (accumulator, element) and returns new accumulator.
    """
    accumulator = initial
    for item in lst:
        accumulator = function(accumulator, item)
    return accumulator


def foldr(function: Callable[[U, T], U], lst: List[T], initial: U) -> U:
    """Right fold: reduce lst from the right using function, starting with initial.
    function takes (accumulator, element) and returns new accumulator.
    """
    accumulator = initial
    # Process elements in reverse order (rightmost first)
    for item in reverse(lst):
        accumulator = function(accumulator, item)
    return accumulator


def reverse(lst: List[T]) -> List[T]:
    """Return a new list with the elements of lst in reverse order."""
    result: List[T] = []
    for i in range(len(lst) - 1, -1, -1):
        result.append(lst[i])
    return result