/// Determines whether the supplied string is a valid ISBN number
pub fn is_valid_isbn(isbn: &str) -> bool {
    // Remove hyphens and collect the remaining characters.
    let digits: Vec<char> = isbn.chars().filter(|&c| c != '-').collect();

    // Must have exactly 10 characters after removing hyphens.
    if digits.len() != 10 {
        return false;
    }

    let mut sum = 0;
    for (i, &ch) in digits.iter().enumerate() {
        let value = if i < 9 {
            // First nine characters must be digits.
            match ch.to_digit(10) {
                Some(d) => d,
                None => return false,
            }
        } else {
            // Last character can be a digit or 'X' (case‑insensitive).
            match ch {
                '0'..='9' => ch.to_digit(10).unwrap(),
                'X' | 'x' => 10,
                _ => return false,
            }
        };
        // Weight: first digit gets 10, second gets 9, …, last gets 1.
        let weight = (10 - i) as u32;
        sum += value * weight;
    }

    sum % 11 == 0
}