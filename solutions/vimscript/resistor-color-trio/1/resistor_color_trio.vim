function! Label(colors) abort
  " Map color names to digits
  let color_map = {
        \ 'black': 0,
        \ 'brown': 1,
        \ 'red': 2,
        \ 'orange': 3,
        \ 'yellow': 4,
        \ 'green': 5,
        \ 'blue': 6,
        \ 'violet': 7,
        \ 'grey': 8,
        \ 'white': 9
        \ }

  let d1 = color_map[a:colors[0]]
  let d2 = color_map[a:colors[1]]
  let d3 = color_map[a:colors[2]]

  let main = d1 * 10 + d2
  " Zero ohms is a special case
  if main == 0
    return "0 ohms"
  endif

  let zeros = d3
  let main_str = string(main)
  " Build the full digit string
  let digits = main_str . repeat('0', zeros)
  let len_digits = strlen(digits)

  " No metric prefix needed
  if len_digits <= 3
    return digits . " ohms"
  endif

  " Metric prefixes: ohms, kiloohms, megaohms, gigaohms
  let units = ["ohms", "kiloohms", "megaohms", "gigaohms"]
  let unit_index = (len_digits - 1) / 3
  let int_len = len_digits - unit_index * 3

  let int_part = strpart(digits, 0, int_len)
  let frac_part = strpart(digits, int_len, 3)
  " Remove trailing zeros from the fractional part
  let frac_part = substitute(frac_part, '0\+$', '', '')

  if frac_part == ""
    return int_part . " " . units[unit_index]
  else
    return int_part . "." . frac_part . " " . units[unit_index]
  endif
endfunction