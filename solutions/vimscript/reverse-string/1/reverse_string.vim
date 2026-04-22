function! Reverse(text) abort
  " Split the string into individual characters, reverse the list,
  " and join them back into a string.
  return join(reverse(split(a:text, '\zs')), '')
endfunction