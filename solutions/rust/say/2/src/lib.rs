const ONES: [&str; 10] = [
    "", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
];

const TEENS: [&str; 10] = [
    "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen",
    "seventeen", "eighteen", "nineteen",
];

const TENS: [&str; 10] = [
    "", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety",
];

const SCALES: [&str; 7] = [
    "",
    "thousand",
    "million",
    "billion",
    "trillion",
    "quadrillion",
    "quintillion",
];

/// Convert a number (0..999) into its English word representation.
/// Returns an empty string for 0 (the caller must handle zero separately).
fn hundreds_to_words(n: u64) -> String {
    let mut s = String::new();
    let hundreds = n / 100;
    let remainder = n % 100;

    if hundreds > 0 {
        s.push_str(ONES[hundreds as usize]);
        s.push_str(" hundred");
    }

    if remainder > 0 {
        if !s.is_empty() {
            s.push(' ');
        }
        if remainder < 10 {
            s.push_str(ONES[remainder as usize]);
        } else if remainder < 20 {
            s.push_str(TEENS[(remainder - 10) as usize]);
        } else {
            let tens_digit = remainder / 10;
            let ones_digit = remainder % 10;
            s.push_str(TENS[tens_digit as usize]);
            if ones_digit > 0 {
                s.push('-');
                s.push_str(ONES[ones_digit as usize]);
            }
        }
    }

    s
}

pub fn encode(n: u64) -> String {
    if n == 0 {
        return "zero".to_string();
    }

    let mut parts = Vec::new();
    let mut remaining = n;
    let mut scale_idx = 0;

    while remaining > 0 {
        let chunk = remaining % 1000; // already u64, no cast needed
        remaining /= 1000;

        if chunk != 0 {
            let chunk_words = hundreds_to_words(chunk);
            if scale_idx == 0 {
                parts.push(chunk_words);
            } else {
                parts.push(format!("{} {}", chunk_words, SCALES[scale_idx]));
            }
        }
        scale_idx += 1;
    }

    parts.reverse();
    parts.join(" ")
}