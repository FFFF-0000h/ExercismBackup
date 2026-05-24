function! Rotate(shiftKey, text) abort
  " Normalize the key to the range [0, 25]
  let l:key = a:shiftKey % 26
  if l:key < 0
    let l:key += 26
  endif

  let l:result = ''

  " Iterate over each character in the input text
  for l:i in range(strlen(a:text))
    let l:c = a:text[l:i]
    let l:code = char2nr(l:c)

    if l:code >= 65 && l:code <= 90
      " Uppercase letter
      let l:newcode = ((l:code - 65 + l:key) % 26) + 65
      let l:result .= nr2char(l:newcode)
    elseif l:code >= 97 && l:code <= 122
      " Lowercase letter
      let l:newcode = ((l:code - 97 + l:key) % 26) + 97
      let l:result .= nr2char(l:newcode)
    else
      " Non‑alphabetic character – keep unchanged
      let l:result .= l:c
    endif
  endfor

  return l:result
endfunction