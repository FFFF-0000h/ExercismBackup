pub fn series(digits: &str, len: usize) -> Vec<String> {
    // Handle edge cases
    if len == 0 {
        // Return empty strings for each position
        // This matches the mathematical property described
        return vec!["".to_string(); digits.len() + 1];
    }
    
    // If requested length is longer than the string, return empty vector
    if len > digits.len() {
        return Vec::new();
    }
    
    let mut result = Vec::new();
    
    // Iterate through all possible starting positions
    for i in 0..=digits.len() - len {
        // Get substring of length len starting at position i
        let substring = &digits[i..i + len];
        result.push(substring.to_string());
    }
    
    result
}