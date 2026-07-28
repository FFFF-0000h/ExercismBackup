"""Conversation with Bob."""


def response(hey_bob):
    """Check for conversational cues and words."""

    
    # Remove leading/trailing whitespace
    hey_bob = hey_bob.strip()
    
    # Check for silence (empty after stripping)
    if not hey_bob:
        return "Fine. Be that way!"
    
    # Check if it's a question (ends with '?')
    is_question = hey_bob.endswith("?")
    
    # Check if it's yelling (all letters are uppercase and there's at least one letter)
    # We need to check if there's at least one letter to avoid false positives like "1, 2, 3"
    has_letters = any(letter.isalpha() for letter in hey_bob)
    is_yelling = has_letters and hey_bob.upper() == hey_bob
    
    # Determine response based on combinations
    if is_question and is_yelling:
        return "Calm down, I know what I'm doing!"
    if is_question:
        return "Sure."
    if is_yelling:
        return "Whoa, chill out!"
    else:
        return "Whatever."