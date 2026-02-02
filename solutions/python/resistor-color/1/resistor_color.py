def color_code(color):
    """Return the numerical value associated with a resistor color.
    
    Args:
        color (str): The color name (case-insensitive).
        
    Returns:
        int: The numerical value of the color (0-9).
        
    Raises:
        ValueError: If the color is not valid.
    """
    color_map = {
        'black': 0,
        'brown': 1,
        'red': 2,
        'orange': 3,
        'yellow': 4,
        'green': 5,
        'blue': 6,
        'violet': 7,
        'grey': 8,
        'white': 9
    }
    
    normalized_color = color.lower()
    
    if normalized_color in color_map:
        return color_map[normalized_color]
    else:
        raise ValueError(f"Invalid color: '{color}'. Valid colors are: {', '.join(color_map.keys())}")


def colors():
    """Return the list of all resistor color codes in order.
    
    Returns:
        list: A list of color names in the correct order.
    """
    return [
        'black',
        'brown', 
        'red',
        'orange',
        'yellow',
        'green',
        'blue',
        'violet',
        'grey',
        'white'
    ]