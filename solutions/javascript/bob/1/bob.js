export const hey = (message) => {
  // Remove leading/trailing whitespace
  const trimmed = message.trim();
  
  // Check for silence first (empty or only whitespace)
  if (trimmed === '') {
    return 'Fine. Be that way!';
  }
  
  // Check if it's yelling (all caps AND has at least one letter)
  const isYelling = /[A-Z]/.test(trimmed) && trimmed === trimmed.toUpperCase();
  
  // Check if it's a question (ends with question mark)
  const isQuestion = trimmed.endsWith('?');
  
  // Determine response based on conditions
  if (isYelling && isQuestion) {
    return 'Calm down, I know what I\'m doing!';
  }
  
  if (isYelling) {
    return 'Whoa, chill out!';
  }
  
  if (isQuestion) {
    return 'Sure.';
  }
  
  // Default response
  return 'Whatever.';
};