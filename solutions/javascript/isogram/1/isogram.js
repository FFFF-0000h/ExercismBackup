//
// This is only a SKELETON file for the 'Isogram' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const isIsogram = (word) => {
  // Convert to lowercase and remove spaces and hyphens
  const cleaned = word.toLowerCase().replace(/[\s-]/g, '');
  
  // Use a Set to track seen letters
  const seenLetters = new Set();
  
  for (const letter of cleaned) {
    if (seenLetters.has(letter)) {
      return false;
    }
    seenLetters.add(letter);
  }
  
  return true;
};