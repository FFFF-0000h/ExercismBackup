def rotate(text, key):
    result = []
    key = key % 26  # Normalize key to 0-25
    
    for char in text:
        if char.isalpha():
            # Determine the base (A for uppercase, a for lowercase)
            base = ord('A') if char.isupper() else ord('a')
            # Shift the character and wrap around using modulo 26
            shifted = (ord(char) - base + key) % 26
            result.append(chr(base + shifted))
        else:
            # Keep non-alphabet characters unchanged
            result.append(char)
    
    return ''.join(result)