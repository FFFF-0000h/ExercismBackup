function Invoke-MicroBlog() {
    <#
    .SYNOPSIS
    Truncate a string to at most 5 Unicode characters.

    .DESCRIPTION
    Takes an input string (which may contain Unicode text, including emoji) and
    returns a string containing its first 5 Unicode characters. If the input
    contains 5 or fewer characters, it is returned unchanged.

    .PARAMETER Post
    A Unicode string to truncate.

    .EXAMPLE
    Invoke-MicroBlog -Post "Lightning"
    Returns: "Light"

    .EXAMPLE
    Invoke-MicroBlog -Post "😊🌍🚀✨💡🔥"
    Returns: "😊🌍🚀✨💡"
    #>
    [CmdletBinding()]
    Param(
        [string]$Post
    )

    $stringInfo = [System.Globalization.StringInfo]::new($Post)
    if ($stringInfo.LengthInTextElements -le 5) {
        return $Post
    }
    else {
        return $stringInfo.SubstringByTextElements(0, 5)
    }
}