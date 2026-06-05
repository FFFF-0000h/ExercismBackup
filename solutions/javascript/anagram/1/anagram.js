export const findAnagrams = (target, candidates) => {
  const normalize = (word) => word.toLowerCase().split('').sort().join('');
  const targetNormalized = normalize(target);

  return candidates.filter(candidate => {
    // Not an anagram if same word (case-insensitive)
    if (candidate.toLowerCase() === target.toLowerCase()) {
      return false;
    }
    return normalize(candidate) === targetNormalized;
  });
};