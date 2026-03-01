function Invoke-RnaTranscription {
    [CmdletBinding()]
    Param(
        [string]$Strand
    )

    # Define the complement mapping
    $complement = @{
        'G' = 'C'
        'C' = 'G'
        'T' = 'A'
        'A' = 'U'
    }

    # Process each character
    $result = foreach ($char in $Strand.ToCharArray()) {
        $complement[[string]$char]
    }

    # Join the characters into a string
    return -join $result
}