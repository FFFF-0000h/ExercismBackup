function Invoke-Anagram {
    [CmdletBinding()]
    Param(
        [string]$Subject,
        [string[]]$Candidates
    )

    # Normalize the subject: lowercase and sorted characters
    $subjectLower = $Subject.ToLower()
    $subjectSorted = [string]::new(($subjectLower.ToCharArray() | Sort-Object))

    $result = @()

    foreach ($candidate in $Candidates) {
        $candidateLower = $candidate.ToLower()

        # Skip if it's the same word (case-insensitive)
        if ($candidateLower -eq $subjectLower) {
            continue
        }

        # Check if sorted characters match
        $candidateSorted = [string]::new(($candidateLower.ToCharArray() | Sort-Object))
        if ($candidateSorted -eq $subjectSorted) {
            $result += $candidate
        }
    }

    return $result
}