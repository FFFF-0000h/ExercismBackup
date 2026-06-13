"
" Given a number, find the sum of all the unique multiples
" up to but not including that number.
"
" Examples:
"   :echo Sum([3, 5], 4)
"   3
"
"   :echo Sum([2, 3, 5, 7, 11], 10000)
"   39614537
"
function! Sum(factors, limit) abort
  " Create a dictionary to track unique multiples
  let l:multiples = {}
  
  " Iterate through each factor
  for l:factor in a:factors
    " Skip zero factors to avoid infinite loops
    if l:factor == 0
      continue
    endif
    
    " Find all multiples of this factor less than the limit
    let l:multiple = l:factor
    while l:multiple < a:limit
      " Add to dictionary (keys are unique, values don't matter)
      let l:multiples[l:multiple] = 1
      let l:multiple += l:factor
    endwhile
  endfor
  
  " Sum all the unique multiples
  let l:sum = 0
  for l:key in keys(l:multiples)
    let l:sum += l:key
  endfor
  
  return l:sum
endfunction