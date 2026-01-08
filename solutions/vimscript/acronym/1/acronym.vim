" Convert a phrase into an uppercased acronym formed from
" the initial letter of each word, ignoring leading underscores
"
" Examples:
"
"   :echo Abbreviate('First In, First Out')
"   FIFO
"
"   :echo Abbreviate('The Road _Not_ Taken')
"   TRNT
"
function! Abbreviate(phrase) abort
  " Remove all punctuation except hyphens (which act as word separators)
  " and underscores (which we handle specially later)
  let cleaned = substitute(a:phrase, '[[:punct:]&&[^-_]]', '', 'g')
  
  " Replace hyphens with spaces to treat them as word separators
  let cleaned = substitute(cleaned, '-', ' ', 'g')
  
  " Split into words
  let words = split(cleaned)
  
  " Initialize acronym
  let acronym = ''
  
  " Process each word
  for word in words
    " Find the first alphabetic character, ignoring leading underscores
    let first_char = matchstr(word, '\a')
    
    " If we found an alphabetic character, add it to the acronym
    if !empty(first_char)
      let acronym .= toupper(first_char)
    endif
  endfor
  
  return acronym
endfunction