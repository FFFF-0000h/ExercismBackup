package phonenumber

import (
	"errors"
	"strings"
	"unicode"
)

// Number cleans up a phone number and returns the 10-digit string.
func Number(phoneNumber string) (string, error) {
	digits := extractDigits(phoneNumber)

	if len(digits) == 11 && digits[0] == '1' {
		digits = digits[1:]
	}

	if len(digits) != 10 {
		return "", errors.New("invalid phone number length")
	}

	if digits[0] < '2' || digits[0] > '9' {
		return "", errors.New("area code cannot start with 0 or 1")
	}
	if digits[3] < '2' || digits[3] > '9' {
		return "", errors.New("exchange code cannot start with 0 or 1")
	}

	return digits, nil
}

// AreaCode returns the 3-digit area code of the phone number.
func AreaCode(phoneNumber string) (string, error) {
	number, err := Number(phoneNumber)
	if err != nil {
		return "", err
	}
	return number[:3], nil
}

// Format returns the phone number formatted as (XXX) XXX-XXXX.
func Format(phoneNumber string) (string, error) {
	number, err := Number(phoneNumber)
	if err != nil {
		return "", err
	}
	return "(" + number[:3] + ") " + number[3:6] + "-" + number[6:], nil
}

// extractDigits extracts only digit characters from the input string.
func extractDigits(input string) string {
	var result strings.Builder
	for _, r := range input {
		if unicode.IsDigit(r) {
			result.WriteRune(r)
		}
	}
	return result.String()
}