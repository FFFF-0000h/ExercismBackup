function Get-Rhyme() {
    [CmdletBinding()]
    Param(
        [int]$Start,
        [int]$End
    )
    
    # Subjects (nouns) for each verse, indexed by verse number (1..12)
    $subjects = @(
        "house that Jack built.",   # verse 1
        "malt",                     # verse 2
        "rat",                      # verse 3
        "cat",                      # verse 4
        "dog",                      # verse 5
        "cow with the crumpled horn", # verse 6
        "maiden all forlorn",       # verse 7
        "man all tattered and torn", # verse 8
        "priest all shaven and shorn", # verse 9
        "rooster that crowed in the morn", # verse 10
        "farmer sowing his corn",   # verse 11
        "horse and the hound and the horn" # verse 12
    )
    
    # Verbs connecting a subject to the previous one (index 2..12)
    $verbs = @(
        $null,                      # index 0 unused (verse 1)
        "lay in",                   # verse 2 -> 1
        "ate",                      # verse 3 -> 2
        "killed",                   # verse 4 -> 3
        "worried",                  # verse 5 -> 4
        "tossed",                   # verse 6 -> 5
        "milked",                   # verse 7 -> 6
        "kissed",                   # verse 8 -> 7
        "married",                  # verse 9 -> 8
        "woke",                     # verse 10 -> 9
        "kept",                     # verse 11 -> 10
        "belonged to"               # verse 12 -> 11
    )
    
    $verses = @()
    for ($n = $Start; $n -le $End; $n++) {
        if ($n -eq 1) {
            $verse = "This is the " + $subjects[0]
        }
        else {
            $parts = @("This is the " + $subjects[$n - 1])
            # Middle clauses from current verse down to verse 3
            for ($i = $n; $i -ge 3; $i--) {
                $parts += "that " + $verbs[$i - 1] + " the " + $subjects[$i - 2]
            }
            # Final clause for all verses >= 2
            $parts += "that lay in the house that Jack built."
            $verse = $parts -join ' '
        }
        $verses += $verse
    }
    
    return $verses -join "`n"
}