#[derive(Debug, PartialEq, Eq)]
pub enum Classification {
    Abundant,
    Perfect,
    Deficient,
}

pub fn classify(num: u64) -> Option<Classification> {
    if num == 0 {
        return None;
    }

    let mut sum = 0u64;
    let limit = (num as f64).sqrt() as u64;

    for i in 1..=limit {
        if num.is_multiple_of(i) {
            // i is a divisor
            if i != num {
                sum += i;
            }
            let j = num / i;
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