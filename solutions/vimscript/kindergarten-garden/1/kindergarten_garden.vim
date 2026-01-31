function! Plants(diagram, student) abort
  let children = [
        \ 'Alice', 'Bob', 'Charlie', 'David', 'Eve', 'Fred',
        \ 'Ginny', 'Harriet', 'Ileana', 'Joseph', 'Kincaid', 'Larry'
        \ ]
  let rows = split(a:diagram, "\n")
  let row1 = rows[0]
  let row2 = rows[1]

  let idx = index(children, a:student)
  if idx == -1
    return []
  endif

  let cups = []
  let pos1 = idx * 2
  let pos2 = idx * 2 + 1

  " First row cups
  call add(cups, row1[pos1])
  call add(cups, row1[pos2])
  " Second row cups
  call add(cups, row2[pos1])
  call add(cups, row2[pos2])

  let plant_names = {
        \ 'V': 'violets',
        \ 'R': 'radishes',
        \ 'C': 'clover',
        \ 'G': 'grass'
        \ }

  let result = []
  for cup in cups
    call add(result, plant_names[cup])
  endfor
  return result
endfunction