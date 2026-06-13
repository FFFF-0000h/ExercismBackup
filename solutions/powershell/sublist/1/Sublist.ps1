# Define the Sublist enum
enum Sublist {
    EQUAL
    UNEQUAL
    SUBLIST
    SUPERLIST
}

Function Invoke-Sublist() {
    <#
    .SYNOPSIS
    Determine the relationship of two arrays.

    .DESCRIPTION
    Given two arrays, determine the relationship of the first array relating to the second array.
    There are four possible categories: EQUAL, UNEQUAL, SUBLIST and SUPERLIST.
    Note: This exercise use Enum values for return.
    
    .PARAMETER Data1
    The first array

    .PARAMETER Data2
    The second array

    .EXAMPLE
    Invoke-Sublist -Data1 @(1,2,3) -Data2 @(1,2,3)
    Return: [Sublist]::EQUAL

    Invoke-Sublist -Data1 @(1,2) -Data2 @(1,2,3)
    Return: [Sublist]::SUBLIST
    #>
    [CmdletBinding()]
    Param (
        [object[]]$Data1,
        [object[]]$Data2
    )
    
    # Helper function to check if one list is sublist of another
    function Test-IsSublist {
        param(
            [object[]]$Smaller,
            [object[]]$Larger
        )
        
        # Empty list is always a sublist of any list
        if ($Smaller.Length -eq 0) {
            return $true
        }
        
        # If smaller is larger than larger, it can't be a sublist
        if ($Smaller.Length -gt $Larger.Length) {
            return $false
        }
        
        # Check each possible starting position in the larger list
        for ($i = 0; $i -le ($Larger.Length - $Smaller.Length); $i++) {
            $match = $true
            for ($j = 0; $j -lt $Smaller.Length; $j++) {
                if ($Smaller[$j] -ne $Larger[$i + $j]) {
                    $match = $false
                    break
                }
            }
            if ($match) {
                return $true
            }
        }
        
        return $false
    }
    
    # Compare arrays element by element for equality
    if ($Data1.Length -eq $Data2.Length) {
        $equal = $true
        for ($i = 0; $i -lt $Data1.Length; $i++) {
            if ($Data1[$i] -ne $Data2[$i]) {
                $equal = $false
                break
            }
        }
        if ($equal) {
            return [Sublist]::EQUAL
        }
    }
    
    # Check if Data1 is a sublist of Data2
    if (Test-IsSublist -Smaller $Data1 -Larger $Data2) {
        return [Sublist]::SUBLIST
    }
    
    # Check if Data2 is a sublist of Data1 (meaning Data1 is a superlist)
    if (Test-IsSublist -Smaller $Data2 -Larger $Data1) {
        return [Sublist]::SUPERLIST
    }
    
    # If none of the above, they're unequal
    return [Sublist]::UNEQUAL
}