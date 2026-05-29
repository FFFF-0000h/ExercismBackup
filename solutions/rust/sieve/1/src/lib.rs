pub fn primes_up_to(upper_bound: u64) -> Vec<u64> {
    if upper_bound < 2 {
        return Vec::new();
    }

    let limit = upper_bound as usize;
    // We'll use a vector of bools, initially all true for numbers 2..=limit
    let mut is_prime = vec![true; limit + 1];

    // 0 and 1 are not primes, but we'll start from 2
    // Apply sieve
    let sqrt_limit = (limit as f64).sqrt() as usize;
    for candidate in 2..=sqrt_limit {
        if is_prime[candidate] {
            // Mark multiples of candidate as composite
            // Start from candidate^2 because smaller multiples have already been marked
            let mut multiple = candidate * candidate;
            while multiple <= limit {
                is_prime[multiple] = false;
                multiple += candidate;
            }
        }
    }

    // Collect primes
    (2..=limit)
        .filter(|&num| is_prime[num])
        .map(|num| num as u64)
        .collect()
}