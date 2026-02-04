"
" Given a customer name and a ticket number, return a formatted ticket message.
"
" Example:
"
" :echo Format('Maarten', 9)
" Maarten, you are the 9th customer we serve today. Thank you!
"
function! Format(name, number) abort
  " Get the last digit and last two digits for ordinal rules
  let last_digit = a:number % 10
  let last_two_digits = a:number % 100
  
  " Determine the ordinal suffix
  if last_two_digits == 11 || last_two_digits == 12 || last_two_digits == 13
    let suffix = 'th'
  elseif last_digit == 1
    let suffix = 'st'
  elseif last_digit == 2
    let suffix = 'nd'
  elseif last_digit == 3
    let suffix = 'rd'
  else
    let suffix = 'th'
  endif
  
  " Construct and return the message
  return a:name . ', you are the ' . a:number . suffix . ' customer we serve today. Thank you!'
endfunction