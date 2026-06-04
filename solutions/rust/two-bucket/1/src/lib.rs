#[derive(PartialEq, Eq, Debug)]
pub enum Bucket {
    One,
    Two,
}

#[derive(PartialEq, Eq, Debug)]
pub struct BucketStats {
    pub moves: u8,
    pub goal_bucket: Bucket,
    pub other_bucket: u8,
}

pub fn solve(
    capacity_1: u8,
    capacity_2: u8,
    goal: u8,
    start_bucket: &Bucket,
) -> Option<BucketStats> {
    use std::collections::VecDeque;

    if goal > capacity_1 && goal > capacity_2 {
        return None;
    }

    let (cap_a, cap_b, start_is_one) = match start_bucket {
        Bucket::One => (capacity_1, capacity_2, true),
        Bucket::Two => (capacity_2, capacity_1, false),
    };

    // State: (amount in start bucket, amount in other bucket)
    let initial_a = cap_a;
    let initial_b = 0u8;
    
    let mut visited = vec![vec![false; cap_b as usize + 1]; cap_a as usize + 1];
    let mut queue = VecDeque::new();
    
    visited[initial_a as usize][initial_b as usize] = true;
    queue.push_back((initial_a, initial_b, 1u8));

    while let Some((a, b, moves)) = queue.pop_front() {
        if a == goal {
            return Some(BucketStats {
                moves,
                goal_bucket: if start_is_one { Bucket::One } else { Bucket::Two },
                other_bucket: b,
            });
        }
        if b == goal {
            return Some(BucketStats {
                moves,
                goal_bucket: if start_is_one { Bucket::Two } else { Bucket::One },
                other_bucket: a,
            });
        }

        // Fill start bucket
        if a < cap_a {
            let new_state = (cap_a, b);
            if !(new_state.0 == 0 && new_state.1 == cap_b) && !visited[new_state.0 as usize][new_state.1 as usize] {
                visited[new_state.0 as usize][new_state.1 as usize] = true;
                queue.push_back((new_state.0, new_state.1, moves + 1));
            }
        }

        // Fill other bucket
        if b < cap_b {
            let new_state = (a, cap_b);
            if !(new_state.0 == 0 && new_state.1 == cap_b) && !visited[new_state.0 as usize][new_state.1 as usize] {
                visited[new_state.0 as usize][new_state.1 as usize] = true;
                queue.push_back((new_state.0, new_state.1, moves + 1));
            }
        }

        // Empty start bucket
        if a > 0 {
            let new_state = (0u8, b);
            if !(new_state.0 == 0 && new_state.1 == cap_b) && !visited[new_state.0 as usize][new_state.1 as usize] {
                visited[new_state.0 as usize][new_state.1 as usize] = true;
                queue.push_back((new_state.0, new_state.1, moves + 1));
            }
        }

        // Empty other bucket
        if b > 0 {
            let new_state = (a, 0u8);
            if !(new_state.0 == 0 && new_state.1 == cap_b) && !visited[new_state.0 as usize][new_state.1 as usize] {
                visited[new_state.0 as usize][new_state.1 as usize] = true;
                queue.push_back((new_state.0, new_state.1, moves + 1));
            }
        }

        // Pour start into other
        if a > 0 && b < cap_b {
            let pour = std::cmp::min(a, cap_b - b);
            let new_state = (a - pour, b + pour);
            if !(new_state.0 == 0 && new_state.1 == cap_b) && !visited[new_state.0 as usize][new_state.1 as usize] {
                visited[new_state.0 as usize][new_state.1 as usize] = true;
                queue.push_back((new_state.0, new_state.1, moves + 1));
            }
        }

        // Pour other into start
        if b > 0 && a < cap_a {
            let pour = std::cmp::min(b, cap_a - a);
            let new_state = (a + pour, b - pour);
            if !(new_state.0 == 0 && new_state.1 == cap_b) && !visited[new_state.0 as usize][new_state.1 as usize] {
                visited[new_state.0 as usize][new_state.1 as usize] = true;
                queue.push_back((new_state.0, new_state.1, moves + 1));
            }
        }
    }

    None
}