pub fn check(candidate: &str) -> bool {
    let mut seen = 0u32; // bitmask for letters a-z
    for c in candidate.chars() {
        if c.is_ascii_alphabetic() {
            let idx = (c.to_ascii_lowercase() as u8 - b'a') as u32;
            if seen & (1 << idx) != 0 {
                return false; // duplicate letter found
            }
            seen |= 1 << idx;
        }
        // spaces and hyphens are ignored
    }
    true
}