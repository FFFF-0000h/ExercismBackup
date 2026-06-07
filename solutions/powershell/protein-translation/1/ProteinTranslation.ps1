Function Invoke-ProteinTranslation() {
    [CmdletBinding()]
    Param(
        [string]$Strand
    )

    $codonMap = @{
        'AUG' = 'Methionine'
        'UUU' = 'Phenylalanine'; 'UUC' = 'Phenylalanine'
        'UUA' = 'Leucine';      'UUG' = 'Leucine'
        'UCU' = 'Serine';       'UCC' = 'Serine'; 'UCA' = 'Serine'; 'UCG' = 'Serine'
        'UAU' = 'Tyrosine';     'UAC' = 'Tyrosine'
        'UGU' = 'Cysteine';     'UGC' = 'Cysteine'
        'UGG' = 'Tryptophan'
        'UAA' = 'STOP';         'UAG' = 'STOP'; 'UGA' = 'STOP'
    }

    $proteins = @()
    for ($i = 0; $i -lt $Strand.Length; $i += 3) {
        # Throw if incomplete codon remains
        if ($i + 3 -gt $Strand.Length) {
            throw "error: Invalid codon"
        }

        $codon = $Strand.Substring($i, 3)
        if (-not $codonMap.ContainsKey($codon)) {
            throw "error: Invalid codon"
        }
        $protein = $codonMap[$codon]
        if ($protein -eq 'STOP') {
            break
        }
        $proteins += $protein
    }
    return $proteins
}