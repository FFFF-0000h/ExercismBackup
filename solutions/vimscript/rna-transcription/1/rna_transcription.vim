function! ToRna(strand) abort
  if a:strand =~# '^[GCTA]\+$'
    return tr(a:strand, 'GCTA', 'CGAU')
  else
    return ''
  endif
endfunction