#[derive(Debug, PartialEq, Eq)]
pub enum Classification {
    Abundant,
    Perfect,
    Deficient,
}

pub fn classify(num: u64) -> Option<Classification> {
    // 0 is not a positive integer; return None
    if num == 0 {
        return None;
    }

    let mut sum = 0u64;
    let limit = (num as f64).sqrt() as u64;

    for i in 1..=limit {
        if num % i == 0 {
            // Add the divisor i, unless it's the number itself (only possible for num == 1)
            if i != num {
                sum += i;
            }
            let j = num / i;
            // Add the paired divisor j if it's different from i and not the number itself
            if j != i && j != num {
                sum += j;
            }
        }
    }

    if sum == num {
        Some(Classification::Perfect)
    } else if sum < num {
        Some(Classification::Deficient)
    } else {
        Some(Classification::Abundant)
    }
}