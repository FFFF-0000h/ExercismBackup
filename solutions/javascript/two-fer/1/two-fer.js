//
// This is only a SKELETON file for the 'Two fer' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const twoFer = (name) => {
  // If name is not provided, use "you"
  const person = name || 'you';
  return `One for ${person}, one for me.`;
};