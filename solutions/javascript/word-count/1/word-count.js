export const countWords = (phrase) => {
  // match sequences of letters, digits, and apostrophes (for contractions)
  const words = phrase.match(/[a-zA-Z0-9']+/g) || [];

  const counts = {};

  for (const word of words) {
    // remove any leading/trailing apostrophes (e.g., quoted words like 'large')
    const cleaned = word.replace(/^'+|'+$/g, '').toLowerCase();
    if (cleaned !== '') {
      counts[cleaned] = (counts[cleaned] || 0) + 1;
    }
  }

  return counts;
};