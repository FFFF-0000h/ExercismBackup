"
" Given a number string, determine whether it's valid per the Luhn formula
"
" Example:
"
" :echo IsValid('055 444 285')
" 1
"
function! IsValid(value) abort
  " Step 1: Remove all spaces
  let cleaned = substitute(a:value, '\s', '', 'g')
  
  " Step 2: Check for invalid length or non-digit characters
  if len(cleaned) <= 1
    return 0
  endif
  
  " Check if string contains only digits
  if cleaned =~ '[^0-9]'
    return 0
  endif
  
  " Step 3: Convert string to list of digits
  let digits = []
  for i in range(len(cleaned))
    call add(digits, str2nr(cleaned[i]))
  endfor
  
  " Step 4: Process digits from right to left
  " Double every second digit starting from the second last digit
  let sum = 0
  let double_next = 0  " Start with NOT doubling the last digit
  
  " Process digits from right to left
  for i in range(len(digits) - 1, 0, -1)
    let digit = digits[i]
    
    if double_next
      let doubled = digit * 2
      if doubled > 9
        let doubled = doubled - 9
      endif
      let sum += doubled
    else
      let sum += digit
    endif
    
    " Toggle for next iteration
    let double_next = !double_next
  endfor
  
  " Step 5: Check if sum is divisible by 10
  return sum % 10 == 0
endfunction