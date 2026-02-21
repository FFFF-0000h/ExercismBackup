"
" Clean up user-entered phone numbers so that they can be sent SMS messages.
"
" Example:
"
"   :echo ToNANP('+1 (613)-995-0253')
"   6139950253
"
function! ToNANP(number) abort
  " Remove all non‑digit characters
  let digits = substitute(a:number, '\D', '', 'g')

  " If length is 11 and starts with '1', strip the country code
  if len(digits) == 11 && digits[0] == '1'
    let digits = digits[1:]
  endif

  " Must have exactly 10 digits now
  if len(digits) != 10
    return ''
  endif

  " Area code (first digit) and exchange code (fourth digit) must be 2–9
  if digits[0] < '2' || digits[0] > '9' || digits[3] < '2' || digits[3] > '9'
    return ''
  endif

  return digits
endfunction