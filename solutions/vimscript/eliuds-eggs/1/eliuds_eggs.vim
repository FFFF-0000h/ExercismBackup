"
" Given a base-ten number, compute how many 1 bits are present
"
" Examples:
"
"   :echo EggCount(0)
"   0
"
"   :echo EggCount(16)
"   1
"
function! EggCount(num) abort
    let n = a:num
    let result = 0
    
    while n > 0
        " and(n, 1) returns 1 if LSB is 1, 0 otherwise
        let result += and(n, 1)
        
        " Right shift by 1 (integer division)
        let n = n / 2
    endwhile
    
    return result
endfunction