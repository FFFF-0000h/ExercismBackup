Function Invoke-PrimeFactors() {
    <#
    .SYNOPSIS
    Calculate the prime factors of a given natural number.

    .DESCRIPTION
    Uses trial division to find all prime factors of the input number.

    .PARAMETER Number
    The number to factorize.

    .EXAMPLE
    Invoke-PrimeFactors -Number 60
    # Returns: @(2, 2, 3, 5)
    #>
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )
    
    $factors = @()                      # list to hold prime factors
    $remaining = $Number                # working copy

    $divisor = 2
    # check divisibility by all integers up to sqrt(remaining)
    while ($divisor * $divisor -le $remaining) {
        while ($remaining % $divisor -eq 0) {
            $factors += $divisor
            $remaining = $remaining / $divisor
        }
        $divisor++
    }

    # If remaining is still > 1, it's a prime factor
    if ($remaining -gt 1) {
        $factors += $remaining
    }

    return $factors
}