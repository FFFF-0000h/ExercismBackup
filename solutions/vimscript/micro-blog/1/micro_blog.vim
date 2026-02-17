scriptencoding utf-8

"
" Returns a string of five characters or less.
" Unicode characters are supported.
"
" Example:
"
"   :echo Truncate('Bärteppich')
"   Bärte
"
function! Truncate(string) abort
  " Get the character count using strchars() which counts Unicode characters
  " not bytes (unlike strlen())
  let char_count = strchars(a:string)
  
  " If already 5 or fewer characters, return as is
  if char_count <= 5
    return a:string
  endif
  
  " Truncate to 5 characters using strcharpart()
  " strcharpart() extracts a substring by character count, not byte count
  return strcharpart(a:string, 0, 5)
endfunction