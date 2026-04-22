"""Secret handshake exercise module."""

def commands(binary_str: str) -> list[str]:
    """Convert a binary string to a sequence of secret handshake actions.
    
    The binary string should be up to 5 digits long. Each bit corresponds
    to an action, with the rightmost bit representing 'wink'. The leftmost
    bit, if set, reverses the order of the actions.
    
    Args:
        binary_str: A string of '0's and '1's representing the binary code.
    
    Returns:
        A list of action strings in the correct order.
    """
    # Pad the binary string to 5 digits with leading zeros
    padded = binary_str.zfill(5)
    
    # Define actions corresponding to bits from rightmost (index 0) to leftmost (index 4)
    actions = [
        "wink",            # 1
        "double blink",    # 10
        "close your eyes", # 100
        "jump",            # 1000
        "reverse"          # 10000 (handled separately)
    ]
    
    result = []
    # Process bits 0 to 3 (rightmost four bits)
    for bit_index in range(4):
        # Check bit at position bit_index from the right
        # In padded string, rightmost is index 4, then 3,2,1,0
        if padded[4 - bit_index] == "1":
            result.append(actions[bit_index])
    
    # Check the 5th bit (reverse)
    if padded[0] == "1":  # leftmost bit
        result.reverse()
        
    return result