function! Raindrops(number) abort
  let result = ''
  if a:number % 3 == 0
    let result .= 'Pling'
  endif
  if a:number % 5 == 0
    let result .= 'Plang'
  endif
  if a:number % 7 == 0
    let result .= 'Plong'
  endif
  if result == ''
    return string(a:number)
  else
    return result
  endif
endfunction