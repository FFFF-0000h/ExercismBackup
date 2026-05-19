export class Robot {
  static usedNames = new Set();

  #name;
  #previousNames = new Set();

  constructor() {
    this.#name = Robot.generateUniqueName(this.#previousNames);
    Robot.usedNames.add(this.#name);
    this.#previousNames.add(this.#name);
  }

  get name() {
    return this.#name;
  }

  reset() {
    Robot.usedNames.delete(this.#name);
    this.#name = Robot.generateUniqueName(this.#previousNames);
    Robot.usedNames.add(this.#name);
    this.#previousNames.add(this.#name);
  }

  static generateUniqueName(excludeSet = new Set()) {
    let name;
    do {
      const letter1 = String.fromCharCode(65 + Math.floor(Math.random() * 26));
      const letter2 = String.fromCharCode(65 + Math.floor(Math.random() * 26));
      const digits = Math.floor(Math.random() * 1000).toString().padStart(3, '0');
      name = letter1 + letter2 + digits;
    } while (Robot.usedNames.has(name) || excludeSet.has(name));
    return name;
  }

  static releaseNames() {
    Robot.usedNames.clear();
  }
}