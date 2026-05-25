"""Binary search implementation."""

def find(search_list, value):
    """Return the index of `value` in the sorted `search_list`.

    Args:
        search_list (list): A sorted list of comparable items.
        value: The value to search for.

    Returns:
        int: The index of the value.

    Raises:
        ValueError: If the value is not found.
    """
    if not search_list:
        raise ValueError("value not in array")

    low, high = 0, len(search_list) - 1

    while low <= high:
        mid = (low + high) // 2
        mid_value = search_list[mid]

        if mid_value == value:
            return mid
        if mid_value < value:
            low = mid + 1
        else:
            high = mid - 1

    raise ValueError("value not in array")