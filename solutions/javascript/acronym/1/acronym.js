export const parse = (phrase) => {
  // Replace hyphens with spaces, then split on whitespace and non-letters
  const words = phrase
    .replace(/-/g, ' ')
    .replace(/[^a-zA-Z\s]/g, '')
    .split(/\s+/)
    .filter(word => word.length > 0);

  // Take the first letter of each word, uppercase it, and join
  return words
    .map(word => word[0].toUpperCase())
    .join('');
};