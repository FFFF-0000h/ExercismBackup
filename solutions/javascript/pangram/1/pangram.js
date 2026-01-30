export const isPangram = (sentence) => {
  // Return false for empty or too short sentences
  if (!sentence || sentence.length < 26) {
    return false;
  }
  
  // Create a Set to track unique letters
  const letters = new Set();
  
  // Convert to lowercase and iterate through each character
  const lowerSentence = sentence.toLowerCase();
  
  for (let i = 0; i < lowerSentence.length; i++) {
    const char = lowerSentence[i];
    
    // Check if it's a letter (a-z)
    if (char >= 'a' && char <= 'z') {
      letters.add(char);
      
      // Early exit: if we've found all 26 letters, return true
      if (letters.size === 26) {
        return true;
      }
    }
  }
  
  // Check if we have all 26 letters
  return letters.size === 26;
};