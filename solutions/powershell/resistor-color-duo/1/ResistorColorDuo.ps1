Function Get-ColorCodeValue() {
    <#
    .SYNOPSIS
    Translate a list of colors to their corresponding color code values.

    .DESCRIPTION
    Given 2 colors, take the first one and times it by 10 and add the second color to it.

    .PARAMETER Colors
    The colors to translate to their corresponding color codes.

    .EXAMPLE
    Get-ColorCodeValue -Colors @("black", "brown")
    #>
    [CmdletBinding()]
    Param(
        [string[]]$Colors
    )
    
    # Define color to value mapping
    $colorMap = @{
        'black'  = 0
        'brown'  = 1
        'red'    = 2
        'orange' = 3
        'yellow' = 4
        'green'  = 5
        'blue'   = 6
        'violet' = 7
        'grey'   = 8
        'white'  = 9
    }
    
    # Validate input - need at least 2 colors
    if ($Colors.Count -lt 2) {
        throw "At least 2 colors are required"
    }
    
    # Normalize colors to lowercase
    $color1 = $Colors[0].ToLower()
    $color2 = $Colors[1].ToLower()
    
    # Validate colors exist in map
    if (-not $colorMap.ContainsKey($color1)) {
        throw "Invalid color: '$($Colors[0])'"
    }
    if (-not $colorMap.ContainsKey($color2)) {
        throw "Invalid color: '$($Colors[1])'"
    }
    
    # Calculate value: first color * 10 + second color
    $value = $colorMap[$color1] * 10 + $colorMap[$color2]
    
    return $value
}