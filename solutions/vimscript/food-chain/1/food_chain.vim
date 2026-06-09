"
" Return a list containing the lyrics to `I Know an Old Lady Who Swallowed a Fly`,
" using a verse number to end on and another to start from 
"
function! Recite(endVerse, startVerse) abort
  let l:lyrics = []

  let l:animals = ['fly', 'spider', 'bird', 'cat', 'dog', 'goat', 'cow', 'horse']
  let l:comments = [
        \ '',
        \ 'It wriggled and jiggled and tickled inside her.',
        \ 'How absurd to swallow a bird!',
        \ 'Imagine that, to swallow a cat!',
        \ 'What a hog, to swallow a dog!',
        \ 'Just opened her throat and swallowed a goat!',
        \ 'I don''t know how she swallowed a cow!',
        \ ''
        \ ]

  for l:verse in range(a:startVerse, a:endVerse)
    let l:idx = l:verse - 1

    if l:idx == 7
      call add(l:lyrics, 'I know an old lady who swallowed a horse.')
      call add(l:lyrics, 'She''s dead, of course!')
      if l:verse != a:endVerse
        call add(l:lyrics, '')
      endif
      continue
    endif

    call add(l:lyrics, 'I know an old lady who swallowed a ' . l:animals[l:idx] . '.')

    if l:idx > 0
      call add(l:lyrics, l:comments[l:idx])
    endif

    if l:idx > 0
      for l:i in range(l:idx, 1, -1)
        let l:line = 'She swallowed the ' . l:animals[l:i] . ' to catch the ' . l:animals[l:i - 1]
        if l:i == 2
          let l:line = l:line . ' that wriggled and jiggled and tickled inside her'
        endif
        let l:line = l:line . '.'
        call add(l:lyrics, l:line)
      endfor
    endif

    call add(l:lyrics, 'I don''t know why she swallowed the fly. Perhaps she''ll die.')

    if l:verse != a:endVerse
      call add(l:lyrics, '')
    endif
  endfor

  return l:lyrics
endfunction