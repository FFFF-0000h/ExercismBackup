pub fn square(s: u32) -> u64 {
    if !(1..=64).contains(&s) {
        panic!("Square must be between 1 and 64");
    }
    // Using bit shift for 2^(s-1)
    1u64 << (s - 1)
}

pub fn total() -> u64 {
    // Sum of geometric series: 2^64 - 1
    u64::MAX
}