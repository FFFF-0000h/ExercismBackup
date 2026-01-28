pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {
    // Return 0 if limit is 0 or 1 (no multiples possible)
    if limit == 0 || limit == 1 {
        return 0;
    }
    
    // Use a HashSet to store unique multiples
    use std::collections::HashSet;
    let mut multiples = HashSet::new();
    
    // For each factor
    for &factor in factors {
        // Skip factor 0 to avoid infinite loop
        if factor == 0 {
            continue;
        }
        
        // Generate all multiples of factor less than limit
        let mut multiple = factor;
        while multiple < limit {
            multiples.insert(multiple);
            multiple += factor;
        }
    }
    
    // Sum all unique multiples
    multiples.iter().sum()
}