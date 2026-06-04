export class Palindromes {
  static generate({ maxFactor, minFactor = 1 }) {
    if (minFactor > maxFactor) {
      throw new Error('min must be <= max');
    }

    let smallest = { value: null, factors: [] };
    let largest = { value: null, factors: [] };

    for (let a = minFactor; a <= maxFactor; a++) {
      for (let b = a; b <= maxFactor; b++) {
        const product = a * b;
        if (!isPalindrome(product)) continue;

        // Check smallest
        if (smallest.value === null || product < smallest.value) {
          smallest.value = product;
          smallest.factors = [[a, b]];
        } else if (product === smallest.value) {
          smallest.factors.push([a, b]);
        }

        // Check largest
        if (largest.value === null || product > largest.value) {
          largest.value = product;
          largest.factors = [[a, b]];
        } else if (product === largest.value) {
          largest.factors.push([a, b]);
        }
      }
    }

    return {
      smallest: smallest.value !== null ? smallest : { value: null, factors: [] },
      largest: largest.value !== null ? largest : { value: null, factors: [] },
    };
  }
}

function isPalindrome(num) {
  const str = num.toString();
  const reversed = str.split('').reverse().join('');
  return str === reversed;
}