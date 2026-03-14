Function Invoke-ArmstrongNumbers() {
    <#
    .SYNOPSIS
    Determine if a number is an Armstrong number.

    .DESCRIPTION
    An Armstrong number is a number that is the sum of its own digits each raised to the power of the number of digits.

    .PARAMETER Number
    The number to check.

    .EXAMPLE
    Invoke-ArmstrongNumbers -Number 153
    Returns $true

    .EXAMPLE
    Invoke-ArmstrongNumbers -Number 154
    Returns $false
    #>
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    # Negative numbers are not considered Armstrong numbers
    if ($Number -lt 0) {
        return $false
    }

    # Convert to string to get digits (excluding any sign, already handled)
    $numberString = $Number.ToString()
    $numDigits = $numberString.Length

    $sum = 0
    foreach ($char in $numberString.ToCharArray()) {
        $digit = [int]::Parse($char)
        $sum += [Math]::Pow($digit, $numDigits)
    }

    return $sum -eq $Number
}