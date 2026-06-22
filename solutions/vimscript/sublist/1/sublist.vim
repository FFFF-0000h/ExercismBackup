"
" Determines the relationship between two lists.
" Returns 'equal' if list1 is equal to list2.
" Returns 'superlist' if list1 contains list2.
" Returns 'sublist' if list1 is contained by list2.
" Returns 'unequal' otherwise.
"
function! Sublist(list1, list2) abort
  let l:len1 = len(a:list1)
  let l:len2 = len(a:list2)

  " Both empty -> equal
  if l:len1 == 0 && l:len2 == 0
    return 'equal'
  endif

  " Empty list is sublist of non-empty
  if l:len1 == 0
    return 'sublist'
  endif

  " Non-empty is superlist of empty
  if l:len2 == 0
    return 'superlist'
  endif

  " Equal length and equal elements -> equal
  if l:len1 == l:len2
    let l:match = 1
    for l:i in range(l:len1)
      if a:list1[l:i] != a:list2[l:i]
        let l:match = 0
        break
      endif
    endfor
    if l:match
      return 'equal'
    endif
  endif

  " Check if list1 is superlist of list2
  if l:len1 >= l:len2
    for l:i in range(l:len1 - l:len2 + 1)
      let l:match = 1
      for l:j in range(l:len2)
        if a:list1[l:i + l:j] != a:list2[l:j]
          let l:match = 0
          break
        endif
      endfor
      if l:match
        return 'superlist'
      endif
    endfor
  endif

  " Check if list1 is sublist of list2
  if l:len2 >= l:len1
    for l:i in range(l:len2 - l:len1 + 1)
      let l:match = 1
      for l:j in range(l:len1)
        if a:list2[l:i + l:j] != a:list1[l:j]
          let l:match = 0
          break
        endif
      endfor
      if l:match
        return 'sublist'
      endif
    endfor
  endif

  return 'unequal'
endfunction