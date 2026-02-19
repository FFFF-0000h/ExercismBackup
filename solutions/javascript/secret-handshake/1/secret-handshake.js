export const commands = (number) => {
  const actions = ['wink', 'double blink', 'close your eyes', 'jump'];
  const result = [];

  // Check the first four bits (0 to 3)
  for (let i = 0; i < 4; i++) {
    if (number & (1 << i)) {
      result.push(actions[i]);
    }
  }

  // If the fifth bit (16) is set, reverse the order
  if (number & (1 << 4)) {
    result.reverse();
  }

  return result;
};