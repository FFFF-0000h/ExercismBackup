package luhn

import (
	"strings"
	"unicode"
)

// Valid determines whether a number is valid according to the Luhn formula.
func Valid(id string) bool {
	// Strip spaces
	id = strings.Map(func(r rune) rune {
		if r == ' ' {
			return -1
		}
		return r
	}, id)

	// Length must be greater than 1 after stripping
	if len(id) <= 1 {
		return false
	}

	// All remaining characters must be digits
	for _, r := range id {
		if !unicode.IsDigit(r) {
			return false
		}
	}

	sum := 0
	double := false // start from the rightmost digit (no doubling)

	// Process digits from right to left
	for i := len(id) - 1; i >= 0; i-- {
		digit := int(id[i] - '0')
		if double {
			digit *= 2
			if digit > 9 {
				digit -= 9
			}
		}
		sum += digit
		double = !double
	}

	return sum%10 == 0
}