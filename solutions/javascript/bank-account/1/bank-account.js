export class BankAccount {
  #isOpen = false;
  #balance = 0;

  open() {
    if (this.#isOpen) {
      throw new ValueError();
    }
    this.#isOpen = true;
    this.#balance = 0;
  }

  close() {
    if (!this.#isOpen) {
      throw new ValueError();
    }
    this.#isOpen = false;
  }

  deposit(amount) {
    if (!this.#isOpen || amount <= 0) {
      throw new ValueError();
    }
    this.#balance += amount;
  }

  withdraw(amount) {
    if (!this.#isOpen || amount <= 0 || amount > this.#balance) {
      throw new ValueError();
    }
    this.#balance -= amount;
  }

  get balance() {
    if (!this.#isOpen) {
      throw new ValueError();
    }
    return this.#balance;
  }

  set balance(_value) {
    throw new Error('Cannot set balance directly');
  }
}

export class ValueError extends Error {
  constructor() {
    super('Bank account error');
  }
}