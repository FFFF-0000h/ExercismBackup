function! LargestProduct(digits, span) abort
  if a:span < 0 || a:span > len(a:digits)
    return -1
  endif

  if a:digits =~ '\D'
    return -1
  endif

  let l:largestProduct = 0
  for l:i in range(0, len(a:digits) - a:span)
    let l:product = 1
    for l:j in range(l:i, l:i + a:span - 1)
      let l:product *= a:digits[l:j]
    endfor

    if l:product > l:largestProduct
      let l:largestProduct = l:product
    endif
  endfor

  return l:largestProduct
endfunction
