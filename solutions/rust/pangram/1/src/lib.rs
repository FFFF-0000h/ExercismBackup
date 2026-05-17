/// Determine whether a sentence is a pangram.
pub fn is_pangram(sentence: &str) -> bool {
    let mut seen = 0u32; // bitmask for letters a-z (0-25)
    
    for ch in sentence.chars() {
        if ch.is_ascii_alphabetic() {
            // Convert to lowercase and map 'a'..='z' to 0..25
            let idx = (ch.to_ascii_lowercase() as u8 - b'a') as usize;
            seen |= 1 << idx;
        }
    }
    
    // All 26 letters seen?
    seen == (1 << 26) - 1
}