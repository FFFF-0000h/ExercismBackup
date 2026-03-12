Function Invoke-BinarySearch() {
    [CmdletBinding()]
    Param(
        [Int64[]]$Array,
        [Int64]$Value
    )

    $low = 0
    $high = $Array.Length - 1

    while ($low -le $high) {
        $mid = [int](($low + $high) / 2)
        $current = $Array[$mid]

        if ($current -eq $Value) {
            return $mid
        }
        elseif ($current -gt $Value) {
            $high = $mid - 1
        }
        else {
            $low = $mid + 1
        }
    }

    Throw "*error: value not in array*"
}