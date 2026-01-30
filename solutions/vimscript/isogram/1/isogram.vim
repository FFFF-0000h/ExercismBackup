"
" Returns 1 if the phrase has no repeating alphabetic characters, 0 otherwise.
" The letters are compared case insensitively.
"
" Example:
"
"   :echo IsIsogram('isogram')
"   1
"
"   :echo IsIsogram('eleven')
"   0
"
function! IsIsogram(phrase) abort
    " Convert to lowercase for case-insensitive comparison
    let l:lower_phrase = tolower(a:phrase)
    
    " Create a dictionary to track seen letters
    let l:seen = {}
    
    " Iterate through each character in the phrase
    for l:char in split(l:lower_phrase, '\zs')
        " Skip non-alphabetic characters (spaces, hyphens, etc.)
        if l:char !~# '[a-z]'
            continue
        endif
        
        " If we've seen this letter before, it's not an isogram
        if has_key(l:seen, l:char)
            return 0
        endif
        
        " Mark this letter as seen
        let l:seen[l:char] = 1
    endfor
    
    " If we get here, no repeating letters were found
    return 1
endfunction