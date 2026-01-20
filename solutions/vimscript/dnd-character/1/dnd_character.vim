"
" Calculates the constitution modifier using the passed ability score
"
function! Modifier(score) abort
  return float2nr(floor((a:score - 10) / 2.0))
endfunction

"
" Calculates an ability score randomly by summing the top three of four randomly generated numbers
"
function! Ability() abort
  " Generate four random numbers between 1 and 6
  let rolls = []
  for i in range(4)
    call add(rolls, rand() % 6 + 1)
  endfor
  
  " Sort in descending order and sum the top three
  call sort(rolls, 'n')
  return rolls[1] + rolls[2] + rolls[3]
endfunction

"
" Returns a dictionary representing a D&D character with randomly generated ability scores
"
function! Character() abort
  let character = {}
  
  " Generate six ability scores
  let character.strength = Ability()
  let character.dexterity = Ability()
  let character.constitution = Ability()
  let character.intelligence = Ability()
  let character.wisdom = Ability()
  let character.charisma = Ability()
  
  " Calculate hitpoints
  let character.hitpoints = 10 + Modifier(character.constitution)
  
  return character
endfunction

" Helper function to print/display a character
function! DisplayCharacter() abort
  let char = Character()
  echo "D&D Character:"
  echo "  Strength:     " . char.strength
  echo "  Dexterity:    " . char.dexterity
  echo "  Constitution: " . char.constitution . " (Modifier: " . Modifier(char.constitution) . ")"
  echo "  Intelligence: " . char.intelligence
  echo "  Wisdom:       " . char.wisdom
  echo "  Charisma:     " . char.charisma
  echo "  Hitpoints:    " . char.hitpoints
endfunction

" Test the functions
function! TestDnDCharacter() abort
  echo "Testing Ability() function..."
  let score = Ability()
  echo "Random ability score: " . score
  
  echo "\nTesting Modifier() function..."
  echo "Modifier for score 3: " . Modifier(3)
  echo "Modifier for score 10: " . Modifier(10)
  echo "Modifier for score 18: " . Modifier(18)
  
  echo "\nGenerating a random character..."
  call DisplayCharacter()
endfunction