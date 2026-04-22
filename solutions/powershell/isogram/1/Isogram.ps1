Function Invoke-Isogram() {
    [CmdletBinding()]
    Param(
        [string]$Phrase
    )

    # Extract only letters (a-z), ignoring case, spaces, hyphens, etc.
    $letters = $Phrase -replace '[^a-zA-Z]', '' -split '' | Where-Object { $_ -ne '' }
    
    # If no letters, it's trivially an isogram.
    if ($letters.Count -eq 0) {
        return $true
    }
    
    # Convert to lowercase for case-insensitivity.
    $lowerLetters = $letters | ForEach-Object { $_.ToLowerInvariant() }
    
    # Check if all letters are unique.
    $uniqueCount = ($lowerLetters | Select-Object -Unique).Count
    $totalCount = $lowerLetters.Count
    
    return $uniqueCount -eq $totalCount
}