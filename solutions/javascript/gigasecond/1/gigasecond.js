//
// This is only a SKELETON file for the 'Gigasecond' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const gigasecond = (date) => {
  // A gigasecond is 1,000,000,000 seconds
  const gigasecondInMs = 1000000000 * 1000; // Convert to milliseconds
  
  // Create a new Date object to avoid mutating the input
  const resultDate = new Date(date.getTime() + gigasecondInMs);
  
  return resultDate;
};