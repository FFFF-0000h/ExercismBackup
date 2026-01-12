pub fn is_armstrong_number(num: u32) -> bool {
    // Convert number to string to get digits and count
    let num_str = num.to_string();
    let num_digits = num_str.len() as u32;
    
    // Calculate sum of digits raised to power of number of digits
    let sum: u32 = num_str
        .chars()
        .map(|c| c.to_digit(10).unwrap())
        .map(|digit| digit.pow(num_digits))
        .sum();
    
    // Compare with original number
    sum == num
}