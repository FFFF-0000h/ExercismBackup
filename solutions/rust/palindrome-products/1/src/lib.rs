use std::collections::HashSet;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Palindrome {
    value: u64,
    factors: HashSet<(u64, u64)>,
}

impl Palindrome {
    pub fn value(&self) -> u64 {
        self.value
    }

    pub fn into_factors(self) -> HashSet<(u64, u64)> {
        self.factors
    }
}

/// Returns true if the number is a palindrome (reads the same backwards).
fn is_palindrome(n: u64) -> bool {
    let s = n.to_string();
    s == s.chars().rev().collect::<String>()
}

pub fn palindrome_products(min: u64, max: u64) -> Option<(Palindrome, Palindrome)> {
    if min > max {
        return None;
    }

    let mut min_pal: Option<Palindrome> = None;
    let mut max_pal: Option<Palindrome> = None;

    for i in min..=max {
        for j in i..=max {
            let product = i * j;
            if !is_palindrome(product) {
                continue;
            }

            // Update smallest palindrome
            match &mut min_pal {
                None => {
                    min_pal = Some(Palindrome {
                        value: product,
                        factors: HashSet::from([(i, j)]),
                    });
                }
                Some(p) if product < p.value => {
                    p.value = product;
                    p.factors.clear();
                    p.factors.insert((i, j));
                }
                Some(p) if product == p.value => {
                    p.factors.insert((i, j));
                }
                _ => {}
            }

            // Update largest palindrome
            match &mut max_pal {
                None => {
                    max_pal = Some(Palindrome {
                        value: product,
                        factors: HashSet::from([(i, j)]),
                    });
                }
                Some(p) if product > p.value => {
                    p.value = product;
                    p.factors.clear();
                    p.factors.insert((i, j));
                }
                Some(p) if product == p.value => {
                    p.factors.insert((i, j));
                }
                _ => {}
            }
        }
    }

    match (min_pal, max_pal) {
        (Some(min), Some(max)) => Some((min, max)),
        _ => None,
    }
}