"""
Pig Latin Translator Module

Provides functionality to translate English text to Pig Latin
following standard Pig Latin rules.
"""


class PigLatinTranslator:
    """Translates English text to Pig Latin using standard rules."""
    
    # Constants for clarity and easy modification
    VOWELS = set("aeiou")
    CONSONANTS = set("bcdfghjklmnpqrstvwxyz")
    VOWEL_SOUNDS = ("a", "e", "i", "o", "u", "xr", "yt")
    
    def translate(self, text: str) -> str:
        """
        Translate English text to Pig Latin.
        
        Args:
            text: English text (single word or phrase)
            
        Returns:
            Pig Latin translation
            
        Raises:
            ValueError: If text is empty or contains no translatable characters
        """
        if not text or not text.strip():
            raise ValueError("Input text cannot be empty")
        
        words = text.split()
        translated_words = [self._translate_word(word) for word in words]
        return " ".join(translated_words)
    
    def _translate_word(self, word: str) -> str:
        """
        Translate a single word to Pig Latin.
        
        Args:
            word: Single English word
            
        Returns:
            Pig Latin translation of the word
        """
        if not word:
            return word
        
        # Preserve original case pattern
        is_title = word.istitle()
        is_upper = word.isupper()
        lower_word = word.lower()
        
        # Rule 1: Word starts with a vowel sound
        if self._starts_with_vowel_sound(lower_word):
            translated_result = word + "ay"
        else:
            # Rule 2-4: Word starts with consonant(s)
            prefix = self._get_consonant_prefix(lower_word)
            translated_result = word[len(prefix):] + prefix + "ay"
        
        # Restore case if needed
        if is_upper:
            return translated_result.upper()
        if is_title:
            return translated_result.title()
        return translated_result
    
    def _starts_with_vowel_sound(self, word: str) -> bool:
        """Check if word starts with a vowel sound."""
        return word.startswith(self.VOWEL_SOUNDS)
    
    def _get_consonant_prefix(self, word: str) -> str:
        """
        Extract the consonant prefix from the start of a word.
        
        Handles special cases:
        - "y" treated as vowel after consonants
        - "qu" treated as consonant cluster
        """
        prefix = []
        
        for index, char in enumerate(word):
            # Rule 4: "y" after consonants acts as vowel
            if char == "y" and index > 0:
                break
                
            # Rule 3: Handle "qu" as consonant cluster
            if char == "q" and index + 1 < len(word) and word[index + 1] == "u":
                prefix.extend(["q", "u"])
                return "".join(prefix)
            
            # Regular consonant
            if char in self.CONSONANTS:
                prefix.append(char)
            else:
                break
        
        # Check if prefix ends with "q" and next char is "u" 
        # (catches cases where we"ve already collected consonants before "qu")
        if prefix and prefix[-1] == "q" and len(prefix) < len(word) and word[len(prefix)] == "u":
            prefix.append("u")
        
        return "".join(prefix)


# Convenience function maintaining backward compatibility
def translate(text: str) -> str:
    """
    Translate English text to Pig Latin.
    
    Args:
        text: English text to translate
        
    Returns:
        Pig Latin translation
    """
    pig_latin_translator = PigLatinTranslator()
    return pig_latin_translator.translate(text)


# Example usage and testing
if __name__ == "__main__":
    test_cases = [
        ("hello", "ellohay"),
        ("apple", "appleay"),
        ("xray", "xrayay"),
        ("yttria", "yttriaay"),
        ("square", "aresquay"),
        ("queen", "eenquay"),
        ("rhythm", "ythmrhay"),
        ("my", "ymay"),
        ("quick fast run", "ickquay astfay unray"),
        ("HELLO", "ELLOHAY"),  # Preserves uppercase
        ("Hello", "Ellohay"),  # Preserves title case
        ("", ""),  # Empty string handled gracefully
    ]
    
    pig_latin_translator = PigLatinTranslator()
    
    print("Pig Latin Translator Tests:")
    print("-" * 40)
    
    for input_text, expected in test_cases:
        try:
            test_result = pig_latin_translator.translate(input_text)
            status = "✓" if test_result == expected else "✗"
            print(f"{status} '{input_text}' -> '{test_result}' (expected: '{expected}')")
        except ValueError as e:
            print(f"✗ '{input_text}' -> Error: {e}")
    
    # Interactive mode
    print("\n" + "=" * 40)
    print('Interactive Pig Latin Translator (type "quit" to exit)')
    print("=" * 40)
    
    while True:
        try:
            user_input = input("\nEnter text: ").strip()
            if user_input.lower() == "quit":
                break
            if user_input:
                print(f"Pig Latin: {pig_latin_translator.translate(user_input)}")
        except ValueError as e:
            print(f"Error: {e}")
        except KeyboardInterrupt:
            break