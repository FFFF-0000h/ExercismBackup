"
" Given a number, returns its square root
"
" Example:
"
"   :echo SquareRoot(4)
"   2
"
function! SquareRoot(number) abort
  if a:number < 2
    return a:number
  endif

  " Binary search for the square root
  let l:low = 1
  let l:high = a:number / 2

  while l:low <= l:high
    let l:mid = (l:low + l:high) / 2
    let l:square = l:mid * l:mid

    if l:square == a:number
      return l:mid
    elseif l:square < a:number
      let l:low = l:mid + 1
    else
      let l:high = l:mid - 1
    endif
  endwhile

  return l:high
endfunction