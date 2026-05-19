Enum Triangle {
    SCALENE
    ISOSCELES
    EQUILATERAL
}

Function Get-Triangle() {
    [CmdletBinding()]
    Param (
        [double[]]$Sides
    )

    if ($Sides.Count -ne 3) {
        Throw "Invalid triangle"
    }

    $a, $b, $c = $Sides | Sort-Object

    if ($a -le 0) {
        Throw "All side lengths must be positive."
    }

    # Triangle inequality (allow degenerate)
    if ($a + $b -lt $c) {
        Throw "Side lengths violate triangle inequality."
    }

    if ($a -eq $c) {
        return [Triangle]::EQUILATERAL
    }
    elseif ($a -eq $b -or $b -eq $c) {
        return [Triangle]::ISOSCELES
    }
    else {
        return [Triangle]::SCALENE
    }
}