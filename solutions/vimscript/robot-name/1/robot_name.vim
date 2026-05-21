" Store used names globally to guarantee uniqueness.
let s:used_names = []
let s:seeded = 0

" Internal: generate a single random name.
function! s:generate_name()
  " Two uppercase letters (A-Z)
  let l:letters = nr2char(65 + (rand() % 26)) . nr2char(65 + (rand() % 26))
  " Three digits with leading zeros
  let l:digits  = printf('%03d', rand() % 1000)
  return l:letters . l:digits
endfunction

" Internal: return a name that is not currently in use.
function! s:unique_name()
  let l:name = s:generate_name()
  while index(s:used_names, l:name) != -1
    let l:name = s:generate_name()
  endwhile
  call add(s:used_names, l:name)
  return l:name
endfunction

" Internal: remove a name from the used list (called on reset).
function! s:release_name(name)
  call filter(s:used_names, 'v:val !=# a:name')
endfunction

"
" Creates a robot with a random name and a Reset method.
"
function! Create() abort
  " Seed the random generator once.
  if !s:seeded
    call srand(reltime()[1])
    let s:seeded = 1
  endif

  let l:robot = {}
  let l:robot.name = s:unique_name()

  " Define the Reset method. Using a closure so it can modify 'self'.
  function! l:robot.Reset() closure
    call s:release_name(self.name)
    let self.name = s:unique_name()
  endfunction

  return l:robot
endfunction