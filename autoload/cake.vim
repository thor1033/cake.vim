" -----------------------------------------------------------------------------
" File: cake.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/cake-community/cake
" -----------------------------------------------------------------------------

function! cake#invert_signs_toggle()
  if g:cake_invert_signs == 0
    let g:cake_invert_signs=1
  else
    let g:cake_invert_signs=0
  endif

  colorscheme cake
endfunction

" Search Highlighting {{{

function! cake#hls_show()
  set hlsearch
  call CakeHlsShowCursor()
endfunction

function! cake#hls_hide()
  set nohlsearch
  call CakeHlsHideCursor()
endfunction

function! cake#hls_toggle()
  if &hlsearch
    call cake#hls_hide()
  else
    call cake#hls_show()
  endif
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
