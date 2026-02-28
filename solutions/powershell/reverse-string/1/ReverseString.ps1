function Get-ReverseString {
    [CmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline = $true)]
        [string]$Forward
    )
    process {
        if ([string]::IsNullOrEmpty($Forward)) {
            return ""
        }
        $charArray = $Forward.ToCharArray()
        [Array]::Reverse($charArray)
        -join $charArray
    }
}