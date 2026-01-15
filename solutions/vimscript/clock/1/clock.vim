" Returns a clock that supports adding or subtracting minutes
" as well as formatting the current time for display
function! Clock(hours, minutes) abort
  " Normalize the time to handle overflow/underflow
  let total_minutes = a:hours * 60 + a:minutes
  
  " Handle negative minutes by adding days until positive
  while total_minutes < 0
    let total_minutes = total_minutes + (24 * 60)
  endwhile
  
  " Handle minutes greater than a day by modulo operation
  let total_minutes = total_minutes % (24 * 60)
  
  " Create a clock object/dictionary
  " Note: Using ToString (capital T) to match test expectations
  let clock = {
        \ 'total_minutes': total_minutes,
        \ 'Add': function('s:ClockAdd'),
        \ 'Subtract': function('s:ClockSubtract'),
        \ 'ToString': function('s:ClockToString'),
        \ 'Equals': function('s:ClockEquals')
        \ }
  
  return clock
endfunction

" Add minutes to a clock
function! s:ClockAdd(minutes) dict
  let self.total_minutes = self.total_minutes + a:minutes
  
  " Handle overflow by modulo operation
  let self.total_minutes = self.total_minutes % (24 * 60)
  
  " Handle negative results
  while self.total_minutes < 0
    let self.total_minutes = self.total_minutes + (24 * 60)
  endwhile
  
  return self
endfunction

" Subtract minutes from a clock
function! s:ClockSubtract(minutes) dict
  " Subtracting is the same as adding negative minutes
  return self.Add(-a:minutes)
endfunction

" Format the clock time as HH:MM
function! s:ClockToString() dict
  let hours = self.total_minutes / 60
  let minutes = self.total_minutes % 60
  
  " Format hours and minutes with leading zeros
  return printf('%02d:%02d', hours, minutes)
endfunction

" Check if two clocks represent the same time
function! s:ClockEquals(other_clock) dict
  " Compare the normalized total minutes
  return self.total_minutes == a:other_clock.total_minutes
endfunction