"
" Given a string of digits, returns a list of all contiguous substrings
" using the slice length.
"
" Example:
"
"   :echo Slices('49142', 3)
"   ['491', '914', '142']
"
function! Slices(series, sliceLength) abort
  if strlen(a:series) == 0
    throw "series cannot be empty"
  endif
  if a:sliceLength == 0
    throw "slice length cannot be zero"
  endif
  if a:sliceLength < 0
    throw "slice length cannot be negative"
  endif
  if a:sliceLength > strlen(a:series)
    throw "slice length cannot be greater than series length"
  endif

  let l:result = []
  let l:len = strlen(a:series)
  for l:i in range(l:len - a:sliceLength + 1)
    call add(l:result, strpart(a:series, l:i, a:sliceLength))
  endfor
  return l:result
endfunction