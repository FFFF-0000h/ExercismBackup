//
// This is only a SKELETON file for the 'Difference Of Squares' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Squares {
  constructor(n) {
    this.n = n;
  }

  get sumOfSquares() {
    const n = this.n;
    // Formula: n(n+1)(2n+1)/6
    return (n * (n + 1) * (2 * n + 1)) / 6;
  }

  get squareOfSum() {
    const n = this.n;
    const sum = (n * (n + 1)) / 2;
    return sum * sum;
  }

  get difference() {
    return this.squareOfSum - this.sumOfSquares;
  }
}