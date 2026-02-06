pub fn abbreviate(phrase: &str) -> String {
    let mut acronym = String::new();
    let mut prev_char = ' ';
    
    for ch in phrase.chars() {
        // Check if this character should start a new acronym letter
        if ch.is_alphabetic() && !prev_char.is_alphabetic() {
            // Add uppercase version to acronym
            acronym.push(ch.to_ascii_uppercase());
        }
        // Handle camelCase words (e.g., "HyperText" -> "HT")
        else if ch.is_uppercase() && prev_char.is_lowercase() {
            acronym.push(ch);
        }
        
        // Update previous character for next iteration
        if ch != '\'' {
            prev_char = ch;
        }
    }
    
    acronym
}