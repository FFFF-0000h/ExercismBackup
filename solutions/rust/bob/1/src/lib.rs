pub fn reply(message: &str) -> &str {
    // First, check for silence (only whitespace or empty)
    let is_silent = message.trim().is_empty();
    
    if is_silent {
        return "Fine. Be that way!";
    }
    
    // Check if the message is a question (ends with '?' after removing trailing whitespace)
    let trimmed = message.trim();
    let is_question = trimmed.ends_with('?');
    
    // Check if the message is yelling:
    // - Has at least one alphabetic character (to exclude non-text yelling)
    // - All alphabetic characters are uppercase
    let has_alphabetic = message.chars().any(|c| c.is_alphabetic());
    let is_yelling = has_alphabetic && message.to_uppercase() == message;
    
    // Determine the response based on the conditions
    match (is_question, is_yelling) {
        (true, true) => "Calm down, I know what I'm doing!",
        (true, false) => "Sure.",
        (false, true) => "Whoa, chill out!",
        (false, false) => "Whatever.",
    }
}