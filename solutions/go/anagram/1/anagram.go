package anagram

import (
	"sort"
	"strings"
)

func Detect(subject string, candidates []string) []string {
	subjectLower := strings.ToLower(subject)
	subjectSorted := sortString(subjectLower)

	var result []string
	for _, candidate := range candidates {
		candidateLower := strings.ToLower(candidate)

		// Not an anagram if it's the same word (case-insensitive)
		if candidateLower == subjectLower {
			continue
		}

		// Not an anagram if lengths differ
		if len(candidate) != len(subject) {
			continue
		}

		if sortString(candidateLower) == subjectSorted {
			result = append(result, candidate)
		}
	}

	return result
}

func sortString(s string) string {
	runes := []rune(s)
	sort.Slice(runes, func(i, j int) bool {
		return runes[i] < runes[j]
	})
	return string(runes)
}