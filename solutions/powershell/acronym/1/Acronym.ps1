Function Get-Acronym() {
    <#
    .SYNOPSIS
    Get the acronym of a phrase.

    .DESCRIPTION
    Given a phrase, return the string acronym of that phrase.
    "As Soon As Possible" => "ASAP"
    
    .PARAMETER Phrase
    The phrase to get the acronym from.
    
    .EXAMPLE
    Get-Acronym -Phrase "As Soon As Possible"
    #>
    [CmdletBinding()]
    Param (
        [string]$Phrase
    )

    # Replace hyphens and underscores with spaces
    $cleaned = $Phrase -replace '[-_]', ' '

    # Split on whitespace and get first letter of each word
    $words = $cleaned -split '\s+' | Where-Object { $_ -ne '' }
    $acronym = ($words | ForEach-Object { $_[0] }) -join ''

    return $acronym.ToUpper()
}