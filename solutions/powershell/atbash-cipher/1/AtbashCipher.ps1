Function Invoke-Encode() {
    [CmdletBinding()]
    Param(
        [string]$Phrase
    )

    # Lowercase and keep only letters and digits
    $cleaned = $Phrase.ToLowerInvariant() -replace '[^a-z0-9]', ''

    # Atbash substitution for letters
    $encodedChars = foreach ($ch in $cleaned.ToCharArray()) {
        if ($ch -match '[a-z]') {
            # Reverse alphabet: 'a' + 'z' - current
            [char]([int][char]'a' + ([int][char]'z' - [int]$ch))
        } else {
            $ch  # digits unchanged
        }
    }

    $encoded = -join $encodedChars

    # Insert space every 5 characters
    if ($encoded.Length -gt 0) {
        $grouped = ($encoded -split '(.....)' | Where-Object { $_ -ne '' }) -join ' '
        # The above regex splits into groups of 5, but may leave trailing incomplete group.
        # A better way: use a loop or regex replace.
        $grouped = $encoded -replace '(.{5})', '$1 '
        # Remove trailing space if any
        $grouped = $grouped.TrimEnd()
        return $grouped
    }
    return ''
}

Function Invoke-Decode() {
    [CmdletBinding()]
    Param(
        [string]$Phrase
    )

    # Remove spaces
    $cleaned = $Phrase -replace '\s', ''

    # Lowercase (should already be, but ensure)
    $cleaned = $cleaned.ToLowerInvariant()

    # Atbash substitution (same as encode)
    $decodedChars = foreach ($ch in $cleaned.ToCharArray()) {
        if ($ch -match '[a-z]') {
            [char]([int][char]'a' + ([int][char]'z' - [int]$ch))
        } else {
            $ch
        }
    }

    return -join $decodedChars
}