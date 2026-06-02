/**
 * You can use the bigint type and BigInt global object to support numbers below
 * Number.MIN_SAFE_INTEGER and above NUMBER.MAX_SAFE_INTEGER.
 *
 * https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/BigInt
 */

export const square = (num) => {
  if (num < 1 || num > 64) {
    throw new Error('square must be between 1 and 64');
  }
  return 1n << BigInt(num - 1);
};

export const total = () => {
  return (1n << 64n) - 1n;
};