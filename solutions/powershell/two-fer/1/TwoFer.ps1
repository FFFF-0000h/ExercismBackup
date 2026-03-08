Function Get-TwoFer {
    [CmdletBinding()]
    Param(
        [string]$Name
    )

    if ($Name) {
        "One for $Name, one for me"
    } else {
        "One for you, one for me"
    }
}