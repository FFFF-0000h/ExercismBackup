//
// This is only a SKELETON file for the 'Simple Cipher' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Cipher {
  constructor(key) {
    if (key === undefined) {
      // Generate random key of at least 100 lowercase letters
      this._key = this._generateRandomKey();
    } else {
      this._validateKey(key);
      this._key = key;
    }
  }

  _validateKey(key) {
    if (key === '') {
      throw new Error('Bad key');
    }
    
    // Key must contain only lowercase letters a-z
    if (!/^[a-z]+$/.test(key)) {
      throw new Error('Bad key');
    }
  }

  _generateRandomKey() {
    const letters = 'abcdefghijklmnopqrstuvwxyz';
    let key = '';
    
    // Generate at least 100 random lowercase letters
    for (let i = 0; i < 100; i++) {
      const randomIndex = Math.floor(Math.random() * 26);
      key += letters[randomIndex];
    }
    
    return key;
  }

  encode(plaintext) {
    let ciphertext = '';
    
    for (let i = 0; i < plaintext.length; i++) {
      const plainChar = plaintext[i];
      const keyChar = this._key[i % this._key.length];
      
      if (/[a-z]/.test(plainChar)) {
        // Calculate shift: 'a' = 0, 'b' = 1, etc.
        const plainCode = plainChar.charCodeAt(0) - 97;
        const keyShift = keyChar.charCodeAt(0) - 97;
        
        // Apply shift and wrap around alphabet
        const shiftedCode = (plainCode + keyShift) % 26;
        const cipherChar = String.fromCharCode(shiftedCode + 97);
        
        ciphertext += cipherChar;
      } else {
        // Non-lowercase letters are passed through unchanged
        ciphertext += plainChar;
      }
    }
    
    return ciphertext;
  }

  decode(ciphertext) {
    let plaintext = '';
    
    for (let i = 0; i < ciphertext.length; i++) {
      const cipherChar = ciphertext[i];
      const keyChar = this._key[i % this._key.length];
      
      if (/[a-z]/.test(cipherChar)) {
        // Calculate reverse shift
        const cipherCode = cipherChar.charCodeAt(0) - 97;
        const keyShift = keyChar.charCodeAt(0) - 97;
        
        // Apply reverse shift with wrap-around
        const plainCode = (cipherCode - keyShift + 26) % 26;
        const plainChar = String.fromCharCode(plainCode + 97);
        
        plaintext += plainChar;
      } else {
        // Non-lowercase letters are passed through unchanged
        plaintext += cipherChar;
      }
    }
    
    return plaintext;
  }

  get key() {
    return this._key;
  }
}