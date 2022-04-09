func! s:clr(fg, bg, ...)
  let l:fg = g:marble#palette[a:fg]
  let l:bg = g:marble#palette[a:bg]
  return [ l:fg[0], l:bg[0], l:fg[1], l:bg[1] ] +
       \ filter(copy(a:000), 'type(v:val) == 1 && len(v:val) > 0')
endfunc

func! s:color_map(a, b, c, ...)
  if a:0 == 0
    return call('airline#themes#generate_color_map', [call('s:clr', a:a), call('s:clr', a:b), call('s:clr', a:c)])
  else
    return call('extend', [ call('airline#themes#generate_color_map', [call('s:clr', a:a), call('s:clr', a:b), call('s:clr', a:c)]) ] + a:000)
  endif
endfunc

let g:airline#themes#marble#palette = {
\   'normal': s:color_map(
\       ['bg', 'purple'],
\       ['fg', 'comment'],
\       ['fg', 'selection'],
\       {
\         'airline_warning': s:clr('bg', 'orange'),
\         'airline_error': s:clr('bg', 'red'),
\       },
\     ),
\   'normal_modified': s:color_map(
\       ['bg', 'purple'],
\       ['fg', 'comment'],
\       ['fg', 'bgdark'],
\       {
\         'airline_warning': s:clr('bg', 'orange'),
\         'airline_error': s:clr('bg', 'red'),
\       },
\     ),
\   'insert': s:color_map(
\       ['bg', 'green'],
\       ['fg', 'comment'],
\       ['fg', 'selection'],
\       {
\         'airline_warning': s:clr('bg', 'orange'),
\         'airline_error': s:clr('bg', 'red'),
\       },
\     ),
\   'insert_modified': s:color_map(
\       ['bg', 'green'],
\       ['fg', 'comment'],
\       ['fg', 'bgdark'],
\       {
\         'airline_warning': s:clr('bg', 'orange'),
\         'airline_error': s:clr('bg', 'red'),
\       },
\     ),
\   'replace': s:color_map(
\       ['bg', 'orange'],
\       ['fg', 'comment'],
\       ['fg', 'selection'],
\       {
\         'airline_warning': s:clr('bg', 'orange'),
\         'airline_error': s:clr('bg', 'red'),
\       },
\     ),
\   'replace_modified': s:color_map(
\       ['bg', 'orange'],
\       ['fg', 'comment'],
\       ['fg', 'bgdark'],
\       {
\         'airline_warning': s:clr('bg', 'orange'),
\         'airline_error': s:clr('bg', 'red'),
\       },
\     ),
\   'visual': s:color_map(
\       ['bg', 'yellow'],
\       ['fg', 'comment'],
\       ['fg', 'selection'],
\       {
\         'airline_warning': s:clr('bg', 'orange'),
\         'airline_error': s:clr('bg', 'red'),
\       },
\     ),
\   'visual_modified': s:color_map(
\       ['bg', 'yellow'],
\       ['fg', 'comment'],
\       ['fg', 'bgdark'],
\       {
\         'airline_warning': s:clr('bg', 'orange'),
\         'airline_error': s:clr('bg', 'red'),
\       },
\     ),
\   'inactive': s:color_map(
\       ['bg', 'comment'],
\       ['fg', 'bgdark'],
\       ['fg', 'selection'],
\       {
\         'airline_warning': s:clr('bg', 'orange'),
\         'airline_error': s:clr('bg', 'red'),
\       },
\     ),
\   'terminal': s:color_map(
\       ['bg', 'green'],
\       ['fg', 'comment'],
\       ['fg', 'selection'],
\       {
\         'airline_term': s:clr('fg', 'selection'),
\       },
\     ),
\}

if get(g:, 'airline#extensions#tabline#enabled', 0)
  let g:airline#themes#marble#palette.tabline = {
        \ 'airline_tabfill': s:clr('bg', 'bglight'),
        \
        \ 'airline_tab': s:clr('comment', 'bg'),
        \ 'airline_tabsel': s:clr('bg', 'purple'),
        \ 'airline_tabmod': s:clr('green', 'bg'),
        \
        \ 'airline_tab_right': s:clr('comment', 'bg'),
        \ 'airline_tabsel_right': s:clr('fg', 'bg', ),
        \ 'airline_tabmod_right': s:clr('green', 'bg'),
        \}
endif
if exists('g:loaded_ctrlp')
  let g:airline#themes#marble#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
        \ s:clr('fg', 'selection'),
        \ s:clr('fg', 'comment'),
        \ s:clr('fg', 'purple'),
        \)
endif
