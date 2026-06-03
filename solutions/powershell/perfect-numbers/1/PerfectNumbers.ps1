Function Invoke-PerfectNumbers() {
    <#
    .SYNOPSIS
    Determine if a number is perfect, abundant, or deficient based on Nicomachus' (60 - 120 CE) classification scheme for natural numbers.

    .DESCRIPTION
    Calculate the aliquot sum of a number: the sum of its positive divisors not including the number itself.
    Compare the sum to the original number.
    Determine the classification: perfect, abundant, or deficient.

    .PARAMETER Number
    The number to perform the classification on.

    .EXAMPLE
    Invoke-PerfectNumbers -Number 12
    #>
    [CmdletBinding()]
    Param(
        [Int64]$Number
    )

    if ($Number -le 0) {
        throw "error: Classification is only possible for positive integers."
    }

    $aliquotSum = 0

    # Find all proper divisors up to sqrt(Number)
    $limit = [Math]::Sqrt($Number)
    for ($i = 1; $i -le $limit; $i++) {
        if ($Number % $i -eq 0) {
            if ($i -ne $Number) {
                $aliquotSum += $i
            }
            $pair = $Number / $i
            if ($pair -ne $i -and $pair -ne $Number) {
                $aliquotSum += $pair
            }
        }
    }

    if ($aliquotSum -eq $Number) {
        return "perfect"
    } elseif ($aliquotSum -gt $Number) {
        return "abundant"
    } else {
        return "deficient"
    }
}