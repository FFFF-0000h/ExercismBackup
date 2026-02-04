export const rows = (numRows) => {
  if (numRows === 0) {
    return [];
  }
  
  // Initialize with the first row
  const triangle = [[1]];
  
  // Generate remaining rows
  for (let i = 1; i < numRows; i++) {
    const prevRow = triangle[i - 1];
    const newRow = [1]; // First element is always 1
    
    // Calculate middle values
    for (let j = 1; j < i; j++) {
      // Each value is the sum of the two values above it
      newRow.push(prevRow[j - 1] + prevRow[j]);
    }
    
    newRow.push(1); // Last element is always 1
    triangle.push(newRow);
  }
  
  return triangle;
};