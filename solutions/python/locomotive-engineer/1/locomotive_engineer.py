"""Functions which helps the locomotive engineer to keep track of the train."""


def get_list_of_wagons(*wagons):
    """Return a list of wagons.

    :param: arbitrary number of wagons.
    :return: list - list of wagons.
    """
    return list(wagons)


def fix_list_of_wagons(each_wagons_id, missing_wagons):
    """Fix the list of wagons.

    :param each_wagons_id: list - the list of wagons.
    :param missing_wagons: list - the list of missing wagons.
    :return: list - list of wagons.
    """
    # Move first two wagons to the end
    a, b, *rest = each_wagons_id
    # The locomotive (1) is now the first element of rest
    # Insert missing wagons after the locomotive
    return [rest[0]] + missing_wagons + rest[1:] + [a, b]


def add_missing_stops(route, **stops):
    """Add missing stops to route dict.

    :param route: dict - the dict of routing information.
    :param stops: arbitrary number of stops as keyword arguments.
    :return: dict - updated route dictionary.
    """
    new_route = route.copy()
    # Keyword arguments are ordered, so values() preserve insertion order
    new_route["stops"] = list(stops.values())
    return new_route


def extend_route_information(route, more_route_information):
    """Extend route information with more_route_information.

    :param route: dict - the route information.
    :param more_route_information: dict -  extra route information.
    :return: dict - extended route information.
    """
    return {**route, **more_route_information}


def fix_wagon_depot(wagons_rows):
    """Fix the list of rows of wagons.

    :param wagons_rows: list[list[tuple]] - the list of rows of wagons.
    :return: list[list[tuple]] - list of rows of wagons.
    """
    # Transpose rows so that each column becomes a row
    return [list(row) for row in zip(*wagons_rows)]