"
" Generate a list of primes between 2 and the specified limit using
" the Sieve of Eratosthenes.
"
function! Primes(limit) abort
  if a:limit < 2
    return []
  endif

  " Initialize the sieve: true (1) for every number from 0 to limit
  let l:sieve = repeat([1], a:limit + 1)
  let l:sieve[0] = 0
  let l:sieve[1] = 0

  " Only need to check up to sqrt(limit)
  let l:max_check = float2nr(sqrt(a:limit))

  for l:i in range(2, l:max_check)
    if l:sieve[l:i]
      " Mark all multiples of i, starting from i*i
      for l:j in range(l:i * l:i, a:limit, l:i)
        let l:sieve[l:j] = 0
      endfor
    endif
  endfor

  " Collect primes
  let l:primes = []
  for l:i in range(2, a:limit)
    if l:sieve[l:i]
      call add(l:primes, l:i)
    endif
  endfor

  return l:primes
endfunction