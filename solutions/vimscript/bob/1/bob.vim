"
" This function takes any remark and returns Bob's response.
"
function! Response(remark) abort
  " Trim whitespace from both ends
  let l:trimmed = trim(a:remark)
  
  " Check if it's silent (empty after trimming)
  if empty(l:trimmed)
    return 'Fine. Be that way!'
  endif
  
  " Check if it has any letters
  let l:has_letters = match(l:trimmed, '[A-Za-z]') != -1
  
  " Check if it's ALL CAPS (yelling)
  " Only consider it yelling if there are letters and they're all uppercase
  let l:is_all_caps = l:has_letters && l:trimmed ==# toupper(l:trimmed)
  
  " Check if it's a question (ends with question mark)
  let l:is_question = l:trimmed[-1:] ==# '?'
  
  " Determine response based on combinations
  if l:is_all_caps && l:is_question
    return 'Calm down, I know what I''m doing!'
  elseif l:is_all_caps
    return 'Whoa, chill out!'
  elseif l:is_question
    return 'Sure.'
  else
    return 'Whatever.'
  endif
endfunction