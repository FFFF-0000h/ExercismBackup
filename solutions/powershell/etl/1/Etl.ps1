function Invoke-Etl() {
    [CmdletBinding()]
    Param(
        [hashtable]$Legacy
    )

    $result = @{}

    foreach ($score in $Legacy.Keys) {
        foreach ($letter in $Legacy[$score]) {
            $result[$letter.ToLower()] = $score
        }
    }

    return $result
}