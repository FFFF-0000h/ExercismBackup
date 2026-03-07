use std::collections::HashMap;

/// Count the occurrences of a single nucleotide in a DNA string.
/// Returns the count, or an error if either the nucleotide is invalid
/// or the DNA string contains an invalid character.
pub fn count(nucleotide: char, dna: &str) -> Result<usize, char> {
    // Validate the nucleotide itself
    if !matches!(nucleotide, 'A' | 'C' | 'G' | 'T') {
        return Err(nucleotide);
    }

    let mut cnt = 0;
    for c in dna.chars() {
        match c {
            'A' | 'C' | 'G' | 'T' => {
                if c == nucleotide {
                    cnt += 1;
                }
            }
            _ => return Err(c),
        }
    }
    Ok(cnt)
}

/// Count the occurrences of all nucleotides in a DNA string.
/// Returns a map from nucleotide to count, or an error if the string
/// contains an invalid character.
pub fn nucleotide_counts(dna: &str) -> Result<HashMap<char, usize>, char> {
    let mut map = HashMap::new();
    // Initialize with zeros for all four nucleotides
    map.insert('A', 0);
    map.insert('C', 0);
    map.insert('G', 0);
    map.insert('T', 0);

    for c in dna.chars() {
        match c {
            'A' | 'C' | 'G' | 'T' => {
                *map.get_mut(&c).unwrap() += 1;
            }
            _ => return Err(c),
        }
    }
    Ok(map)
}