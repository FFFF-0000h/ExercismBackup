def encode(plain_text):
    # Define the Atbash mapping for lowercase letters
    plain = 'abcdefghijklmnopqrstuvwxyz'
    cipher = plain[::-1]
    trans = str.maketrans(plain + plain.upper(), cipher + cipher)

    # Process each character: keep letters (converted) and digits
    cleaned = []
    for ch in plain_text:
        if ch.isalpha():
            # Apply mapping and ensure lowercase output
            cleaned.append(ch.lower().translate(trans))
        elif ch.isdigit():
            cleaned.append(ch)
        # else ignore punctuation and spaces

    # Group into chunks of 5
    result = []
    for i in range(0, len(cleaned), 5):
        result.append(''.join(cleaned[i:i+5]))
    return ' '.join(result)


def decode(ciphered_text):
    # Remove spaces
    combined = ciphered_text.replace(' ', '')
    # Atbash is symmetric, so we can use the same mapping
    plain = 'abcdefghijklmnopqrstuvwxyz'
    cipher = plain[::-1]
    trans = str.maketrans(cipher, plain)  # reverse mapping
    decoded = []
    for ch in combined:
        if ch.isalpha():
            decoded.append(ch.lower().translate(trans))
        else:
            decoded.append(ch)
    return ''.join(decoded)