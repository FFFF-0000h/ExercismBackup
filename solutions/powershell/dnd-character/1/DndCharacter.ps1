<#
.SYNOPSIS
    Generate a DnD character with all the classic abilities by rolling 4 dice.

.DESCRIPTION
    A DnD character starts has, among other things, six abilities:
    strength, dexterity, constitution, intelligence, wisdom and charisma.
    These abilities score are determined randomly by throwing dice.
    Throw 4 six-sided dice and return the the sum of the largest three.
    Your character's inittial hitpoints are: 10 + your character's constitution modifier.
    You find your character's constitution modifier by but this formula : (Constitution - 10) / 2 and then round down.
    
.EXAMPLE
    $character = [Character]::new()
    $character | Format-Table
    
    Strength Dexterity Constitution Intelligence Wisdom Charisma HitPoints
    -------- --------- ------------ ------------ ------ -------- ---------
           7        10           15            9     13       13        12

#>
Class Character {
    [int]$Strength
    [int]$Dexterity
    [int]$Constitution
    [int]$Intelligence
    [int]$Wisdom
    [int]$Charisma
    [int]$HitPoints

    Character() {
        $this.Strength = $this.Ability()
        $this.Dexterity = $this.Ability()
        $this.Constitution = $this.Ability()
        $this.Intelligence = $this.Ability()
        $this.Wisdom = $this.Ability()
        $this.Charisma = $this.Ability()
        $this.HitPoints = 10 + [Character]::GetModifier($this.Constitution)
    }

    [int] Ability() {
        $rolls = @(
            (Get-Random -Minimum 1 -Maximum 7),
            (Get-Random -Minimum 1 -Maximum 7),
            (Get-Random -Minimum 1 -Maximum 7),
            (Get-Random -Minimum 1 -Maximum 7)
        )
        $sorted = $rolls | Sort-Object -Descending
        return $sorted[0] + $sorted[1] + $sorted[2]
    }

    static [int] GetModifier([int]$Score) {
        return [Math]::Floor(($Score - 10) / 2.0)
    }
}