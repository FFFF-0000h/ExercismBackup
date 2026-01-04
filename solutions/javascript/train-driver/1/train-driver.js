// @ts-check
//
// The line above enables type checking for this file. Various IDEs interpret
// the @ts-check directive. It will give you helpful autocompletion when
// implementing this exercise.

/**
 * Return each wagon's id in form of an array.
 *
 * @param {...number} ids
 * @returns {number[]} wagon ids
 */
export function getListOfWagons(...ids) {
  return ids;
}

/**
 * Reorder the array of wagons by moving the first 2 wagons to the end of the array.
 *
 * @param {Iterable<number>} ids
 * @returns {number[]} reordered list of wagons
 */
export function fixListOfWagons(ids) {
  // Convert iterable to array if needed
  const wagonArray = Array.from(ids);
  
  // Find the locomotive (ID = 1)
  const locoIndex = wagonArray.indexOf(1);
  
  if (locoIndex === -1) {
    // If no locomotive found, just move first 2 to end
    return [...wagonArray.slice(2), ...wagonArray.slice(0, 2)];
  }
  
  // Move locomotive to front and the two elements before it to the end
  return [
    wagonArray[locoIndex],
    ...wagonArray.slice(locoIndex + 1),
    ...wagonArray.slice(0, locoIndex)
  ];
}

/**
 * Fixes the array of wagons by inserting an array of wagons after the first element in eachWagonsID.
 *
 * @param {Iterable<number>} ids
 * @param {Iterable<number>} missingWagons
 * @returns {number[]} corrected list of wagons
 */
export function correctListOfWagons(ids, missingWagons) {
  const wagonArray = Array.from(ids);
  const missingArray = Array.from(missingWagons);
  
  // Insert missing wagons after the first element (locomotive)
  return [
    wagonArray[0],
    ...missingArray,
    ...wagonArray.slice(1)
  ];
}

/**
 * Extend route information by adding another object
 *
 * @param {Record<string, string>} information
 * @param {Record<string, string>} additional
 * @returns {Record<string, string>} extended route information
 */
export function extendRouteInformation(information, additional) {
  return {
    ...information,
    ...additional
  };
}

/**
 * Separate arrival time from the route information object
 *
 * @param {Record<string, string>} information
 * @returns {[string, Record<string, string>]} array with arrival time and object without arrival time
 */
export function separateTimeOfArrival(information) {
  const { timeOfArrival, ...rest } = information;
  return [timeOfArrival, rest];
}