pub fn find_saddle_points(input: &[Vec<u64>]) -> Vec<(usize, usize)> {
    if input.is_empty() {
        return Vec::new();
    }
    let cols = input[0].len();
    if cols == 0 {
        return Vec::new();
    }

    // Precompute the minimum of each column
    let mut col_min = vec![u64::MAX; cols];
    for row in input {
        for (j, &val) in row.iter().enumerate() {
            if val < col_min[j] {
                col_min[j] = val;
            }
        }
    }

    let mut result = Vec::new();
    for (i, row) in input.iter().enumerate() {
        let row_max = row.iter().max().copied().unwrap();
        for (j, &val) in row.iter().enumerate() {
            if val == row_max && val == col_min[j] {
                result.push((i, j));
            }
        }
    }
    result
}