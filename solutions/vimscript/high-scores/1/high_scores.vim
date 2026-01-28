function! HighScores(scores) abort
  " Create a dictionary to hold the scores and methods
  let result = {
        \ '_scores': a:scores,
        \ }

  " Method to get all scores
  function! result.Scores() dict
    return copy(self._scores)
  endfunction

  " Method to get the latest (most recent) score
  function! result.Latest() dict
    if empty(self._scores)
      return 0
    endif
    return self._scores[-1]
  endfunction

  " Method to get the personal best (highest score)
  function! result.PersonalBest() dict
    if empty(self._scores)
      return 0
    endif
    return max(self._scores)
  endfunction

  " Method to get personal top three scores
  function! result.PersonalTopThree() dict
    if empty(self._scores)
      return []
    endif

    " Create a copy to avoid modifying the original
    let sorted_scores = copy(self._scores)
    
    " Sort in descending order (numerical sort)
    call sort(sorted_scores, 'n')
    call reverse(sorted_scores)
    
    " Return top 3 or fewer if less than 3 scores
    return sorted_scores[0:min([2, len(sorted_scores) - 1])]
  endfunction

  return result
endfunction