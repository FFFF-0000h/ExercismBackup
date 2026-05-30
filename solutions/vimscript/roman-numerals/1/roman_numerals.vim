"
" Write a function to convert Arabic numbers to Roman numerals.
"
" Examples:
"
"   :echo ToRoman(1990)
"   MCMXC
"
"   :echo ToRoman(2008)
"   MMVIII
"
function! ToRoman(number) abort
  let l:values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
  let l:symbols = ['M', 'CM', 'D', 'CD', 'C', 'XC', 'L', 'XL', 'X', 'IX', 'V', 'IV', 'I']
  let l:num = a:number
  let l:result = ''

  for l:i in range(len(l:values))
    while l:num >= l:values[l:i]
      let l:result .= l:symbols[l:i]
      let l:num -= l:values[l:i]
    endwhile
  endfor

  return l:result
endfunction