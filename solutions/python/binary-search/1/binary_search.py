def find(search_list, value):
    """Return the index of `value` in the sorted `search_list`.

    Raises:
        ValueError: If `value` is not present in `search_list`.
    """
    if not search_list:
        raise ValueError("value not in array")

    low = 0
    high = len(search_list) - 1

    while low <= high:
        mid = (low + high) // 2
        mid_value = search_list[mid]

        if mid_value == value:
            return mid
        elif mid_value < value:
            low = mid + 1
        else:
            high = mid - 1

    raise ValueError("value not in array")