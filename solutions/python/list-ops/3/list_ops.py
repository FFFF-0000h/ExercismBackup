"""Basic list operations implemented from scratch."""

from typing import Any, Callable, List, TypeVar

ElementType = TypeVar("ElementType")
ResultType = TypeVar("ResultType")


def append(list1: List[ElementType], list2: List[ElementType]) -> List[ElementType]:
    """Return a new list that is the concatenation of list1 and list2."""
    result = list(list1)                     # shallow copy
    for item in list2:
        result.append(item)
    return result


def concat(lists: List[List[ElementType]]) -> List[ElementType]:
    """Flatten a list of lists into a single list."""
    result: List[ElementType] = []
    for sublist in lists:
        for item in sublist:
            result.append(item)
    return result


# pylint: disable=redefined-builtin
def filter(function: Callable[[ElementType], bool], lst: List[ElementType]) -> List[ElementType]:
    """Return a list of items from lst for which function(item) is True."""
    result: List[ElementType] = []
    for item in lst:
        if function(item):
            result.append(item)
    return result
# pylint: enable=redefined-builtin


def length(lst: List[Any]) -> int:
    """Return the number of items in lst."""
    count = 0
    for _ in lst:        # pylint: disable=disallowed-name
        count += 1
    return count


# pylint: disable=redefined-builtin
def map(function: Callable[[ElementType], ResultType], lst: List[ElementType]) -> List[ResultType]:
    """Apply function to each item of lst and return a list of the results."""
    result: List[ResultType] = []
    for item in lst:
        result.append(function(item))
    return result
# pylint: enable=redefined-builtin


def foldl(function: Callable[[ResultType, ElementType], ResultType],
          lst: List[ElementType], initial: ResultType) -> ResultType:
    """Left fold: reduce lst from the left using function, starting with initial.
    function takes (accumulator, element) and returns new accumulator.
    """
    accumulator = initial
    for item in lst:
        accumulator = function(accumulator, item)
    return accumulator


def foldr(function: Callable[[ResultType, ElementType], ResultType],
          lst: List[ElementType], initial: ResultType) -> ResultType:
    """Right fold: reduce lst from the right using function, starting with initial.
    function takes (accumulator, element) and returns new accumulator.
    """
    accumulator = initial
    # Process elements in reverse order (rightmost first)
    for item in reverse(lst):
        accumulator = function(accumulator, item)
    return accumulator


def reverse(lst: List[ElementType]) -> List[ElementType]:
    """Return a new list with the elements of lst in reverse order."""
    result: List[ElementType] = []
    for index in range(len(lst) - 1, -1, -1):
        result.append(lst[index])
    return result