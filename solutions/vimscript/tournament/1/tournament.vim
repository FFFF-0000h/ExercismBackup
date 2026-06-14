function! Tally(lines) abort
  " Dictionary to store team statistics
  " Key: team name, Value: [MP, W, D, L, P]
  let l:teams = {}
  
  " Process each match result
  for l:line in a:lines
    " Skip empty lines
    if empty(l:line)
      continue
    endif
    
    " Split the line by semicolon
    let l:parts = split(l:line, ';')
    
    " Validate the line format
    if len(l:parts) != 3
      continue
    endif
    
    let l:team1 = l:parts[0]
    let l:team2 = l:parts[1]
    let l:result = l:parts[2]
    
    " Initialize teams if not already in dictionary
    if !has_key(l:teams, l:team1)
      let l:teams[l:team1] = [0, 0, 0, 0, 0]  " MP, W, D, L, P
    endif
    if !has_key(l:teams, l:team2)
      let l:teams[l:team2] = [0, 0, 0, 0, 0]
    endif
    
    " Update matches played for both teams
    let l:teams[l:team1][0] += 1
    let l:teams[l:team2][0] += 1
    
    " Update based on result
    if l:result ==# 'win'
      " Team 1 wins
      let l:teams[l:team1][1] += 1  " W for team1
      let l:teams[l:team1][4] += 3  " P for team1
      let l:teams[l:team2][3] += 1  " L for team2
    elseif l:result ==# 'loss'
      " Team 2 wins
      let l:teams[l:team2][1] += 1  " W for team2
      let l:teams[l:team2][4] += 3  " P for team2
      let l:teams[l:team1][3] += 1  " L for team1
    elseif l:result ==# 'draw'
      " Draw
      let l:teams[l:team1][2] += 1  " D for team1
      let l:teams[l:team2][2] += 1  " D for team2
      let l:teams[l:team1][4] += 1  " P for team1
      let l:teams[l:team2][4] += 1  " P for team2
    endif
  endfor
  
  " Create sorted list of teams
  let l:team_list = keys(l:teams)
  
  " Custom sort: points descending, then name ascending
  call sort(l:team_list, {a, b -> l:teams[b][4] != l:teams[a][4] ? 
        \ l:teams[b][4] - l:teams[a][4] : 
        \ (a > b ? 1 : (a < b ? -1 : 0))})
  
  " Build output table
  let l:output = []
  
  " Add header
  call add(l:output, 'Team                           | MP |  W |  D |  L |  P')
  
  " Add each team's statistics
  for l:team in l:team_list
    let l:stats = l:teams[l:team]
    let l:row = printf('%-30s | %2d | %2d | %2d | %2d | %2d',
          \ l:team, l:stats[0], l:stats[1], l:stats[2], l:stats[3], l:stats[4])
    call add(l:output, l:row)
  endfor
  
  return l:output
endfunction