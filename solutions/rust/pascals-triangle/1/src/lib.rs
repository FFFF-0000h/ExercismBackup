pub struct PascalsTriangle {
    rows: Vec<Vec<u32>>,
}

impl PascalsTriangle {
    pub fn new(row_count: u32) -> Self {
        let mut rows: Vec<Vec<u32>> = Vec::with_capacity(row_count as usize);
        for i in 0..row_count {
            let i = i as usize;
            let mut row = vec![1u32; i + 1];
            if i > 0 {
                let prev: &Vec<u32> = &rows[i - 1];
                for j in 1..i {
                    row[j] = prev[j - 1] + prev[j];
                }
            }
            rows.push(row);
        }
        PascalsTriangle { rows }
    }

    pub fn rows(&self) -> Vec<Vec<u32>> {
        self.rows.clone()
    }
}