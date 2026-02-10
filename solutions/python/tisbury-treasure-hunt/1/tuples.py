"""Functions to help Azara and Rui locate pirate treasure."""

def get_coordinate(record):
    """Return coordinate value from a tuple containing the treasure name, and treasure coordinate.

    :param record: tuple - with a (treasure, coordinate) pair.
    :return: str - the extracted map coordinate.
    """
    # The coordinate is the second element in the tuple
    return record[1]

def convert_coordinate(coordinate):
    """Split the given coordinate into tuple containing its individual components.

    :param coordinate: str - a string map coordinate
    :return: tuple - the string coordinate split into its individual components.
    """
    # Split the string into number and letter
    return (coordinate[0], coordinate[1])

def compare_records(azara_record, rui_record):
    """Compare two record types and determine if their coordinates match.

    :param azara_record: tuple - a (treasure, coordinate) pair.
    :param rui_record: tuple - a (location, tuple(coordinate_1, coordinate_2), quadrant) trio.
    :return: bool - do the coordinates match?
    """
    # Get Azara's coordinate and convert it to tuple format
    azara_coord = convert_coordinate(azara_record[1])
    
    # Rui's coordinate is already in tuple format (second element)
    rui_coord = rui_record[1]
    
    # Compare the two tuples
    return azara_coord == rui_coord

def create_record(azara_record, rui_record):
    """Combine the two record types (if possible) and create a combined record group.

    :param azara_record: tuple - a (treasure, coordinate) pair.
    :param rui_record: tuple - a (location, coordinate, quadrant) trio.
    :return: tuple or str - the combined record (if compatible), or the string "not a match" (if incompatible).
    """
    # Check if coordinates match
    if compare_records(azara_record, rui_record):
        # Combine all elements: treasure, azara_coord, location, rui_coord, quadrant
        return (azara_record[0], azara_record[1], rui_record[0], rui_record[1], rui_record[2])
    else:
        return "not a match"

def clean_up(combined_record_group):
    """Clean up a combined record group into a multi-line string of single records.

    :param combined_record_group: tuple - everything from both participants.
    :return: str - everything "cleaned", excess coordinates and information are removed.

    The return statement should be a multi-lined string with items separated by newlines.
    """
    cleaned_records = []
    
    for record in combined_record_group:
        # Each record has: (treasure, azara_coord, location, rui_coord, quadrant)
        # We need: (treasure, location, rui_coord, quadrant)
        # We'll use rui_coord since it's already in tuple format
        
        cleaned_record = (record[0],  # treasure name
                         record[2],   # location name
                         record[3],   # rui_coordinate (tuple format)
                         record[4])   # quadrant
        
        cleaned_records.append(str(cleaned_record))
    
    # Join with newlines and add a trailing newline
    return "\n".join(cleaned_records) + "\n"