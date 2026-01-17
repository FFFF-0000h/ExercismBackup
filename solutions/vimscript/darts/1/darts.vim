"
" Calculate the score of a single dart toss, given the distance
" from the center of the board in the X and Y graph axes.
" The circular dartboard is ten units wide from the center to the edge.
"
" Example:
"
" :echo Darts(0, 0)
" 10
"
" :echo Darts(11, 11)
" 0
"
function! Darts(x, y) abort
  " Calculate the squared distance from the center (0, 0)
  let l:distance_squared = a:x * a:x + a:y * a:y
  
  " Check which circle the dart lands in (using squared distances to avoid sqrt)
  if l:distance_squared <= 1
    " Inner circle: radius 1 or less
    return 10
  elseif l:distance_squared <= 25
    " Middle circle: radius 5 or less (but more than 1)
    return 5
  elseif l:distance_squared <= 100
    " Outer circle: radius 10 or less (but more than 5)
    return 1
  else
    " Outside the target
    return 0
  endif
endfunction