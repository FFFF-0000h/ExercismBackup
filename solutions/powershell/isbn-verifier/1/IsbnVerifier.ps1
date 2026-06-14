Function Test-Isbn() {
    <#
    .SYNOPSIS
    Determine if an ISBN is valid or not.
    
    .DESCRIPTION
    Given a string the function should check if the provided string is a valid ISBN-10.
    
    .PARAMETER Isbn
    The ISBN to check
    
    .EXAMPLE
    Test-Isbn -Isbn "3-598-21508-8"
    
    Returns: $true
    #>
    [CmdletBinding()]
    Param(
        [string]$Isbn
    )

    # Remove hyphens from the ISBN
    $cleanedIsbn = $Isbn -replace '-', ''
    
    # Check if the cleaned ISBN has exactly 10 characters
    if ($cleanedIsbn.Length -ne 10) {
        return $false
    }
    
    # Initialize sum
    $sum = 0
    
    # Process each character
    for ($i = 0; $i -lt 10; $i++) {
        $char = $cleanedIsbn[$i]
        
        # The last character (check digit) can be 'X' or 'x'
        if ($i -eq 9) {
            if ($char -eq 'X' -or $char -eq 'x') {
                $value = 10
            } elseif ([char]::IsDigit($char)) {
                $value = [int]::Parse($char)
            } else {
                return $false
            }
        } else {
            # First nine characters must be digits
            if (-not [char]::IsDigit($char)) {
                return $false
            }
            $value = [int]::Parse($char)
        }
        
        # Multiply by weight (10 - i) and add to sum
        $sum += $value * (10 - $i)
    }
    
    # Check if sum is divisible by 11
    return ($sum % 11) -eq 0
}