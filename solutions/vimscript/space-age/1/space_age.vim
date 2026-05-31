"
" Returns an age in local years, given a planet name and number of seconds on Earth.
" Raises an exception if the name is not a valid planet in the solar system.
"
function! Age(planet, seconds) abort
  let l:periods = {
        \ 'mercury': 0.2408467,
        \ 'venus':   0.61519726,
        \ 'earth':   1.0,
        \ 'mars':    1.8808158,
        \ 'jupiter': 11.862615,
        \ 'saturn':  29.447498,
        \ 'uranus':  84.016846,
        \ 'neptune': 164.79132
        \ }

  let l:planet = tolower(a:planet)

  if !has_key(l:periods, l:planet)
    throw 'not a planet'
  endif

  let l:earth_year = 31557600.0
  let l:age = a:seconds / l:earth_year / l:periods[l:planet]

  return l:age
endfunction