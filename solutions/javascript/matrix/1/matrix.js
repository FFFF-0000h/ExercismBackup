export class Matrix {
  constructor(matrixString) {
    // Parse the matrix string into a 2D array of numbers
    this._rows = matrixString
      .split('\n')
      .map(row => row.split(' ').map(Number));
  }

  get rows() {
    // Return a copy of the rows to prevent external modification
    return this._rows.map(row => [...row]);
  }

  get columns() {
    // Transpose the rows to get columns
    if (this._rows.length === 0) return [];
    
    const numCols = this._rows[0].length;
    const columns = [];
    
    for (let col = 0; col < numCols; col++) {
      const column = [];
      for (let row = 0; row < this._rows.length; row++) {
        column.push(this._rows[row][col]);
      }
      columns.push(column);
    }
    
    return columns;
  }
}