pub fn spiral_matrix(size: u32) -> Vec<Vec<u32>> {
    let n = size as usize;
    if n == 0 {
        return vec![];
    }

    let mut matrix = vec![vec![0u32; n]; n];
    let mut top = 0;
    let mut bottom = n - 1;
    let mut left = 0;
    let mut right = n - 1;
    let mut num = 1u32;

    while num <= (n * n) as u32 {
        // left to right along top row
        for j in left..=right {
            matrix[top][j] = num;
            num += 1;
        }
        top += 1;
        if top > bottom {
            break;
        }

        // top to bottom along right column
        for i in top..=bottom {
            matrix[i][right] = num;
            num += 1;
        }
        right -= 1;
        if left > right {
            break;
        }

        // right to left along bottom row
        for j in (left..=right).rev() {
            matrix[bottom][j] = num;
            num += 1;
        }
        bottom -= 1;
        if top > bottom {
            break;
        }

        // bottom to top along left column
        for i in (top..=bottom).rev() {
            matrix[i][left] = num;
            num += 1;
        }
        left += 1;
    }

    matrix
}