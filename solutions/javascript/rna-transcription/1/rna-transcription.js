//
// This is only a SKELETON file for the 'RNA Transcription' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const toRna = (dna) => {
  // Handle empty string
  if (!dna) {
    return '';
  }

  // Create a mapping object for DNA to RNA conversion
  const transcription = {
    'G': 'C',
    'C': 'G',
    'T': 'A',
    'A': 'U'
  };

  // Convert each nucleotide and join back into a string
  let rna = '';
  
  for (let i = 0; i < dna.length; i++) {
    const nucleotide = dna[i].toUpperCase();
    
    // Check if nucleotide is valid
    if (!transcription.hasOwnProperty(nucleotide)) {
      throw new Error('Invalid input DNA.');
    }
    
    rna += transcription[nucleotide];
  }
  
  return rna;
};