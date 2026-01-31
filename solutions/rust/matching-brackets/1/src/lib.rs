pub fn brackets_are_balanced(string: &str) -> bool {
    let mut stack = Vec::new();
    
    for ch in string.chars() {
        match ch {
            // Opening brackets - push onto stack
            '(' => stack.push(')'),
            '[' => stack.push(']'),
            '{' => stack.push('}'),
            
            // Closing brackets - check if they match the top of stack
            ')' | ']' | '}' => {
                if stack.pop() != Some(ch) {
                    return false;
                }
            }
            
            // Ignore all other characters
            _ => continue,
        }
    }
    
    // If stack is empty, all brackets were properly matched
    stack.is_empty()
}