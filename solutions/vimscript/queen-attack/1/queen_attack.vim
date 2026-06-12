function! Queen(row, column) abort
  if a:row < 0
    throw 'row not positive'
  endif
  if a:row > 7
    throw 'row not on board'
  endif
  if a:column < 0
    throw 'column not positive'
  endif
  if a:column > 7
    throw 'column not on board'
  endif

  let l:queen = {
        \ 'row': a:row,
        \ 'column': a:column,
        \ 'CanAttack': function('CanAttack')
        \ }
  return l:queen
endfunction

function! CanAttack(other) dict abort
  " Same row
  if self['row'] == a:other['row']
    return 1
  endif

  " Same column
  if self['column'] == a:other['column']
    return 1
  endif

  " Same diagonal
  let l:row_diff = abs(self['row'] - a:other['row'])
  let l:col_diff = abs(self['column'] - a:other['column'])
  if l:row_diff == l:col_diff
    return 1
  endif

  return 0
endfunction