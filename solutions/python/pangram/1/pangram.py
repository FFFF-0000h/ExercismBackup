def is_pangram(sentence):
    # Create a set of lowercase letters from the sentence
    # We only care about alphabetic characters
    letters_found = set()
    
    for char in sentence:
        if char.isalpha():
            letters_found.add(char.lower())
    
    # Check if we have all 26 letters
    return len(letters_found) == 26