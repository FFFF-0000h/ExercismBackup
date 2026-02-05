Function Get-SumOfMultiples {
    [CmdletBinding()]
    Param(
        [int[]]$Multiples,
        [int]$Limit
    )

    # Handle edge cases
    if ($Multiples.Count -eq 0 -or $Limit -le 0) {
        return 0
    }

    # Remove invalid multiples (≤ 0)
    $validMultiples = $Multiples | Where-Object { $_ -gt 0 }
    
    if ($validMultiples.Count -eq 0) {
        return 0
    }

    # Collect all multiples
    $allMultiples = @()
    
    foreach ($multiple in $validMultiples) {
        $current = $multiple
        while ($current -lt $Limit) {
            $allMultiples += $current
            $current += $multiple
        }
    }

    # Remove duplicates by converting to hashset or sorting
    if ($allMultiples.Count -eq 0) {
        return 0
    }

    # Sort and remove duplicates
    $uniqueMultiples = $allMultiples | Sort-Object -Unique
    
    # Sum the unique multiples
    $sum = 0
    $uniqueMultiples | ForEach-Object { $sum += $_ }
    
    return $sum
}