"
" Given a matrix of 0s (dead cells) and 1s (live cells),
" apply the rules of Conway's Game of Life to the matrix,
" and return the matrix after one generation.
"
function! Tick(matrix) abort
  " Make a copy of the matrix to work with
  let new_matrix = deepcopy(a:matrix)
  
  " Get dimensions of the matrix
  let rows = len(a:matrix)
  if rows == 0
    return []
  endif
  let cols = len(a:matrix[0])
  
  " Iterate through each cell
  for row in range(rows)
    for col in range(cols)
      " Count live neighbors (including diagonals)
      let live_neighbors = 0
      
      " Check all 8 possible neighbor positions
      for dr in [-1, 0, 1]
        for dc in [-1, 0, 1]
          " Skip the cell itself
          if dr == 0 && dc == 0
            continue
          endif
          
          let neighbor_row = row + dr
          let neighbor_col = col + dc
          
          " Check if neighbor is within bounds
          if neighbor_row >= 0 && neighbor_row < rows && 
           \ neighbor_col >= 0 && neighbor_col < cols
            " Add neighbor's value (1 for live, 0 for dead)
            let live_neighbors += a:matrix[neighbor_row][neighbor_col]
          endif
        endfor
      endfor
      
      " Apply the rules
      let current_cell = a:matrix[row][col]
      
      if current_cell == 1
        " Live cell: lives on if 2 or 3 neighbors
        if live_neighbors != 2 && live_neighbors != 3
          let new_matrix[row][col] = 0
        endif
      else
        " Dead cell: becomes alive if exactly 3 neighbors
        if live_neighbors == 3
          let new_matrix[row][col] = 1
        endif
      endif
    endfor
  endfor
  
  return new_matrix
endfunction