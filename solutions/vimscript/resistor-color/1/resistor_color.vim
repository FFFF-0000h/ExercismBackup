function! Colors() abort
    return ['black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet', 'grey', 'white']
endfunction

function! ColorCode(color) abort
    let colors = Colors()
    return index(colors, a:color)
endfunction