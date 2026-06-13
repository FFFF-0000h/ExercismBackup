package etl

import "strings"

func Transform(in map[int][]string) map[string]int {
	result := make(map[string]int)
	
	for score, letters := range in {
		for _, letter := range letters {
			// Convert the letter to lowercase and add to result map
			result[strings.ToLower(letter)] = score
		}
	}
	
	return result
}