export const format = (name, number) => {
  // Validate inputs
  if (!name || typeof name !== 'string') {
    throw new Error('Name must be a non-empty string');
  }
  
  if (!Number.isInteger(number) || number < 1 || number > 999) {
    throw new Error('Number must be an integer between 1 and 999');
  }
  
  // Get the ordinal suffix
  let suffix = 'th'; // default
  
  // Handle special cases: 11, 12, 13
  const lastTwoDigits = number % 100;
  if (lastTwoDigits >= 11 && lastTwoDigits <= 13) {
    suffix = 'th';
  } else {
    // Handle other cases based on last digit
    const lastDigit = number % 10;
    switch (lastDigit) {
      case 1:
        suffix = 'st';
        break;
      case 2:
        suffix = 'nd';
        break;
      case 3:
        suffix = 'rd';
        break;
      default:
        suffix = 'th';
    }
  }
  
  // Construct and return the formatted message
  return `${name}, you are the ${number}${suffix} customer we serve today. Thank you!`;
};