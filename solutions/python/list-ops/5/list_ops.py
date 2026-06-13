"""Basic list operations implemented from scratch."""

from typing import Any, Callable, List, TypeVar

# Type variables that satisfy Pylint's naming conventions
ValueT = TypeVar("ValueT")
ResultT = TypeVar("ResultT")


def append(list1: List[ValueT], list2: List[ValueT]) -> List[ValueT]:
    """Return a new list that is the concatenation of list1 and list2."""
    result = list(list1)                     # shallow copy
    for item in list2:
        result.append(item)
    return result


def concat(lists: List[List[ValueT]]) -> List[ValueT]:
    """Flatten a list of lists into a single list."""
    result: List[ValueT] = []
    for sublist in lists:
        for item in sublist:
            result.append(item)
    return result


# pylint: disable=redefined-builtin
def filter(function: Callable[[ValueT], bool], lst: List[ValueT]) -> List[ValueT]:
    """Return a list of items from lst for which function(item) is True."""
    result: List[ValueT] = []
    for item in lst:
        if function(item):
            result.append(item)
    return result
# pylint: enable=redefined-builtin


def length(lst: List[Any]) -> int:
    """Return the number of items in lst."""
    count = 0
    for _ in lst:
        count += 1
    return count


# pylint: disable=redefined-builtin
def map(function: Callable[[ValueT], ResultT], lst: List[ValueT]) -> List[ResultT]:
    """Apply function to each item of lst and return a list of the results."""
    result: List[ResultT] = []
    for item in lst:
        result.append(function(item))
    return result
# pylint: enable=redefined-builtin


def foldl(function: Callable[[ResultT, ValueT], ResultT],
          lst: List[ValueT], initial: ResultT) -> ResultT:
    """Left fold: reduce lst from the left using function, starting with initial.
    function takes (accumulator, element) and returns new accumulator.
    """
    accumulator = initial
    for item in lst:
        accumulator = function(accumulator, item)
    return accumulator


def foldr(function: Callable[[ResultT, ValueT], ResultT],
          lst: List[ValueT], initial: ResultT) -> ResultT:
    """Right fold: reduce lst from the right using function, starting with initial.
    function takes (accumulator, element) and returns new accumulator.
    """
    accumulator = initial
    # Process elements in reverse order (rightmost first)
    for item in reverse(lst):
        accumulator = function(accumulator, item)
    return accumulator


def reverse(lst: List[ValueT]) -> List[ValueT]:
    """Return a new list with the elements of lst in reverse order."""
    result: List[ValueT] = []
    for index in range(len(lst) - 1, -1, -1):
        result.append(lst[index])
    return result