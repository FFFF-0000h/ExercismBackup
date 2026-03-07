export const transform = (old) => {
  const result = {};
  for (const [score, letters] of Object.entries(old)) {
    const points = parseInt(score, 10);
    for (const letter of letters) {
      result[letter.toLowerCase()] = points;
    }
  }
  return result;
};