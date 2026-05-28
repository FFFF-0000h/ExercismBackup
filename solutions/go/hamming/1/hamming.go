package hamming

import "errors"

// Distance calculates the Hamming distance between two DNA strands.
// It returns the number of differing positions, and an error if the
// strands are not of equal length.
func Distance(a, b string) (int, error) {
	if len(a) != len(b) {
		return 0, errors.New("strands must be of equal length")
	}

	distance := 0
	for i := 0; i < len(a); i++ {
		if a[i] != b[i] {
			distance++
		}
	}
	return distance, nil
}