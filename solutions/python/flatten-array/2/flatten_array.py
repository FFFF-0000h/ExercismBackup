"""Module providing a function to flatten nested iterables."""


def flatten(iterable):
    """Flatten a nested iterable, removing None-like values.

    Args:
        iterable: A possibly nested list/tuple containing arbitrary items.

    Returns:
        A flat list of all non-None items in depth-first order.
    """
    result = []
    for item in iterable:
        if isinstance(item, (list, tuple)):
            result.extend(flatten(item))
        elif item is not None:
            result.append(item)
    return result