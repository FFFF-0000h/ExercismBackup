"
" Returns a list of actions for a secret handshake given a number in binary.
" Each action is determined by a bit in the rightmost five digits.
"
" Example:
"
"   :echo Commands('11111')
"   ['jump', 'close your eyes', 'double blink', 'wink']
"
function! Commands(binary) abort
  let l:actions = []
  let l:bits = a:binary
  let l:len = len(l:bits)
  let l:reverse_flag = 0
  " Process at most the rightmost 5 characters
  let l:bit_value = 1
  for l:i in range(l:len - 1, max([l:len - 5, 0]), -1)
    if l:bits[l:i] ==# '1'
      if l:bit_value == 1
        call add(l:actions, 'wink')
      elseif l:bit_value == 2
        call add(l:actions, 'double blink')
      elseif l:bit_value == 4
        call add(l:actions, 'close your eyes')
      elseif l:bit_value == 8
        call add(l:actions, 'jump')
      elseif l:bit_value == 16
        let l:reverse_flag = 1
      endif
    endif
    let l:bit_value = l:bit_value * 2
    if l:bit_value > 16
      break
    endif
  endfor

  if l:reverse_flag
    call reverse(l:actions)
  endif

  return l:actions
endfunction