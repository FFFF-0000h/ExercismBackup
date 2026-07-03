"""Module providing a function to translate RNA sequences into proteins."""


def proteins(strand):
    """
    Translate an RNA strand into a sequence of protein names.
    
    The function reads the RNA strand in groups of three nucleotides (codons)
    and translates each codon to its corresponding amino acid. Translation
    stops when a STOP codon is encountered.
    
    Args:
        strand (str): A string representing an RNA sequence.
        
    Returns:
        list: A list of protein names in the order they are translated.
        
    Examples:
        >>> proteins("AUGUUUUCU")
        ['Methionine', 'Phenylalanine', 'Serine']
        
        >>> proteins("AUGUUUUCUUAAAUG")
        ['Methionine', 'Phenylalanine', 'Serine']
    """
    # Define the codon to amino acid mapping
    codon_to_protein = {
        "AUG": "Methionine",
        "UUU": "Phenylalanine",
        "UUC": "Phenylalanine",
        "UUA": "Leucine",
        "UUG": "Leucine",
        "UCU": "Serine",
        "UCC": "Serine",
        "UCA": "Serine",
        "UCG": "Serine",
        "UAU": "Tyrosine",
        "UAC": "Tyrosine",
        "UGU": "Cysteine",
        "UGC": "Cysteine",
        "UGG": "Tryptophan",
        "UAA": "STOP",
        "UAG": "STOP",
        "UGA": "STOP",
    }
    
    translated_proteins = []
    
    # Process the strand in chunks of 3 nucleotides
    for index in range(0, len(strand), 3):
        codon = strand[index:index + 3]
        
        # Only process complete codons
        if len(codon) < 3:
            break
            
        # Get the amino acid for this codon
        amino_acid = codon_to_protein.get(codon)
        
        # If codon is invalid, we could raise an error or skip
        # For this exercise, we'll skip invalid codons
        if amino_acid is None:
            continue
            
        # Stop translation at STOP codons
        if amino_acid == "STOP":
            break
            
        translated_proteins.append(amino_acid)
    
    return translated_proteins