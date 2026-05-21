function! Decode(string) abort
  " Decodes a run-length encoded string.
  " Assumes input only contains digits, letters, and whitespace.
  let l:result = ''
  let l:count = 0
  let l:i = 0
  while l:i < len(a:string)
    let l:ch = a:string[l:i]
    if l:ch =~# '\d'
      " Build multi‑digit number
      let l:count = l:count * 10 + str2nr(l:ch)
    else
      " Non‑digit: output previous run
      if l:count == 0
        let l:count = 1
      endif
      let l:result .= repeat(l:ch, l:count)
      let l:count = 0
    endif
    let l:i += 1
  endwhile
  return l:result
endfunction

function! Encode(string) abort
  " Encodes a string using run-length encoding.
  " Assumes input only contains letters (A-Z, a-z) and whitespace.
  let l:result = ''
  let l:len = len(a:string)
  if l:len == 0
    return l:result
  endif
  let l:current = a:string[0]
  let l:count = 1
  let l:i = 1
  while l:i < l:len
    let l:ch = a:string[l:i]
    if l:ch ==# l:current
      let l:count += 1
    else
      if l:count > 1
        let l:result .= string(l:count)
      endif
      let l:result .= l:current
      let l:current = l:ch
      let l:count = 1
    endif
    let l:i += 1
  endwhile
  " Handle the last run
  if l:count > 1
    let l:result .= string(l:count)
  endif
  let l:result .= l:current
  return l:result
endfunction