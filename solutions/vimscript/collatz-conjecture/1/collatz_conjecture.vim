"
" Returns the number of steps to reach 1 for a given number
" using the Collatz Conjecture or 3x+1 problem.
" Throws an error if input is less than 1.
"
" Example:
"
"   :echo Steps(16)
"   4
"
"   :echo Steps(-1)
"   E605: Exception not caught: Only positive integers are allowed
"
function! Steps(number) abort
  " Check for valid input
  if a:number < 1
    throw "Only positive integers are allowed"
  endif
  
  let steps = 0
  let n = a:number
  
  " Apply Collatz rules until we reach 1
  while n != 1
    if n % 2 == 0
      " n is even: n = n / 2
      let n = n / 2
    else
      " n is odd: n = 3*n + 1
      let n = 3 * n + 1
    endif
    let steps += 1
  endwhile
  
  return steps
endfunction