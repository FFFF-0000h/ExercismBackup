"
" Creates a two-dimensional array that can be queried
" by a row or a column index, returning the values along
" that axis.
"
function! Matrix(string) abort
  let lines = split(a:string, "\n")
  let matrix = map(lines, 'split(v:val)')

  return {
        \ 'Row': function('s:Row', [matrix]),
        \ 'Column': function('s:Column', [matrix]),
        \ }
endfunction

function! s:Row(matrix, index) abort
  return a:matrix[a:index - 1]
endfunction

function! s:Column(matrix, index) abort
  let result = []
  for row in a:matrix
    call add(result, row[a:index - 1])
  endfor
  return result
endfunction
