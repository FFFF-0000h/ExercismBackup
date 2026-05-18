"""Find anagrams of a target word from a list of candidate words."""

def find_anagrams(word, candidates):
    target_lower = word.lower()
    target_sorted = sorted(target_lower)
    return [
        candidate
        for candidate in candidates
        if candidate.lower() != target_lower and sorted(candidate.lower()) == target_sorted
    ]