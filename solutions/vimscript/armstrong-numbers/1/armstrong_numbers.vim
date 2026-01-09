"
" Tests whether a number is equal to the sum of its digits, 
" each raised to the power of the overall number of digits.
"
function! IsArmstrongNumber(number) abort
  " Convert number to string to work with individual digits
  let num_str = string(a:number)
  
  " Count the number of digits
  let num_digits = len(num_str)
  
  " Calculate sum of digits^num_digits
  let sum = 0
  for i in range(num_digits)
    " Get each digit as a number
    let digit = str2nr(num_str[i])
    
    " Calculate digit^num_digits (Vim uses float for pow())
    let sum = sum + pow(digit, num_digits)
  endfor
  
  " Check if sum equals original number
  " Note: sum is float from pow(), so convert to number for comparison
  return float2nr(sum) == a:number
endfunction