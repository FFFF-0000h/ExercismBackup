def is_isogram(string):
    # Create a set to track seen letters
    seen = set()
    
    # Iterate through each character in the string
    for char in string.lower():  # Convert to lowercase for case-insensitive comparison
        # Skip spaces and hyphens (they're allowed to repeat)
        if char == ' ' or char == '-':
            continue
        
        # Check if we've seen this letter before
        if char in seen:
            return False
        
        # Add the letter to our set of seen letters
        seen.add(char)
    
    # If we get here, no repeating letters were found
    return True