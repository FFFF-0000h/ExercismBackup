Function Invoke-SecretHandshake() {

    [CmdletBinding()]
    Param(
        [int]$Number
    )

    $binary = [Convert]::ToString($Number, 2)
    $length = $binary.Length

    $actions = @()
    for ($i = 0; $i -lt $length; $i++) {
        $currentbit = $binary[$length - 1 - $i]
        if ($currentbit -eq '1') {
            switch ($i) {
                0 { $actions += "wink" }
                1 { $actions += "double blink" }
                2 { $actions += "close your eyes" }
                3 { $actions += "jump" }
                4 { [Array]::Reverse($actions) }
            }
        }
    }
   
    return $actions
}
