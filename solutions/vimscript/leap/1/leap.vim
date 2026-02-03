"
" This function takes a year and returns 1 if it's a leap year
" and 0 otherwise.
"
function! LeapYear(year) abort
  let year = a:year
  
  " Leap year rules:
  " 1. Divisible by 4
  " 2. But not divisible by 100, unless also divisible by 400
  if year % 4 == 0
    if year % 100 == 0
      return year % 400 == 0 ? 1 : 0
    else
      return 1
    endif
  else
    return 0
  endif
endfunction