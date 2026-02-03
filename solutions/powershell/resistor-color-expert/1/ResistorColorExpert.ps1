Function Get-ResistorLabel() {
    <#
    .SYNOPSIS
    Implement a function to get the label of a resistor from its color-coded bands.

    .DESCRIPTION
    Given an array of 1, 4 or 5 colors from a resistor, decode their resistance values and return a string represent the resistor's label.

    .PARAMETER Colors
    The array represent the colors from left to right.

    .EXAMPLE
    Get-ResistorLabel -Colors @("red", "black", "green", "red")
    Return: "2 megaohms ±2%"

    Get-ResistorLabel -Colors @("blue", "blue", "blue", "blue", "blue")
    Return: "666 megaohms ±0.25%"
     #>
    [CmdletBinding()]
    Param(
        [string[]]$Colors
    )
    
    # Color to digit mapping
    $colorMap = @{
        "black" = 0
        "brown" = 1
        "red" = 2
        "orange" = 3
        "yellow" = 4
        "green" = 5
        "blue" = 6
        "violet" = 7
        "grey" = 8
        "white" = 9
    }
    
    # Tolerance mapping
    $toleranceMap = @{
        "grey" = "±0.05%"
        "violet" = "±0.1%"
        "blue" = "±0.25%"
        "green" = "±0.5%"
        "brown" = "±1%"
        "red" = "±2%"
        "gold" = "±5%"
        "silver" = "±10%"
    }
    
    # Check number of bands
    $bandCount = $Colors.Count
    
    # Special case: single black band resistor
    if ($bandCount -eq 1 -and $Colors[0] -eq "black") {
        return "0 ohms"
    }
    
    # Validate number of bands
    if ($bandCount -ne 4 -and $bandCount -ne 5) {
        throw "Invalid number of bands. Must be 1 (black only), 4, or 5 colors."
    }
    
    # Extract values based on band count
    if ($bandCount -eq 4) {
        # 4-band: value1, value2, multiplier, tolerance
        $value1 = $colorMap[$Colors[0].ToLower()]
        $value2 = $colorMap[$Colors[1].ToLower()]
        $multiplier = $colorMap[$Colors[2].ToLower()]
        $toleranceColor = $Colors[3].ToLower()
        $mainValue = ($value1 * 10 + $value2) * [Math]::Pow(10, $multiplier)
    }
    else {
        # 5-band: value1, value2, value3, multiplier, tolerance
        $value1 = $colorMap[$Colors[0].ToLower()]
        $value2 = $colorMap[$Colors[1].ToLower()]
        $value3 = $colorMap[$Colors[2].ToLower()]
        $multiplier = $colorMap[$Colors[3].ToLower()]
        $toleranceColor = $Colors[4].ToLower()
        $mainValue = ($value1 * 100 + $value2 * 10 + $value3) * [Math]::Pow(10, $multiplier)
    }
    
    # Get tolerance
    if (-not $toleranceMap.ContainsKey($toleranceColor)) {
        throw "Invalid tolerance color: $toleranceColor"
    }
    $tolerance = $toleranceMap[$toleranceColor]
    
    # Format the value with appropriate units
    $formattedValue = ""
    
    if ($mainValue -ge 1000000) {
        # Megaohms
        $value = $mainValue / 1000000
        $formattedValue = "$value megaohms"
    }
    elseif ($mainValue -ge 1000) {
        # Kiloohms
        $value = $mainValue / 1000
        $formattedValue = "$value kiloohms"
    }
    else {
        # Ohms
        $formattedValue = "$mainValue ohms"
    }
    
    # Remove trailing zeros after decimal point and decimal point if not needed
    if ($formattedValue -match '(\d+\.\d*?)0+ (\w+)') {
        $numberPart = $matches[1]
        $unitPart = $matches[2]
        
        # Remove trailing decimal point if all zeros after it
        if ($numberPart.EndsWith('.')) {
            $numberPart = $numberPart.TrimEnd('.')
        }
        
        $formattedValue = "$numberPart $unitPart"
    }
    
    # Combine value and tolerance
    return "$formattedValue $tolerance"
}