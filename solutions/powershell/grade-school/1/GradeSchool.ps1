class Student {
    [string] $Name
    [int] $Grade

    Student([string]$name, [int]$grade) {
        $this.Name = $name
        $this.Grade = $grade
    }
}

class Roster {
    # Sorted dictionary for grade order (1, 2, 3, …)
    hidden [System.Collections.Generic.SortedDictionary[int, System.Collections.Generic.List[Student]]] $gradeList = 
        [System.Collections.Generic.SortedDictionary[int, System.Collections.Generic.List[Student]]]::new()

    # Case‑insensitive set of all names ever enrolled
    hidden [System.Collections.Generic.HashSet[string]] $allNames = 
        [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)

    Roster() {}

    [bool] AddStudent([int]$grade, [string]$name) {
        # Duplicate check (any grade)
        if (-not $this.allNames.Add($name)) {
            return $false
        }

        if (-not $this.gradeList.ContainsKey($grade)) {
            $this.gradeList[$grade] = [System.Collections.Generic.List[Student]]::new()
        }

        $student = [Student]::new($name, $grade)
        $this.gradeList[$grade].Add($student)

        # Keep the grade list sorted alphabetically (case‑insensitive)
        $comparer = [System.StringComparer]::OrdinalIgnoreCase
        $this.gradeList[$grade].Sort({ param($a, $b) $comparer.Compare($a.Name, $b.Name) })

        return $true
    }

    [Student[]] GetRoster() {
        $result = [System.Collections.Generic.List[Student]]::new()
        foreach ($g in $this.gradeList.Keys) {
            $result.AddRange($this.gradeList[$g])
        }
        return $result.ToArray()
    }

    [Student[]] GetRoster([int]$grade) {
        if ($this.gradeList.ContainsKey($grade)) {
            return $this.gradeList[$grade].ToArray()
        }
        return [Student[]]::new(0)
    }
}