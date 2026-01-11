"
" Returns the position of an item in a sorted list using a binary search
" Throws an error if item isn't present
" Example:
"
"   :echo Find([4, 8, 12, 16, 23, 28, 32], 23)
"   4
"
"   :echo Find([1, 2, 3], 4)
"   E605: Exception not caught: value not in list
"
function! Find(list, value) abort
    " Initialize search boundaries
    let left = 0
    let right = len(a:list) - 1

    " Continue searching while left <= right
    while left <= right
        " Calculate middle index (integer division)
        let middle = (left + right) / 2
        
        " Check if we found the value
        if a:list[middle] == a:value
            return middle
        " If middle element is less than value, search right half
        elseif a:list[middle] < a:value
            let left = middle + 1
        " If middle element is greater than value, search left half
        else
            let right = middle - 1
        endif
    endwhile

    " Value not found - throw exception
    throw "value not in list"
endfunction