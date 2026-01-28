Function Get-BobResponse() {
    <#
    .SYNOPSIS
    Bob is a lackadaisical teenager. In conversation, his responses are very limited.
    
    .DESCRIPTION
    Bob is a lackadaisical teenager. In conversation, his responses are very limited.

    Bob answers 'Sure.' if you ask him a question.

    He answers 'Whoa, chill out!' if you yell at him.

    He answers 'Calm down, I know what I'm doing!' if you yell a question at him.

    He says 'Fine. Be that way!' if you address him without actually saying
    anything.

    He answers 'Whatever.' to anything else.
    
    .PARAMETER HeyBob
    The sentence you say to Bob.
    
    .EXAMPLE
    Get-BobResponse -HeyBob "Hi Bob"
    #>
    [CmdletBinding()]
    Param(
        [string]$HeyBob
    )

    # Check if it's silence (empty or only whitespace)
    if ([string]::IsNullOrWhiteSpace($HeyBob)) {
        return "Fine. Be that way!"
    }
    
    # Check if it's a question (ends with ?, ignoring trailing whitespace)
    $isQuestion = $HeyBob.TrimEnd() -match '\?$'
    
    # Check if it's yelling
    # Yelling means: contains at least one letter AND all letters are uppercase
    $hasLetters = $HeyBob -cmatch '[A-Za-z]'
    
    # For yelling, we need to check if ALL letters are uppercase
    # We compare the original string with the uppercase version for letters only
    if ($hasLetters) {
        # Remove non-letters and compare
        $lettersOnly = $HeyBob -creplace '[^A-Za-z]', ''
        $isYelling = $lettersOnly -ceq $lettersOnly.ToUpper()
    } else {
        $isYelling = $false
    }
    
    # Apply Bob's rules in the correct priority order
    if ($isYelling -and $isQuestion) {
        return "Calm down, I know what I'm doing!"
    }
    elseif ($isYelling) {
        return "Whoa, chill out!"
    }
    elseif ($isQuestion) {
        return "Sure."
    }
    else {
        return "Whatever."
    }
}