$ColorTable = @{
  "black"  = 0;
  "brown"  = 1;
  "red"    = 2;
  "orange" = 3;
  "yellow" = 4;
  "green"  = 5;
  "blue"   = 6;
  "violet" = 7;
  "grey"   = 8;
  "white"  = 9
}

Function Get-ResistorLabel() {
  [CmdletBinding()]
  Param(
    [string[]]$Colors
  )
  $result = ""
  for ($i = 0; $i -lt 2; $i++) {
    $result += $ColorTable[$Colors[$i]]
  }
  $result += "0" * $ColorTable[$Colors[$i]]

  if ($result.Length -ge 10) {
    $result = [string]([Int64]$result / 1000000000) 
    return "$result gigaohms"
  }
  elseif ($result.Length -ge 7) {
    $result = [string]([Int64]$result / 1000000) 
    return "$result megaohms"
  }
  elseif ($result.Length -ge 4) {
    $result = [string]([Int64]$result / 1000)
    return "$result kiloohms"
  }
  else {
    $result = [string]([Int64]$result)
    return "$result ohms"
  }
}