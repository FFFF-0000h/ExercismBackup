export class Allergies {
  static ALLERGENS = [
    ['eggs', 1],
    ['peanuts', 2],
    ['shellfish', 4],
    ['strawberries', 8],
    ['tomatoes', 16],
    ['chocolate', 32],
    ['pollen', 64],
    ['cats', 128],
  ];

  constructor(score) {
    this.score = score & 255; // ignore allergens beyond the defined ones
  }

  list() {
    const result = [];
    for (const [allergen, value] of Allergies.ALLERGENS) {
      if (this.score & value) {
        result.push(allergen);
      }
    }
    return result;
  }

  allergicTo(allergen) {
    const allergenMap = Object.fromEntries(Allergies.ALLERGENS);
    const bit = allergenMap[allergen];
    return bit !== undefined && (this.score & bit) !== 0;
  }
}