function! Lines(strings) abort
  let result = []
  let len = len(a:strings)
  if len == 0
    return result
  endif
  for i in range(len - 1)
    call add(result, 'For want of a ' . a:strings[i] . ' the ' . a:strings[i+1] . ' was lost.')
  endfor
  call add(result, 'And all for the want of a ' . a:strings[0] . '.')
  return result
endfunction