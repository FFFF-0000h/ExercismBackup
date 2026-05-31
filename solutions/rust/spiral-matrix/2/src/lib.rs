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
        // left → right along top row
        for cell in matrix[top][left..=right].iter_mut() {
            *cell = num;
            num += 1;
        }
        top += 1;
        if top > bottom {
            break;
        }

        // top → bottom along right column
        for row in matrix[top..=bottom].iter_mut() {
            row[right] = num;
            num += 1;
        }
        right -= 1;
        if left > right {
            break;
        }

        // right → left along bottom row
        for cell in matrix[bottom][left..=right].iter_mut().rev() {
            *cell = num;
            num += 1;
        }
        bottom -= 1;
        if top > bottom {
            break;
        }

        // bottom → top along left column
        for row in matrix[top..=bottom].iter_mut().rev() {
            row[left] = num;
            num += 1;
        }
        left += 1;
    }

    matrix
}