export function triplets({ minFactor = 1, maxFactor, sum }) {
  const result = [];

  // If maxFactor is not provided, set to sum (since a,b,c < sum)
  const maxA = maxFactor ?? sum;
  const maxB = maxFactor ?? sum;
  const maxC = maxFactor ?? sum;

  // a < b < c and a + b + c = sum
  // Also: a² + b² = c²
  // Since a < b < c, a can be at most (sum / 3) - 1
  const limitA = Math.min(maxA, Math.floor(sum / 3));

  for (let a = minFactor; a <= limitA; a++) {
    // b must be greater than a and less than c
    // From a + b + c = sum and a < b < c:
    // b < (sum - a) / 2
    const limitB = Math.min(maxB, Math.floor((sum - a) / 2));

    for (let b = a + 1; b <= limitB; b++) {
      const c = sum - a - b;

      if (c > maxC) continue;

      // Check Pythagorean theorem
      if (a * a + b * b === c * c) {
        result.push(new Triplet(a, b, c));
      }
    }
  }

  return result;
}

class Triplet {
  constructor(a, b, c) {
    this.a = a;
    this.b = b;
    this.c = c;
  }

  toArray() {
    return [this.a, this.b, this.c];
  }
}