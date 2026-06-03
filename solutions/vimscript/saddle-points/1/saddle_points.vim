function! SaddlePoints(matrix) abort
  let l:result = []
  if len(a:matrix) == 0
    return l:result
  endif

  let l:nrows = len(a:matrix)
  let l:ncols = len(a:matrix[0])
  if l:ncols == 0
    return l:result
  endif

  " Precompute column minima (1‑based loop easier with range)
  let l:col_min = repeat([0], l:ncols)
  for l:j in range(l:ncols)
    let l:col_min[l:j] = a:matrix[0][l:j]
    for l:i in range(1, l:nrows - 1)
      if a:matrix[l:i][l:j] < l:col_min[l:j]
        let l:col_min[l:j] = a:matrix[l:i][l:j]
      endif
    endfor
  endfor

  " Find saddle points
  for l:i in range(l:nrows)
    " Row maximum
    let l:row_max = a:matrix[l:i][0]
    for l:j in range(1, l:ncols - 1)
      if a:matrix[l:i][l:j] > l:row_max
        let l:row_max = a:matrix[l:i][l:j]
      endif
    endfor

    " Check each column in the row
    for l:j in range(l:ncols)
      if a:matrix[l:i][l:j] == l:row_max && a:matrix[l:i][l:j] == l:col_min[l:j]
        call add(l:result, {'row': l:i + 1, 'column': l:j + 1})
      endif
    endfor
  endfor

  return l:result
endfunction