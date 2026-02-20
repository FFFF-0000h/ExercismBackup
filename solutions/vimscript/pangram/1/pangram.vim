function! IsPangram(sentence) abort
  let s = tolower(a:sentence)
  for c in range(char2nr('a'), char2nr('z'))
    if stridx(s, nr2char(c)) == -1
      return 0
    endif
  endfor
  return 1
endfunction