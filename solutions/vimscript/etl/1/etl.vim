function! Transform(scores) abort
  let result = {}
  
  " Iterate through each point value and its letters
  for [points_str, letters] in items(a:scores)
    " Convert points from string to number
    let points = str2nr(points_str)
    
    " For each letter, add to result with lowercase key
    for letter in letters
      " Convert to lowercase
      let lowercase_letter = tolower(letter)
      
      " Add to result dictionary
      let result[lowercase_letter] = points
    endfor
  endfor
  
  return result
endfunction