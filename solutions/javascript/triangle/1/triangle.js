export class Triangle {
  constructor(...sides) {
    this.sides = sides;
  }

  isValid() {
    const [a, b, c] = this.sides;
    // All sides must be positive and satisfy triangle inequality
    return a > 0 && b > 0 && c > 0 &&
           a + b > c &&
           a + c > b &&
           b + c > a;
  }

  get isEquilateral() {
    if (!this.isValid()) return false;
    const [a, b, c] = this.sides;
    return a === b && b === c;
  }

  get isIsosceles() {
    if (!this.isValid()) return false;
    const [a, b, c] = this.sides;
    return a === b || a === c || b === c;
  }

  get isScalene() {
    if (!this.isValid()) return false;
    const [a, b, c] = this.sides;
    return a !== b && a !== c && b !== c;
  }
}