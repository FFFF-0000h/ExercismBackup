package listops

// IntList is an abstraction of a list of integers which we can define methods on
type IntList []int

func (s IntList) Foldl(fn func(int, int) int, initial int) int {
	result := initial
	for _, item := range s {
		result = fn(result, item)
	}
	return result
}

func (s IntList) Foldr(fn func(int, int) int, initial int) int {
	result := initial
	for i := len(s) - 1; i >= 0; i-- {
		result = fn(s[i], result)
	}
	return result
}

func (s IntList) Filter(fn func(int) bool) IntList {
	result := make(IntList, 0)
	for _, item := range s {
		if fn(item) {
			result = append(result, item)
		}
	}
	return result
}

func (s IntList) Length() int {
	return len(s)
}

func (s IntList) Map(fn func(int) int) IntList {
	result := make(IntList, len(s))
	for i, item := range s {
		result[i] = fn(item)
	}
	return result
}

func (s IntList) Reverse() IntList {
	result := make(IntList, len(s))
	for i, item := range s {
		result[len(s)-1-i] = item
	}
	return result
}

func (s IntList) Append(lst IntList) IntList {
	return append(s, lst...)
}

func (s IntList) Concat(lists []IntList) IntList {
	result := make(IntList, len(s))
	copy(result, s)
	
	for _, list := range lists {
		result = append(result, list...)
	}
	
	return result
}