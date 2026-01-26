"
" Flattens an arbitrarily-deep nested array, removing v:null values.
"
" Examples:
"
"   :echo Flatten([])
"   []
"   :echo Flatten([0, 1, 2])
"   [0, 1, 2]
"   :echo Flatten([0, 1, [2, 3, v:null]])
"   [0, 1, 2, 3]
"
function! Flatten(array) abort
  let result = []
  
  for item in a:array
    if type(item) == type([])
      " Recursively flatten nested lists
      let flattened = Flatten(item)
      call extend(result, flattened)
    elseif item isnot v:null
      " Add non-null items (including 0 which is falsy but valid)
      call add(result, item)
    endif
  endfor
  
  return result
endfunction