pub fn egg_count(display_value: u32) -> usize {
    let mut count = 0;
    let mut n = display_value;
    
    // Keep counting until all bits are 0
    while n > 0 {
        // n & (n-1) clears the lowest set bit
        // Each iteration removes one set bit
        n = n & (n.wrapping_sub(1));
        count += 1;
    }
    
    count
}