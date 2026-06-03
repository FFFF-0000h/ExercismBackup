"
" Given a list and a predicate working on each element, returns a new list
" of those elements satisfying the predicate
"
function! Keep(list, predicate) abort
  let l:result = []
  for l:item in a:list
    if a:predicate(l:item)
      call add(l:result, l:item)
    endif
  endfor
  return l:result
endfunction

"
" Given a list and a predicate working on each element, returns a new list
" of those elements not satisfying the predicate
"
function! Discard(list, predicate) abort
  let l:result = []
  for l:item in a:list
    if !a:predicate(l:item)
      call add(l:result, l:item)
    endif
  endfor
  return l:result
endfunction