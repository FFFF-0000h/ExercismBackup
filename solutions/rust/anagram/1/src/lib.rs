use std::collections::HashSet;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    // Helper function to normalize a string for comparison
    fn normalize(s: &str) -> Vec<char> {
        let mut chars: Vec<char> = s.to_lowercase().chars().collect();
        chars.sort_unstable();
        chars
    }
    
    let word_lower = word.to_lowercase();
    let word_normalized = normalize(word);
    
    possible_anagrams
        .iter()
        .filter(|&&candidate| {
            // A word is not its own anagram (case-insensitive)
            if candidate.to_lowercase() == word_lower {
                return false;
            }
            // Check if normalized forms are equal
            normalize(candidate) == word_normalized
        })
        .copied()
        .collect()
}