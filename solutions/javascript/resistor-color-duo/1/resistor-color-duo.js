//
// This is only a SKELETON file for the 'Resistor Color Duo' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const decodedValue = (colors) => {
  // Color to value mapping
  const colorMap = {
    'black': 0,
    'brown': 1,
    'red': 2,
    'orange': 3,
    'yellow': 4,
    'green': 5,
    'blue': 6,
    'violet': 7,
    'grey': 8,
    'white': 9
  };
  
  // Take only the first two colors and convert to numbers
  const firstValue = colorMap[colors[0].toLowerCase()];
  const secondValue = colorMap[colors[1].toLowerCase()];
  
  // Combine: first digit * 10 + second digit
  return firstValue * 10 + secondValue;
};