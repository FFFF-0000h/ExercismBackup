Function Invoke-RotationalCipher() {
    <#
    .SYNOPSIS
    Rotate a string by a given number of places.

    .DESCRIPTION
    Create an implementation of the rotational cipher, also sometimes called the Caesar cipher.
    
    .PARAMETER Text
    The text to rotate    

    .PARAMETER Shift
    The number of places to shift the text

    .EXAMPLE
    Invoke-RotationalCipher -Text "A" -Shift 1
    #>
    [CmdletBinding()]
    Param(
        [string]$Text, 
        [int]$Shift
    )
    
    # Normalize shift to 0..25 for both positive and negative shifts
    $shiftVal = $Shift % 26
    if ($shiftVal -lt 0) { $shiftVal += 26 }

    $result = -join ($Text.ToCharArray() | ForEach-Object {
        $char = $_
        if ($char -ge 'A' -and $char -le 'Z') {
            [char]((([int]$char - 65 + $shiftVal) % 26) + 65)
        }
        elseif ($char -ge 'a' -and $char -le 'z') {
            [char]((([int]$char - 97 + $shiftVal) % 26) + 97)
        }
        else {
            $char
        }
    })

    return $result
}