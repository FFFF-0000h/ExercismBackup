export const cost = (books) => {
  // Base price per book
  const BASE_PRICE = 800; // in cents
  
  // Discounts for different group sizes
  const DISCOUNTS = {
    1: 0,    // 0% discount
    2: 5,    // 5% discount
    3: 10,   // 10% discount
    4: 20,   // 20% discount
    5: 25    // 25% discount
  };
  
  // Calculate price for a group of books
  const calculateGroupPrice = (groupSize) => {
    const discount = DISCOUNTS[groupSize] || 0;
    const pricePerBook = BASE_PRICE * (100 - discount) / 100;
    return Math.round(groupSize * pricePerBook);
  };
  
  // Count how many of each book we have
  const bookCounts = [0, 0, 0, 0, 0];
  books.forEach(book => {
    if (book >= 1 && book <= 5) {
      bookCounts[book - 1]++;
    }
  });
  
  // Sort book counts in descending order
  bookCounts.sort((a, b) => b - a);
  
  // Helper function to find the optimal grouping
  const findOptimalCost = (counts) => {
    // Base case: if all counts are 0, cost is 0
    if (counts.every(count => count === 0)) {
      return 0;
    }
    
    // Filter out books with count > 0
    const nonZeroCounts = counts.filter(count => count > 0);
    
    let minCost = Infinity;
    
    // Try grouping from largest possible group size down to 2
    // (group of 1 is just regular price)
    const maxGroupSize = Math.min(nonZeroCounts.length, 5);
    
    for (let groupSize = maxGroupSize; groupSize >= 1; groupSize--) {
      // Create a copy of counts for this branch
      const newCounts = [...counts];
      
      // Take one of each of the first 'groupSize' books
      for (let i = 0; i < groupSize; i++) {
        if (newCounts[i] > 0) {
          newCounts[i]--;
        }
      }
      
      // Sort descending again
      newCounts.sort((a, b) => b - a);
      
      // Calculate cost for this group plus rest
      const groupCost = calculateGroupPrice(groupSize);
      const remainingCost = findOptimalCost(newCounts);
      const totalCost = groupCost + remainingCost;
      
      if (totalCost < minCost) {
        minCost = totalCost;
      }
    }
    
    return minCost;
  };
  
  // Calculate and return the optimal cost
  return findOptimalCost(bookCounts);
};