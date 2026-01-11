"""Functions for creating, transforming, and adding prefixes to strings."""

def add_prefix_un(word):
    """Take the given word and add the 'un' prefix.

    :param word: str - containing the root word.
    :return: str - of root word prepended with 'un'.
    """
    return "un" + word


def make_word_groups(vocab_words):
    """Transform a list containing a prefix and words into a string with the prefix followed by the words with prefix prepended.

    :param vocab_words: list - of vocabulary words with prefix in first index.
    :return: str - of prefix followed by vocabulary words with
            prefix applied.

    This function takes a `vocab_words` list and returns a string
    with the prefix and the words with prefix applied, separated
     by ' :: '.

    For example: list('en', 'close', 'joy', 'lighten'),
    produces the following string: 'en :: enclose :: enjoy :: enlighten'.
    """
    prefix = vocab_words[0]
    words = vocab_words[1:]
    
    # Apply prefix to all words and join with ' :: '
    prefixed_words = [prefix + word for word in words]
    
    # Combine with the prefix itself at the beginning
    result = [prefix] + prefixed_words
    
    return " :: ".join(result)


def remove_suffix_ness(word):
    """Remove the suffix from the word while keeping spelling in mind.

    :param word: str - of word to remove suffix from.
    :return: str - of word with suffix removed & spelling adjusted.

    For example: "heaviness" becomes "heavy", but "sadness" becomes "sad".
    """
    # Remove the 'ness' suffix
    if word.endswith('ness'):
        root = word[:-4]  # Remove last 4 characters ('ness')
        
        # Check if the root ends with 'i' (consonant + y changed to i)
        if root.endswith('i'):
            # Change 'i' back to 'y'
            root = root[:-1] + 'y'
        
        return root
    
    return word  # Return original if it doesn't end with 'ness'


def adjective_to_verb(sentence, index):
    """Change the adjective within the sentence to a verb.

    :param sentence: str - that uses the word in sentence.
    :param index: int - index of the word to remove and transform.
    :return: str - word that changes the extracted adjective to a verb.

    For example, ("It got dark as the sun set.", 2) becomes "darken".
    """
    # Remove punctuation and split into words
    # Remove common punctuation marks
    cleaned_sentence = sentence.replace('.', '').replace('!', '').replace('?', '').replace(',', '')
    words = cleaned_sentence.split()
    
    # Get the adjective at the specified index
    adjective = words[index]
    
    # Add 'en' suffix to make it a verb
    return adjective + "en"