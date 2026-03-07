function! Value(colors) abort
  let l:color_map = {
        \ 'black': 0,
        \ 'brown': 1,
        \ 'red': 2,
        \ 'orange': 3,
        \ 'yellow': 4,
        \ 'green': 5,
        \ 'blue': 6,
        \ 'violet': 7,
        \ 'grey': 8,
        \ 'white': 9
        \ }
  let l:first = a:colors[0]
  let l:second = a:colors[1]
  let l:value = l:color_map[l:first] * 10 + l:color_map[l:second]
  return l:value
endfunction