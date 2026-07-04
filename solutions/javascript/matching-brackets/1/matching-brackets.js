//
// This is only a SKELETON file for the 'Matching Brackets' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const isPaired = (input) => {
  // Stack to keep track of opening brackets
  const stack = [];
  
  // Map of closing brackets to their corresponding opening brackets
  const bracketPairs = {
    ')': '(',
    ']': '[',
    '}': '{'
  };
  
  // Set of opening brackets for quick lookup
  const openingBrackets = new Set(['(', '[', '{']);
  
  // Process each character in the input
  for (const char of input) {
    // If it's an opening bracket, push it onto the stack
    if (openingBrackets.has(char)) {
      stack.push(char);
    } 
    // If it's a closing bracket, check if it matches
    else if (char in bracketPairs) {
      // If stack is empty or top of stack doesn't match, it's unbalanced
      if (stack.length === 0 || stack.pop() !== bracketPairs[char]) {
        return false;
      }
    }
    // Ignore all other characters
  }
  
  // If stack is empty, all brackets were properly matched
  return stack.length === 0;
};