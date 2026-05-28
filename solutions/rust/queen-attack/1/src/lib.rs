#[derive(Debug)]
pub struct ChessPosition {
    pub rank: i32,
    pub file: i32,
}

#[derive(Debug)]
pub struct Queen {
    pub position: ChessPosition,
}

impl ChessPosition {
    pub fn new(rank: i32, file: i32) -> Option<Self> {
        if (0..8).contains(&rank) && (0..8).contains(&file) {
            Some(ChessPosition { rank, file })
        } else {
            None
        }
    }
}

impl Queen {
    pub fn new(position: ChessPosition) -> Self {
        Queen { position }
    }

    pub fn can_attack(&self, other: &Queen) -> bool {
        let self_rank = self.position.rank;
        let self_file = self.position.file;
        let other_rank = other.position.rank;
        let other_file = other.position.file;

        self_rank == other_rank
            || self_file == other_file
            || (self_rank - other_rank).abs() == (self_file - other_file).abs()
    }
}