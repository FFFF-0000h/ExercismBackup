"
" Create an implementation of the atbash cipher, an ancient encryption system
" created in the Middle East.
"
" Examples:
"
"   :echo AtbashEncode('test')
"   gvhg
"
"   :echo AtbashDecode('gvhg')
"   test
"
"   :echo AtbashDecode('gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt')
"   thequickbrownfoxjumpsoverthelazydog
"

function! AtbashEncode(plaintext) abort
  let l:ciphertext = ''
  let l:char_count = 0
  
  for l:char in split(tolower(a:plaintext), '\zs')
    if l:char =~# '[a-z]'
      " Atbash transformation: 'a' -> 'z', 'b' -> 'y', etc.
      let l:cipher_char = nr2char(219 - char2nr(l:char))  " 'a'(97) + 'z'(122) = 219
      let l:ciphertext .= l:cipher_char
      let l:char_count += 1
      
      " Add space every 5 characters
      if l:char_count % 5 == 0
        let l:ciphertext .= ' '
      endif
    elseif l:char =~# '[0-9]'
      " Keep numbers unchanged
      let l:ciphertext .= l:char
      let l:char_count += 1
      
      " Add space every 5 characters
      if l:char_count % 5 == 0
        let l:ciphertext .= ' '
      endif
    endif
    " Ignore punctuation and spaces
  endfor
  
  " Remove trailing space if present
  return substitute(l:ciphertext, '\s\+$', '', '')
endfunction

function! AtbashDecode(cipher) abort
  let l:plaintext = ''
  
  for l:char in split(a:cipher, '\zs')
    if l:char =~# '[a-z]'
      " Atbash transformation is symmetric: same as encoding
      let l:plain_char = nr2char(219 - char2nr(l:char))  " 'a'(97) + 'z'(122) = 219
      let l:plaintext .= l:plain_char
    elseif l:char =~# '[0-9]'
      " Keep numbers unchanged
      let l:plaintext .= l:char
    endif
    " Ignore spaces (they're only for formatting)
  endfor
  
  return l:plaintext
endfunction