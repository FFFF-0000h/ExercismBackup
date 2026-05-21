function Get-SpaceAge() {
    [CmdletBinding()]
    Param(
        [long]$Seconds,
        [string]$Planet = 'Earth'
    )

    $orbitalPeriods = @{
        Mercury = 0.2408467
        Venus   = 0.61519726
        Earth   = 1.0
        Mars    = 1.8808158
        Jupiter = 11.862615
        Saturn  = 29.447498
        Uranus  = 84.016846
        Neptune = 164.79132
    }

    if ($Planet -notin $orbitalPeriods.Keys) {
        throw "Invalid planet"
    }

    $earthYearInSeconds = 31557600.0
    $ageOnEarth = $Seconds / $earthYearInSeconds
    $ageOnPlanet = $ageOnEarth / $orbitalPeriods[$Planet]

    [math]::Round($ageOnPlanet, 2)
}