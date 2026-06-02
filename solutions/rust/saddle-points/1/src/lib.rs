pub fn find_saddle_points(input: &[Vec<u64>]) -> Vec<(usize, usize)> {
    let rows = input.len();
    if rows == 0 {
        return Vec::new();
    }
    let cols = input[0].len();
    if cols == 0 {
        return Vec::new();
    }

    // Precompute the minimum of each column
    let mut col_min = vec![u64::MAX; cols];
    for j in 0..cols {
        for i in 0..rows {
            if input[i][j] < col_min[j] {
                col_min[j] = input[i][j];
            }
        }
    }

    let mut result = Vec::new();
    for i in 0..rows {
        // Find the maximum value in the current row
        let row_max = input[i].iter().max().copied().unwrap();
        for j in 0..cols {
            if input[i][j] == row_max && input[i][j] == col_min[j] {
                result.push((i, j));
            }
        }
    }
    result
}