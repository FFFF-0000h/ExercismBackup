Function Invoke-Panagram() {
    <#
    .SYNOPSIS
    Determine if a sentence is a pangram.
    
    .DESCRIPTION
    A pangram is a sentence using every letter of the alphabet at least once.
    
    .PARAMETER Sentence
    The sentence to check
    
    .EXAMPLE
    Invoke-Panagram -Sentence "The quick brown fox jumps over the lazy dog"
    
    Returns: $true
    #>
    [CmdletBinding()]
    Param(
        [string]$Sentence
    )

    # Normalize to lowercase and keep only letters a-z
    $clean = $Sentence.ToLower() -replace '[^a-z]', ''

    # Get distinct letters
    $unique = $clean.ToCharArray() | Select-Object -Unique

    # Check if all 26 letters are present
    return ($unique.Count -eq 26)
}