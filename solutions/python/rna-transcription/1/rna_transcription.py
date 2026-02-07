def to_rna(dna_strand: str) -> str:
    """
    Transcribe a DNA strand to its RNA complement.
    
    Args:
        dna_strand: A string containing DNA nucleotides (A, C, G, T)
    
    Returns:
        A string containing RNA nucleotides (A, C, G, U)
    
    Raises:
        ValueError: If the input contains invalid DNA nucleotides
    """
    # Mapping dictionary for DNA to RNA transcription
    transcription_map = {
        'G': 'C',
        'C': 'G', 
        'T': 'A',
        'A': 'U'
    }
    
    # Validate input and transcribe
    result = []
    for nucleotide in dna_strand:
        if nucleotide not in transcription_map:
            raise ValueError(f"Invalid DNA nucleotide: {nucleotide}")
        result.append(transcription_map[nucleotide])
    
    return ''.join(result)