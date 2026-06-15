export const primeFactors = (number) => {
  const factors = [];
  let remaining = number;
  let divisor = 2;

  while (divisor * divisor <= remaining) {
    while (remaining % divisor === 0) {
      factors.push(divisor);
      remaining /= divisor;
    }
    divisor++;
  }

  if (remaining > 1) {
    factors.push(remaining);
  }

  return factors;
};