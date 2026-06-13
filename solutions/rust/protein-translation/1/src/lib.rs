pub fn translate(rna: &str) -> Option<Vec<&str>> {
    let mut proteins = Vec::new();
    let bytes = rna.as_bytes();
    let mut i = 0;
    
    while i + 3 <= bytes.len() {
        let codon = std::str::from_utf8(&bytes[i..i + 3]).ok()?;
        
        match codon {
            "AUG" => proteins.push("Methionine"),
            "UUU" | "UUC" => proteins.push("Phenylalanine"),
            "UUA" | "UUG" => proteins.push("Leucine"),
            "UCU" | "UCC" | "UCA" | "UCG" => proteins.push("Serine"),
            "UAU" | "UAC" => proteins.push("Tyrosine"),
            "UGU" | "UGC" => proteins.push("Cysteine"),
            "UGG" => proteins.push("Tryptophan"),
            "UAA" | "UAG" | "UGA" => return Some(proteins),
            _ => return None,
        }
        
        i += 3;
    }
    
    // Only valid if we consumed all characters
    if i == bytes.len() {
        Some(proteins)
    } else {
        None
    }
}