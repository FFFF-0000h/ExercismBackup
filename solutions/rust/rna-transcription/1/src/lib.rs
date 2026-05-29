#[derive(Debug, PartialEq, Eq)]
pub struct Dna {
    sequence: String,
}

#[derive(Debug, PartialEq, Eq)]
pub struct Rna {
    sequence: String,
}

impl Dna {
    /// Construct a new Dna from a string.
    /// Returns `Err(index)` of the first invalid character (not A, C, G, T).
    pub fn new(dna: &str) -> Result<Dna, usize> {
        for (i, c) in dna.chars().enumerate() {
            if !matches!(c, 'A' | 'C' | 'G' | 'T') {
                return Err(i);
            }
        }
        Ok(Dna {
            sequence: dna.to_string(),
        })
    }

    /// Convert this DNA into the corresponding RNA sequence.
    pub fn into_rna(self) -> Rna {
        let rna: String = self
            .sequence
            .chars()
            .map(|c| match c {
                'G' => 'C',
                'C' => 'G',
                'T' => 'A',
                'A' => 'U',
                _ => unreachable!(), // valid DNA only contains A, C, G, T
            })
            .collect();
        Rna { sequence: rna }
    }
}

impl Rna {
    /// Construct a new Rna from a string.
    /// Returns `Err(index)` of the first invalid character (not A, C, G, U).
    pub fn new(rna: &str) -> Result<Rna, usize> {
        for (i, c) in rna.chars().enumerate() {
            if !matches!(c, 'A' | 'C' | 'G' | 'U') {
                return Err(i);
            }
        }
        Ok(Rna {
            sequence: rna.to_string(),
        })
    }
}