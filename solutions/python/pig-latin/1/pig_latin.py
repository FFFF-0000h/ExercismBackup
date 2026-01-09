def translate(text):
    """
    Translate English text to Pig Latin based on the given rules.
    
    Rules:
    1. If word begins with vowel or starts with "xr" or "yt": add "ay"
    2. If word begins with consonants: move consonants to end, add "ay"
    3. If word starts with consonants + "qu": move consonants + "qu" to end, add "ay"
    4. If word starts with consonants + "y": move consonants to end, add "ay"
    """
    vowels = {'a', 'e', 'i', 'o', 'u'}
    result = []
    
    for word in text.split():
        # Rule 1: Check for vowel, "xr", or "yt" at the beginning
        if word[0] in vowels or word.startswith("xr") or word.startswith("yt"):
            result.append(word + "ay")
            continue
        
        # Find where to split the word
        i = 0
        found_qu = False
        found_y = False
        
        # Check for patterns
        while i < len(word):
            # Check for "qu" pattern
            if i + 1 < len(word) and word[i:i+2] == "qu":
                i += 2  # Include "qu"
                found_qu = True
                break
            
            # Check for "y" after consonants
            if word[i] == 'y' and i > 0:  # y after at least one consonant
                found_y = True
                break
            
            # Check if we've hit a vowel
            if word[i] in vowels:
                break
            
            i += 1
        
        # Apply the appropriate transformation
        if found_qu:
            # Move everything up to and including "qu" to the end
            result.append(word[i:] + word[:i] + "ay")
        elif found_y:
            # Move consonants before "y" to the end
            result.append(word[i:] + word[:i] + "ay")
        else:
            # Move consonants to the end
            result.append(word[i:] + word[:i] + "ay")
    
    return " ".join(result)