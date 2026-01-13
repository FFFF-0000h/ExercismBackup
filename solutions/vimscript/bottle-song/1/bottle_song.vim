"
" Return a list containing the lyrics to `Ten Green Bottles`,
" using a number of bottles to start and another number of bottles to remove
"
function! Recite(startBottles, takeDown) abort
  let number_words = {
    \ 0: 'no',
    \ 1: 'one',
    \ 2: 'two',
    \ 3: 'three',
    \ 4: 'four',
    \ 5: 'five',
    \ 6: 'six',
    \ 7: 'seven',
    \ 8: 'eight',
    \ 9: 'nine',
    \ 10: 'ten'
    \ }
  
  let verses = []
  
  for i in range(a:takeDown)
    let current = a:startBottles - i
    if current <= 0
      break
    endif
    
    let next = current - 1
    
    " Get word forms
    let current_word = number_words[current]
    let current_caps = toupper(current_word[0]) . current_word[1:]
    let next_word = next > 0 ? number_words[next] : 'no'
    
    " Handle pluralization
    let bottle_s = current == 1 ? 'bottle' : 'bottles'
    let next_bottle_s = next == 1 ? 'bottle' : 'bottles'
    
    " Build verse
    let verse = [
      \ current_caps . ' green ' . bottle_s . ' hanging on the wall,',
      \ current_caps . ' green ' . bottle_s . ' hanging on the wall,',
      \ 'And if one green bottle should accidentally fall,',
      \ 'There''ll be ' . next_word . ' green ' . next_bottle_s . ' hanging on the wall.'
      \ ]
    
    " Add verse to result
    call extend(verses, verse)
    
    " Add blank line between verses (except after the last verse)
    if i < a:takeDown - 1 && current > 1
      call add(verses, '')
    endif
  endfor
  
  return verses
endfunction