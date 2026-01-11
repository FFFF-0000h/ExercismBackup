/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    // Remove all spaces
    let code_without_spaces: String = code.chars().filter(|c| !c.is_whitespace()).collect();
    
    // Check length - must be > 1
    if code_without_spaces.len() <= 1 {
        return false;
    }
    
    // Check if all characters are digits
    if !code_without_spaces.chars().all(|c| c.is_ascii_digit()) {
        return false;
    }
    
    // Apply Luhn algorithm
    let sum: u32 = code_without_spaces
        .chars()
        .rev()
        .enumerate()
        .map(|(i, c)| {
            let mut digit = c.to_digit(10).unwrap();
            
            // Double every second digit (starting from the rightmost, which is index 0)
            if i % 2 == 1 {
                digit *= 2;
                if digit > 9 {
                    digit -= 9;
                }
            }
            
            digit
        })
        .sum();
    
    sum % 10 == 0
}