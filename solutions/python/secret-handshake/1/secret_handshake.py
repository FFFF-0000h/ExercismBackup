def commands(binary_str):
    # Pad the binary string to 5 digits with leading zeros
    padded = binary_str.zfill(5)
    
    # Define actions corresponding to bits from rightmost (index 0) to leftmost (index 4)
    actions = [
        "wink",           # 1
        "double blink",   # 10
        "close your eyes",# 100
        "jump",           # 1000
        "reverse"         # 10000 (handled separately)
    ]
    
    result = []
    # Process bits 0 to 3 (rightmost four bits)
    for i in range(4):
        # Check bit at position i from the right
        # In padded string, rightmost is index 4, then 3,2,1,0
        if padded[4 - i] == '1':
            result.append(actions[i])
    
    # Check the 5th bit (reverse)
    if padded[0] == '1':  # leftmost bit
        result.reverse()
        
    return result