pub fn answer(command: &str) -> Option<i32> {
    // Remove "What is " prefix and "?" suffix
    let command = command.strip_prefix("What is ")?;
    let command = command.strip_suffix("?")?;
    
    // Tokenize manually to handle negative numbers
    let tokens = tokenize(command);
    
    if tokens.is_empty() {
        return None;
    }
    
    // Parse the first number
    let mut result: i32 = tokens[0].parse().ok()?;
    let mut i = 1;
    
    // Process operations in sequence
    while i < tokens.len() {
        // Check for valid operation pattern
        if i >= tokens.len() {
            return None;
        }
        
        let operation = tokens[i].as_str();
        
        match operation {
            "plus" => {
                if i + 1 >= tokens.len() {
                    return None;
                }
                result += tokens[i + 1].parse::<i32>().ok()?;
                i += 2;
            },
            "minus" => {
                if i + 1 >= tokens.len() {
                    return None;
                }
                result -= tokens[i + 1].parse::<i32>().ok()?;
                i += 2;
            },
            "multiplied" => {
                // Expected: "multiplied" "by" <number>
                if i + 2 >= tokens.len() || tokens[i + 1].as_str() != "by" {
                    return None;
                }
                result *= tokens[i + 2].parse::<i32>().ok()?;
                i += 3; // Skip "multiplied", "by", and the number
            },
            "divided" => {
                // Expected: "divided" "by" <number>
                if i + 2 >= tokens.len() || tokens[i + 1].as_str() != "by" {
                    return None;
                }
                let divisor = tokens[i + 2].parse::<i32>().ok()?;
                if divisor == 0 {
                    return None;
                }
                result /= divisor;
                i += 3; // Skip "divided", "by", and the number
            },
            _ => return None, // Unknown operation
        }
    }
    
    Some(result)
}

fn tokenize(input: &str) -> Vec<String> {
    let mut tokens = Vec::new();
    let chars: Vec<char> = input.chars().collect();
    let mut i = 0;
    
    while i < chars.len() {
        // Skip whitespace
        if chars[i].is_whitespace() {
            i += 1;
            continue;
        }
        
        // Check for negative number
        if chars[i] == '-' && i + 1 < chars.len() && chars[i + 1].is_ascii_digit() {
            let mut number = String::from('-');
            i += 1;
            while i < chars.len() && chars[i].is_ascii_digit() {
                number.push(chars[i]);
                i += 1;
            }
            tokens.push(number);
            continue;
        }
        
        // Check for positive number
        if chars[i].is_ascii_digit() {
            let mut number = String::new();
            while i < chars.len() && chars[i].is_ascii_digit() {
                number.push(chars[i]);
                i += 1;
            }
            tokens.push(number);
            continue;
        }
        
        // It's a word token
        let mut word = String::new();
        while i < chars.len() && !chars[i].is_whitespace() {
            word.push(chars[i]);
            i += 1;
        }
        tokens.push(word);
    }
    
    tokens
}