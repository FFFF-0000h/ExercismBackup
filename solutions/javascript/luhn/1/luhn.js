export const valid = (number) => {
  // Remove all whitespace
  const cleaned = number.replace(/\s/g, '');
  
  // Strings of length 1 or less are not valid
  if (cleaned.length <= 1) {
    return false;
  }
  
  // Only digits are allowed after removing spaces
  if (/[^0-9]/.test(cleaned)) {
    return false;
  }
  
  let sum = 0;
  let shouldDouble = false; // start with rightmost digit not doubled
  
  // Process digits from right to left
  for (let i = cleaned.length - 1; i >= 0; i--) {
    let digit = parseInt(cleaned.charAt(i), 10);
    
    if (shouldDouble) {
      digit *= 2;
      if (digit > 9) {
        digit -= 9;
      }
    }
    
    sum += digit;
    shouldDouble = !shouldDouble;
  }
  
  return sum % 10 === 0;
};