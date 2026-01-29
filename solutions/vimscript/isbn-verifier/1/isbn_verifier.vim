"
" Returns 1 if the given ISBN-10 is valid, 0 otherwise.
"
" Example:
"
"   :echo IsValid('3-598-21508-8')
"   1
"
"   :echo IsValid('3-598-21508-9')
"   0
"
function! IsValid(isbn) abort
  " Remove all hyphens from the input
  let clean_isbn = substitute(a:isbn, '-', '', 'g')
  
  " Check length: must be exactly 10 characters
  if len(clean_isbn) != 10
    return 0
  endif
  
  let total = 0
  let multiplier = 10
  
  " Process each character
  for i in range(0, 9)
    let char = clean_isbn[i]
    
    if i == 9  " Last character can be digit or 'X'
      if char ==# 'X' || char ==# 'x'
        let digit = 10
      elseif char >=# '0' && char <=# '9'
        let digit = char - '0'
      else
        return 0  " Invalid character in check digit position
      endif
    else  " First 9 characters must be digits
      if char <# '0' || char ># '9'
        return 0  " Non-digit in position
      endif
      let digit = char - '0'
    endif
    
    let total += digit * multiplier
    let multiplier -= 1
  endfor
  
  " Check if total is divisible by 11
  return total % 11 == 0 ? 1 : 0
endfunction