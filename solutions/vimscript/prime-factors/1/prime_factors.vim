"
" Given a number, return its prime factors.
"
" Examples:
"   :echo Factors(1)
"   []
"
"   :echo Factors(12)
"   [2, 2, 3]
"
function! Factors(value) abort
  let n = a:value
  let factors = []
  let divisor = 2
  while n > 1
    if n % divisor == 0
      call add(factors, divisor)
      let n = n / divisor
    else
      let divisor = divisor + 1
    endif
  endwhile
  return factors
endfunction