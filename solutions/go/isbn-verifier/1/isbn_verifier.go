package isbnverifier

func IsValidISBN(isbn string) bool {
	var digits []int
	for _, r := range isbn {
		if r == '-' {
			continue
		}
		if r >= '0' && r <= '9' {
			digits = append(digits, int(r-'0'))
		} else if r == 'X' || r == 'x' {
			digits = append(digits, 10) // 'X' or 'x' represents 10
		} else {
			return false // invalid character
		}
	}

	if len(digits) != 10 {
		return false
	}

	// 'X' / 'x' only allowed as the last digit
	for i, d := range digits {
		if d == 10 && i != 9 {
			return false
		}
	}

	sum := 0
	for i, d := range digits {
		sum += d * (10 - i)
	}
	return sum%11 == 0
}