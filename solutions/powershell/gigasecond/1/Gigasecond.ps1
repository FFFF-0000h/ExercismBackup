Function Add-Gigasecond() {
    <#
    .SYNOPSIS
    Add a gigasecond to a date.

    .DESCRIPTION
    Take a moment and add a gigasecond to it.

    .PARAMETER Time
    A datetime object, to which a gigasecond will be added.

    .EXAMPLE
    Add-Gigasecond -Time (Get-Date "2015-01-24T22:00:00")
    #>
    [CmdletBinding()]
    Param(
        [DateTime]$Time
    )

    # 1 gigasecond = 1,000,000,000 seconds
    $gigasecond = [TimeSpan]::FromSeconds(1000000000)
    
    # Add the gigasecond to the input time
    return $Time.Add($gigasecond)
}