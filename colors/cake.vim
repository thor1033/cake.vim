" -----------------------------------------------------------------------------
" File: cake.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/cake-community/cake
" -----------------------------------------------------------------------------

" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='cake'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:cake_bold')
  let g:cake_bold=1
endif
if !exists('g:cake_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:cake_italic=1
  else
    let g:cake_italic=0
  endif
endif
if !exists('g:cake_undercurl')
  let g:cake_undercurl=1
endif
if !exists('g:cake_underline')
  let g:cake_underline=1
endif
if !exists('g:cake_inverse')
  let g:cake_inverse=1
endif

if !exists('g:cake_guisp_fallback') || index(['fg', 'bg'], g:cake_guisp_fallback) == -1
  let g:cake_guisp_fallback='NONE'
endif

if !exists('g:cake_improved_strings')
  let g:cake_improved_strings=0
endif

if !exists('g:cake_improved_warnings')
  let g:cake_improved_warnings=0
endif

if !exists('g:cake_termcolors')
  let g:cake_termcolors=256
endif

if !exists('g:cake_invert_indent_guides')
  let g:cake_invert_indent_guides=0
endif

if exists('g:cake_contrast')
  echo 'g:cake_contrast is deprecated; use g:cake_contrast_light and g:cake_contrast_dark instead'
endif

if !exists('g:cake_contrast_dark')
  let g:cake_contrast_dark='medium'
endif

if !exists('g:cake_contrast_light')
  let g:cake_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette Utility Functions: {{{

function! s:Color(name, default, ...)
  " color already set, validate option
  if has_key(s:gb, a:name)
    let l:color = s:gb[a:name]

    if type(l:color) == type('')
      " gui color only
      let s:gb[a:name] = copy(a:default)
      let s:gb[a:name][0] = l:color
      return 1
    elseif type(l:color) == type(0)
      " terminal color only
      let s:gb[a:name] = copy(a:default)
      let s:gb[a:name][1] = l:color
      return 1
    elseif type(l:color) == type([])
          \ && len(l:color) == 2
          \ && type(l:color[0]) == type('')
          \ && type(l:color[1]) == type(0)
      " gui and terminal color
      return 1
    else
      " invalid value
      echo a:name 'is invalid, usage: let g:cake_colors.color = (["#faf8f6", 255]|"#faf8f6"|255)'
      return 0
    endif

  endif

  " set default option
  let s:gb[a:name] = a:default
  return 1
endfunction

" }}}
" Palette: {{{

" get the global cake palette options, if any
let g:cake_colors = get(g:, 'cake_colors', {})
" initialize the script palette
let s:gb = copy(g:cake_colors)
let g:current_cake_colors = s:gb

" set palette default colors
call s:Color('dark0_hard',  ['#1d1c1a', 234])     " 29-32-33
call s:Color('dark0',       ['#393836', 235])     " 40-40-40
call s:Color('dark0_soft',  ['#555351', 236])     " 50-48-47
call s:Color('dark1',       ['#555351', 237])     " 60-56-54
call s:Color('dark2',       ['#555351', 239])     " 80-73-69
call s:Color('dark3',       ['#716F6D', 241])     " 102-92-84
call s:Color('dark4',       ['#8c8a88', 243])     " 124-111-100
call s:Color('dark4_256',   ['#8c8a88', 243])     " 124-111-100

call s:Color('gray_245',    ['#ccccc4', 245])     " 146-131-116
call s:Color('gray_244',    ['#ccccc4', 244])     " 146-131-116

call s:Color('light0_hard', ['#faf8f6', 230])     " 249-245-215
call s:Color('light0',      ['#faf8f6', 229])     " 253-244-193
call s:Color('light0_soft', ['#dbdbdc', 228])     " 242-229-188
call s:Color('light1',      ['#ccccc4', 223])     " 235-219-178
call s:Color('light2',      ['#c3c1bf', 250])     " 213-196-161
call s:Color('light3',      ['#c3c1bf', 248])     " 189-174-147
call s:Color('light4',      ['#a8a6a4', 246])     " 168-153-132
call s:Color('light4_256',  ['#a8a6a4', 246])     " 168-153-132

call s:Color('bright_red',     ['#f08080', 167])     " 251-73-52
call s:Color('bright_green',   ['#bee5b0', 142])     " 184-187-38
call s:Color('bright_yellow',  ['#f8f1ae', 214])     " 250-189-47
call s:Color('bright_blue',    ['#a4d8d8', 109])     " 131-165-152
call s:Color('bright_purple',  ['#bcafcf', 175])     " 211-134-155
call s:Color('bright_pink',    ['#efb9c0', 108])     " 142-192-124
call s:Color('bright_orange',  ['#f8c57c', 208])     " 254-128-25

call s:Color('neutral_red',    ['#e83d3d', 124])     " 204-36-29
call s:Color('neutral_green',  ['#8bd072', 106])     " 152-151-26
call s:Color('neutral_yellow', ['#f1e361', 172])     " 215-153-33
call s:Color('neutral_blue',   ['#70c2c2', 66])      " 69-133-136
call s:Color('neutral_purple', ['#9480b3', 132])     " 177-98-134
call s:Color('neutral_pink',   ['#df7382', 72])      " 104-157-106
call s:Color('neutral_orange', ['#f4a535', 166])     " 214-93-14

call s:Color('faded_red',      ['#d01818', 88])      " 157-0-6
call s:Color('faded_green',    ['#63c041', 100])     " 121-116-14
call s:Color('faded_yellow',   ['#ecd822', 136])     " 181-118-20
call s:Color('faded_blue',     ['#49abab', 24])      " 7-102-120
call s:Color('faded_purple',   ['#745c99', 96])      " 143-63-113
call s:Color('faded_pink',     ['#d23b4f', 65])      " 66-123-88
call s:Color('faded_orange',   ['#e1880c', 130])     " 175-58-3

call s:Color('none', ['NONE','NONE'])
call s:Color('NONE', ['NONE','NONE'])
call s:Color('None', ['NONE','NONE'])

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:cake_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:cake_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:cake_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:cake_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:cake_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:cake_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:cake_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:pink   = s:gb.bright_pink
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:cake_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:cake_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:pink   = s:gb.faded_pink
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:cake_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:pink[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
call s:Color('bg0', s:bg0)
call s:Color('bg1', s:bg1)
call s:Color('bg2', s:bg2)
call s:Color('bg3', s:bg3)
call s:Color('bg4', s:bg4)

call s:Color('gray', s:gray)

call s:Color('fg0', s:fg0)
call s:Color('fg1', s:fg1)
call s:Color('fg2', s:fg2)
call s:Color('fg3', s:fg3)
call s:Color('fg4', s:fg4)

call s:Color('fg4_256', s:fg4_256)

call s:Color('red',    s:red)
call s:Color('green',  s:green)
call s:Color('yellow', s:yellow)
call s:Color('blue',   s:blue)
call s:Color('purple', s:purple)
call s:Color('pink',   s:pink)
call s:Color('orange', s:orange)

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:gb.bg0[0]
  let g:terminal_color_8 = s:gb.gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:gb.red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:gb.green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:gb.yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:gb.blue[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:gb.purple[0]

  let g:terminal_color_6 = s:gb.neutral_pink[0]
  let g:terminal_color_14 = s:gb.pink[0]

  let g:terminal_color_7 = s:gb.fg4[0]
  let g:terminal_color_15 = s:gb.fg1[0]
endif

" }}}
" Setup Terminal Colors For Vim with termguicolors: {{{

if exists('*term_setansicolors')
  let g:terminal_ansi_colors = repeat([0], 16)

  let g:terminal_ansi_colors[0] = s:gb.bg0[0]
  let g:terminal_ansi_colors[8] = s:gb.gray[0]

  let g:terminal_ansi_colors[1] = s:gb.neutral_red[0]
  let g:terminal_ansi_colors[9] = s:gb.red[0]

  let g:terminal_ansi_colors[2] = s:gb.neutral_green[0]
  let g:terminal_ansi_colors[10] = s:gb.green[0]

  let g:terminal_ansi_colors[3] = s:gb.neutral_yellow[0]
  let g:terminal_ansi_colors[11] = s:gb.yellow[0]

  let g:terminal_ansi_colors[4] = s:gb.neutral_blue[0]
  let g:terminal_ansi_colors[12] = s:gb.blue[0]

  let g:terminal_ansi_colors[5] = s:gb.neutral_purple[0]
  let g:terminal_ansi_colors[13] = s:gb.purple[0]

  let g:terminal_ansi_colors[6] = s:gb.neutral_pink[0]
  let g:terminal_ansi_colors[14] = s:gb.pink[0]

  let g:terminal_ansi_colors[7] = s:gb.fg4[0]
  let g:terminal_ansi_colors[15] = s:gb.fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:gb.orange
if exists('g:cake_hls_cursor')
  let s:hls_cursor = get(s:gb, g:cake_hls_cursor)
endif

let s:hls_highlight = s:gb.yellow
if exists('g:cake_hls_highlight')
  let s:hls_highlight = get(s:gb, g:cake_hls_highlight)
endif

let s:number_column = s:none
if exists('g:cake_number_column')
  let s:number_column = get(s:gb, g:cake_number_column)
endif

let s:sign_column = s:gb.bg1
if exists('g:cake_sign_column')
  let s:sign_column = get(s:gb, g:cake_sign_column)
endif

let s:color_column = s:gb.bg1
if exists('g:cake_color_column')
  let s:color_column = get(s:gb, g:cake_color_column)
endif

let s:vert_split = s:gb.bg0
if exists('g:cake_vert_split')
  let s:vert_split = get(s:gb, g:cake_vert_split)
endif

let s:invert_signs = ''
if exists('g:cake_invert_signs')
  if g:cake_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:cake_invert_selection')
  if g:cake_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:cake_invert_tabline')
  if g:cake_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:tabline_sel = s:gb.green
if exists('g:cake_tabline_sel')
  let s:tabline_sel = get(s:gb, g:cake_tabline_sel)
endif

let s:italicize_comments = s:italic
if exists('g:cake_italicize_comments')
  if g:cake_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:cake_italicize_strings')
  if g:cake_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

let s:italicize_operators = ''
if exists('g:cake_italicize_operators')
  if g:cake_italicize_operators == 1
    let s:italicize_operators = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:cake_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:cake_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Cake Hi Groups: {{{

" memoize common hi groups
call s:HL('CakeFg0', s:gb.fg0)
call s:HL('CakeFg1', s:gb.fg1)
call s:HL('CakeFg2', s:gb.fg2)
call s:HL('CakeFg3', s:gb.fg3)
call s:HL('CakeFg4', s:gb.fg4)
call s:HL('CakeGray', s:gb.gray)
call s:HL('CakeBg0', s:gb.bg0)
call s:HL('CakeBg1', s:gb.bg1)
call s:HL('CakeBg2', s:gb.bg2)
call s:HL('CakeBg3', s:gb.bg3)
call s:HL('CakeBg4', s:gb.bg4)

call s:HL('CakeRed', s:gb.red)
call s:HL('CakeRedBold', s:gb.red, s:none, s:bold)
call s:HL('CakeGreen', s:gb.green)
call s:HL('CakeGreenBold', s:gb.green, s:none, s:bold)
call s:HL('CakeYellow', s:gb.yellow)
call s:HL('CakeYellowBold', s:gb.yellow, s:none, s:bold)
call s:HL('CakeBlue', s:gb.blue)
call s:HL('CakeBlueBold', s:gb.blue, s:none, s:bold)
call s:HL('CakePurple', s:gb.purple)
call s:HL('CakePurpleBold', s:gb.purple, s:none, s:bold)
call s:HL('CakeAqua', s:gb.pink)
call s:HL('CakeAquaBold', s:gb.pink, s:none, s:bold)
call s:HL('CakeOrange', s:gb.orange)
call s:HL('CakeOrangeBold', s:gb.orange, s:none, s:bold)

call s:HL('CakeRedSign', s:gb.red, s:sign_column, s:invert_signs)
call s:HL('CakeGreenSign', s:gb.green, s:sign_column, s:invert_signs)
call s:HL('CakeYellowSign', s:gb.yellow, s:sign_column, s:invert_signs)
call s:HL('CakeBlueSign', s:gb.blue, s:sign_column, s:invert_signs)
call s:HL('CakePurpleSign', s:gb.purple, s:sign_column, s:invert_signs)
call s:HL('CakeAquaSign', s:gb.pink, s:sign_column, s:invert_signs)
call s:HL('CakeOrangeSign', s:gb.orange, s:sign_column, s:invert_signs)

call s:HL('CakeRedUnderline', s:none, s:none, s:undercurl, s:gb.red)
call s:HL('CakeGreenUnderline', s:none, s:none, s:undercurl, s:gb.green)
call s:HL('CakeYellowUnderline', s:none, s:none, s:undercurl, s:gb.yellow)
call s:HL('CakeBlueUnderline', s:none, s:none, s:undercurl, s:gb.blue)
call s:HL('CakePurpleUnderline', s:none, s:none, s:undercurl, s:gb.purple)
call s:HL('CakeAquaUnderline', s:none, s:none, s:undercurl, s:gb.pink)
call s:HL('CakeOrangeUnderline', s:none, s:none, s:undercurl, s:gb.orange)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:gb.fg1, s:gb.bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/cake/issues/7
if exists('v:vim_did_enter')
  let g:cake_vim_did_enter = v:vim_did_enter
else
  augroup CakeVimEnter
    au!
    autocmd VimEnter * let g:cake_vim_did_enter = 1
  augroup End
endif
if get(g:, 'cake_vim_did_enter', 0)
  if s:is_dark
    set background=dark
  else
    set background=light
  endif
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:gb.bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:gb.bg4, s:gb.bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:tabline_sel, s:gb.bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:gb.bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:gb.blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:gb.yellow, s:gb.bg1)
endif

hi! link NonText CakeBg2
hi! link SpecialKey CakeFg4

call s:HL('Visual',    s:none,  s:gb.bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search', s:hls_highlight, s:gb.bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:gb.bg0, s:inverse)

call s:HL('QuickFixLine', s:gb.bg0, s:gb.yellow, s:bold)

call s:HL('Underlined', s:gb.blue, s:none, s:underline)

call s:HL('StatusLine',   s:gb.bg2, s:gb.fg1, s:inverse)
call s:HL('StatusLineNC', s:gb.bg1, s:gb.fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:gb.bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:gb.blue, s:gb.bg2, s:bold)

" Directory names, special names in listing
hi! link Directory CakeGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title CakeGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:gb.bg0, s:gb.red, s:bold)
" More prompt: -- More --
hi! link MoreMsg CakeYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg CakeYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question CakeOrangeBold
" Warning messages
hi! link WarningMsg CakeRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:gb.bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gb.gray, s:gb.bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gb.gray, s:gb.bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:cake_improved_strings == 0
  hi! link Special CakeOrange
else
  call s:HL('Special', s:gb.orange, s:gb.bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gb.gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:none, s:bold . s:italic)
call s:HL('Error', s:gb.red, s:none, s:bold . s:inverse)

" Generic statement
hi! link Statement CakeRed
" if, then, else, endif, switch, etc.
hi! link Conditional CakeRed
" for, do, while, etc.
hi! link Repeat CakeRed
" case, default, etc.
hi! link Label CakeRed
" try, catch, throw
hi! link Exception CakeRed
" sizeof, "+", "*", etc.
call s:HL('Operator',  s:gb.orange, s:none, s:italicize_operators)
" Any other keyword
hi! link Keyword CakeRed

" Variable name
hi! link Identifier CakeBlue
" Function name
hi! link Function CakeGreenBold

" Generic preprocessor
hi! link PreProc CakeAqua
" Preprocessor #include
hi! link Include CakeAqua
" Preprocessor #define
hi! link Define CakeAqua
" Same as Define
hi! link Macro CakeAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit CakeAqua

" Generic constant
hi! link Constant CakePurple
" Character constant: 'c', '/n'
hi! link Character CakePurple
" String constant: "this is a string"
if g:cake_improved_strings == 0
  call s:HL('String',  s:gb.green, s:none, s:italicize_strings)
else
  call s:HL('String',  s:gb.fg1, s:gb.bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean CakePurple
" Number constant: 234, 0xff
hi! link Number CakePurple
" Floating point constant: 2.3e10
hi! link Float CakePurple

" Generic type
hi! link Type CakeYellow
" static, register, volatile, etc
hi! link StorageClass CakeOrange
" struct, union, enum, etc.
hi! link Structure CakeAqua
" typedef
hi! link Typedef CakeYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:gb.fg1, s:gb.bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:gb.bg2, s:gb.blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:gb.bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:gb.bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:gb.red, s:gb.bg0, s:inverse)
call s:HL('DiffAdd',    s:gb.green, s:gb.bg0, s:inverse)
"call s:HL('DiffChange', s:gb.bg0, s:gb.blue)
"call s:HL('DiffText',   s:gb.bg0, s:gb.yellow)

" Alternative setting
call s:HL('DiffChange', s:gb.pink, s:gb.bg0, s:inverse)
call s:HL('DiffText',   s:gb.yellow, s:gb.bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:cake_improved_warnings == 0
    hi! link SpellCap CakeBlueUnderline
  else
    call s:HL('SpellCap',   s:gb.green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  hi! link SpellBad CakeRedUnderline
  " Wrong spelling for selected region
  hi! link SpellLocal CakeAquaUnderline
  " Rare word
  hi! link SpellRare CakePurpleUnderline
endif

" }}}
" LSP: {{{

hi! link DiagnosticError CakeRed
hi! link DiagnosticSignError CakeRedSign
hi! link DiagnosticUnderlineError CakeRedUnderline

hi! link DiagnosticWarn CakeYellow
hi! link DiagnosticSignWarn CakeYellowSign
hi! link DiagnosticUnderlineWarn CakeYellowUnderline

hi! link DiagnosticInfo CakeBlue
hi! link DiagnosticSignInfo CakeBlueSign
hi! link DiagnosticUnderlineInfo CakeBlueUnderline

hi! link DiagnosticHint CakeAqua
hi! link DiagnosticSignHint CakeAquaSign
hi! link DiagnosticUnderlineHint CakeAquaUnderline

hi! link LspReferenceText CakeYellowBold
hi! link LspReferenceRead CakeYellowBold
hi! link LspReferenceWrite CakeOrangeBold

hi! link LspCodeLens CakeGray

" Backward Compatibilty prior to (https://github.com/neovim/neovim/pull/15585)
hi! link LspDiagnosticsDefaultError CakeRed
hi! link LspDiagnosticsSignError CakeRedSign
hi! link LspDiagnosticsUnderlineError CakeRedUnderline

hi! link LspDiagnosticsDefaultWarning CakeYellow
hi! link LspDiagnosticsSignWarning CakeYellowSign
hi! link LspDiagnosticsUnderlineWarning CakeYellowUnderline

hi! link LspDiagnosticsDefaultInformation CakeBlue
hi! link LspDiagnosticsSignInformation CakeBlueSign
hi! link LspDiagnosticsUnderlineInformation CakeBlueUnderline

hi! link LspDiagnosticsDefaultHint CakeAqua
hi! link LspDiagnosticsSignHint CakeAquaSign
hi! link LspDiagnosticsUnderlineHint CakeAquaUnderline

" }}}

" Treesitter: {{{
hi! link TSKeywordOperator CakeRed

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget CakeRedBold
hi! link EasyMotionTarget2First CakeYellowBold
hi! link EasyMotionTarget2Second CakeOrangeBold
hi! link EasyMotionShade CakeGray

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:cake_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:gb.bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:gb.bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:gb.bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:gb.bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:gb.bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:gb.bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#70c2c2'], ['magenta', '#9480b3'],
      \ ['red',  '#e83d3d'], ['166',     '#f4a535']
    \ ]
endif

let g:rainbow_guifgs = [ '#f4a535', '#e83d3d', '#9480b3', '#70c2c2' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd CakeGreenSign
hi! link GitGutterChange CakeAquaSign
hi! link GitGutterDelete CakeRedSign
hi! link GitGutterChangeDelete CakeAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile CakeGreen
hi! link gitcommitDiscardedFile CakeRed

" }}}
" Signify: {{{

hi! link SignifySignAdd CakeGreenSign
hi! link SignifySignChange CakeAquaSign
hi! link SignifySignDelete CakeRedSign

" }}}
" gitsigns.nvim {{{
hi! link GitSignsAdd CakeGreenSign
hi! link GitSignsChange CakeAquaSign
hi! link GitSignsDelete CakeRedSign
" }}}
" Syntastic: {{{

hi! link SyntasticError CakeRedUnderline
hi! link SyntasticWarning CakeYellowUnderline

hi! link SyntasticErrorSign CakeRedSign
hi! link SyntasticWarningSign CakeYellowSign

" }}}
" Termdebug: {{{

call s:HL('debugPC', s:none, s:gb.faded_blue)
hi! link debugBreakpoint CakeRedSign

" }}}

" Signature: {{{
hi! link SignatureMarkText   CakeBlueSign
hi! link SignatureMarkerText CakePurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl CakeBlueSign
hi! link ShowMarksHLu CakeBlueSign
hi! link ShowMarksHLo CakeBlueSign
hi! link ShowMarksHLm CakeBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch CakeYellow
hi! link CtrlPNoEntries CakeRed
hi! link CtrlPPrtBase CakeBg2
hi! link CtrlPPrtCursor CakeBlue
hi! link CtrlPLinePre CakeBg2

call s:HL('CtrlPMode1', s:gb.blue, s:gb.bg2, s:bold)
call s:HL('CtrlPMode2', s:gb.bg0, s:gb.blue, s:bold)
call s:HL('CtrlPStats', s:gb.fg4, s:gb.bg2, s:bold)

" }}}
" FZF: {{{

let g:fzf_colors = {
      \ 'fg':      ['fg', 'CakeFg1'],
      \ 'bg':      ['fg', 'CakeBg0'],
      \ 'hl':      ['fg', 'CakeYellow'],
      \ 'fg+':     ['fg', 'CakeFg1'],
      \ 'bg+':     ['fg', 'CakeBg1'],
      \ 'hl+':     ['fg', 'CakeYellow'],
      \ 'info':    ['fg', 'CakeBlue'],
      \ 'prompt':  ['fg', 'CakeFg4'],
      \ 'pointer': ['fg', 'CakeBlue'],
      \ 'marker':  ['fg', 'CakeOrange'],
      \ 'spinner': ['fg', 'CakeYellow'],
      \ 'header':  ['fg', 'CakeBg3']
      \ }

call s:HL('Fzf1', s:gb.blue, s:gb.bg1)
call s:HL('Fzf2', s:gb.orange, s:gb.bg1)
call s:HL('Fzf3', s:gb.fg4, s:gb.bg1)

" }}}
" Startify: {{{

hi! link StartifyBracket CakeFg3
hi! link StartifyFile CakeFg1
hi! link StartifyNumber CakeBlue
hi! link StartifyPath CakeGray
hi! link StartifySlash CakeGray
hi! link StartifySection CakeYellow
hi! link StartifySpecial CakeBg2
hi! link StartifyHeader CakeOrange
hi! link StartifyFooter CakeBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:gb.bg4[0], s:gb.red[0], s:gb.green[0], s:gb.yellow[0],
  \ s:gb.blue[0], s:gb.purple[0], s:gb.pink[0], s:gb.fg4[0],
  \ s:gb.bg0[0], s:gb.red[0], s:gb.green[0], s:gb.orange[0],
  \ s:gb.blue[0], s:gb.purple[0], s:gb.pink[0], s:gb.fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:gb.bg0, s:gb.fg4)
call s:HL('BufTabLineActive', s:gb.fg4, s:gb.bg2)
call s:HL('BufTabLineHidden', s:gb.bg4, s:gb.bg1)
call s:HL('BufTabLineFill', s:gb.bg0, s:gb.bg0)

" }}}
" Asynchronous Lint Engine: {{{

hi! link ALEError CakeRedUnderline
hi! link ALEWarning CakeYellowUnderline
hi! link ALEInfo CakeBlueUnderline

hi! link ALEErrorSign CakeRedSign
hi! link ALEWarningSign CakeYellowSign
hi! link ALEInfoSign CakeBlueSign

hi! link ALEVirtualTextError CakeRed
hi! link ALEVirtualTextWarning CakeYellow
hi! link ALEVirtualTextInfo CakeBlue

" }}}
" Dirvish: {{{

hi! link DirvishPathTail CakeAqua
hi! link DirvishArg CakeYellow

" }}}
" Netrw: {{{

hi! link netrwDir CakeAqua
hi! link netrwClassify CakeAqua
hi! link netrwLink CakeGray
hi! link netrwSymLink CakeFg1
hi! link netrwExe CakeYellow
hi! link netrwComment CakeGray
hi! link netrwList CakeBlue
hi! link netrwHelpCmd CakeAqua
hi! link netrwCmdSep CakeFg3
hi! link netrwVersion CakeGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir CakeAqua
hi! link NERDTreeDirSlash CakeAqua

hi! link NERDTreeOpenable CakeOrange
hi! link NERDTreeClosable CakeOrange

hi! link NERDTreeFile CakeFg1
hi! link NERDTreeExecFile CakeYellow

hi! link NERDTreeUp CakeGray
hi! link NERDTreeCWD CakeGreen
hi! link NERDTreeHelp CakeFg1

hi! link NERDTreeToggleOn CakeGreen
hi! link NERDTreeToggleOff CakeRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:gb.bg2)

" }}}
" coc.nvim: {{{

hi! link CocErrorSign CakeRedSign
hi! link CocWarningSign CakeOrangeSign
hi! link CocInfoSign CakeBlueSign
hi! link CocHintSign CakeAquaSign
hi! link CocErrorFloat CakeRed
hi! link CocWarningFloat CakeOrange
hi! link CocInfoFloat CakeBlue
hi! link CocHintFloat CakeAqua
hi! link CocDiagnosticsError CakeRed
hi! link CocDiagnosticsWarning CakeOrange
hi! link CocDiagnosticsInfo CakeBlue
hi! link CocDiagnosticsHint CakeAqua

hi! link CocSelectedText CakeRed
hi! link CocCodeLens CakeGray

hi! link CocErrorHighlight CakeRedUnderline
hi! link CocWarningHighlight CakeOrangeUnderline
hi! link CocInfoHighlight CakeBlueUnderline
hi! link CocHintHighlight CakeAquaUnderline

" }}}
" Telescope.nvim: {{{
hi! link TelescopeNormal CakeFg1
hi! link TelescopeSelection CakeOrangeBold
hi! link TelescopeSlectionCaret CakeRed
hi! link TelescopeMultiSelection CakeGray
hi! link TelescopeBorder TelescopeNormal
hi! link TelescopePromptBorder TelescopeNormal
hi! link TelescopeResultsBorder TelescopeNormal
hi! link TelescopePreviewBorder TelescopeNormal
hi! link TelescopeMatching CakeBlue
hi! link TelescopePromptPrefix CakeRed
hi! link TelescopePrompt TelescopeNormal

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded CakeGreen
hi! link diffRemoved CakeRed
hi! link diffChanged CakeAqua

hi! link diffFile CakeOrange
hi! link diffNewFile CakeYellow

hi! link diffLine CakeBlue

" }}}
" Html: {{{

hi! link htmlTag CakeAquaBold
hi! link htmlEndTag CakeAquaBold

hi! link htmlTagName CakeBlue
hi! link htmlArg CakeOrange

hi! link htmlTagN CakeFg1
hi! link htmlSpecialTagName CakeBlue

call s:HL('htmlLink', s:gb.fg4, s:none, s:underline)

hi! link htmlSpecialChar CakeRed

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag CakeAquaBold
hi! link xmlEndTag CakeAquaBold
hi! link xmlTagName CakeBlue
hi! link xmlEqual CakeBlue
hi! link docbkKeyword CakeAquaBold

hi! link xmlDocTypeDecl CakeGray
hi! link xmlDocTypeKeyword CakePurple
hi! link xmlCdataStart CakeGray
hi! link xmlCdataCdata CakePurple
hi! link dtdFunction CakeGray
hi! link dtdTagName CakePurple

hi! link xmlAttrib CakeOrange
hi! link xmlProcessingDelim CakeGray
hi! link dtdParamEntityPunct CakeGray
hi! link dtdParamEntityDPunct CakeGray
hi! link xmlAttribPunct CakeGray

hi! link xmlEntity CakeRed
hi! link xmlEntityPunct CakeRed
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:gb.fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation CakeOrange
hi! link vimBracket CakeOrange
hi! link vimMapModKey CakeOrange
hi! link vimFuncSID CakeFg3
hi! link vimSetSep CakeFg3
hi! link vimSep CakeFg3
hi! link vimContinue CakeFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword CakeBlue
hi! link clojureCond CakeOrange
hi! link clojureSpecial CakeOrange
hi! link clojureDefine CakeOrange

hi! link clojureFunc CakeYellow
hi! link clojureRepeat CakeYellow
hi! link clojureCharacter CakeAqua
hi! link clojureStringEscape CakeAqua
hi! link clojureException CakeRed

hi! link clojureRegexp CakeAqua
hi! link clojureRegexpEscape CakeAqua
call s:HL('clojureRegexpCharClass', s:gb.fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen CakeFg3
hi! link clojureAnonArg CakeYellow
hi! link clojureVariable CakeBlue
hi! link clojureMacro CakeOrange

hi! link clojureMeta CakeYellow
hi! link clojureDeref CakeYellow
hi! link clojureQuote CakeYellow
hi! link clojureUnquote CakeYellow

" }}}
" C: {{{

hi! link cOperator CakePurple
hi! link cppOperator CakePurple
hi! link cStructure CakeOrange

" }}}
" Python: {{{

hi! link pythonBuiltin CakeOrange
hi! link pythonBuiltinObj CakeOrange
hi! link pythonBuiltinFunc CakeOrange
hi! link pythonFunction CakeAqua
hi! link pythonDecorator CakeRed
hi! link pythonInclude CakeBlue
hi! link pythonImport CakeBlue
hi! link pythonRun CakeBlue
hi! link pythonCoding CakeBlue
hi! link pythonOperator CakeRed
hi! link pythonException CakeRed
hi! link pythonExceptions CakePurple
hi! link pythonBoolean CakePurple
hi! link pythonDot CakeFg3
hi! link pythonConditional CakeRed
hi! link pythonRepeat CakeRed
hi! link pythonDottedName CakeGreenBold

" }}}
" CSS: {{{

hi! link cssBraces CakeBlue
hi! link cssFunctionName CakeYellow
hi! link cssIdentifier CakeOrange
hi! link cssClassName CakeGreen
hi! link cssColor CakeBlue
hi! link cssSelectorOp CakeBlue
hi! link cssSelectorOp2 CakeBlue
hi! link cssImportant CakeGreen
hi! link cssVendor CakeFg1

hi! link cssTextProp CakeAqua
hi! link cssAnimationProp CakeAqua
hi! link cssUIProp CakeYellow
hi! link cssTransformProp CakeAqua
hi! link cssTransitionProp CakeAqua
hi! link cssPrintProp CakeAqua
hi! link cssPositioningProp CakeYellow
hi! link cssBoxProp CakeAqua
hi! link cssFontDescriptorProp CakeAqua
hi! link cssFlexibleBoxProp CakeAqua
hi! link cssBorderOutlineProp CakeAqua
hi! link cssBackgroundProp CakeAqua
hi! link cssMarginProp CakeAqua
hi! link cssListProp CakeAqua
hi! link cssTableProp CakeAqua
hi! link cssFontProp CakeAqua
hi! link cssPaddingProp CakeAqua
hi! link cssDimensionProp CakeAqua
hi! link cssRenderProp CakeAqua
hi! link cssColorProp CakeAqua
hi! link cssGeneratedContentProp CakeAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces CakeFg1
hi! link javaScriptFunction CakeAqua
hi! link javaScriptIdentifier CakeRed
hi! link javaScriptMember CakeBlue
hi! link javaScriptNumber CakePurple
hi! link javaScriptNull CakePurple
hi! link javaScriptParens CakeFg3

" }}}
" YAJS: {{{

hi! link javascriptImport CakeAqua
hi! link javascriptExport CakeAqua
hi! link javascriptClassKeyword CakeAqua
hi! link javascriptClassExtends CakeAqua
hi! link javascriptDefault CakeAqua

hi! link javascriptClassName CakeYellow
hi! link javascriptClassSuperName CakeYellow
hi! link javascriptGlobal CakeYellow

hi! link javascriptEndColons CakeFg1
hi! link javascriptFuncArg CakeFg1
hi! link javascriptGlobalMethod CakeFg1
hi! link javascriptNodeGlobal CakeFg1
hi! link javascriptBOMWindowProp CakeFg1
hi! link javascriptArrayMethod CakeFg1
hi! link javascriptArrayStaticMethod CakeFg1
hi! link javascriptCacheMethod CakeFg1
hi! link javascriptDateMethod CakeFg1
hi! link javascriptMathStaticMethod CakeFg1

" hi! link javascriptProp CakeFg1
hi! link javascriptURLUtilsProp CakeFg1
hi! link javascriptBOMNavigatorProp CakeFg1
hi! link javascriptDOMDocMethod CakeFg1
hi! link javascriptDOMDocProp CakeFg1
hi! link javascriptBOMLocationMethod CakeFg1
hi! link javascriptBOMWindowMethod CakeFg1
hi! link javascriptStringMethod CakeFg1

hi! link javascriptVariable CakeOrange
" hi! link javascriptVariable CakeRed
" hi! link javascriptIdentifier CakeOrange
" hi! link javascriptClassSuper CakeOrange
hi! link javascriptIdentifier CakeOrange
hi! link javascriptClassSuper CakeOrange

" hi! link javascriptFuncKeyword CakeOrange
" hi! link javascriptAsyncFunc CakeOrange
hi! link javascriptFuncKeyword CakeAqua
hi! link javascriptAsyncFunc CakeAqua
hi! link javascriptClassStatic CakeOrange

hi! link javascriptOperator CakeRed
hi! link javascriptForOperator CakeRed
hi! link javascriptYield CakeRed
hi! link javascriptExceptions CakeRed
hi! link javascriptMessage CakeRed

hi! link javascriptTemplateSB CakeAqua
hi! link javascriptTemplateSubstitution CakeFg1

" hi! link javascriptLabel CakeBlue
" hi! link javascriptObjectLabel CakeBlue
" hi! link javascriptPropertyName CakeBlue
hi! link javascriptLabel CakeFg1
hi! link javascriptObjectLabel CakeFg1
hi! link javascriptPropertyName CakeFg1

hi! link javascriptLogicSymbols CakeFg1
hi! link javascriptArrowFunc CakeYellow

hi! link javascriptDocParamName CakeFg4
hi! link javascriptDocTags CakeFg4
hi! link javascriptDocNotation CakeFg4
hi! link javascriptDocParamType CakeFg4
hi! link javascriptDocNamedParamType CakeFg4

hi! link javascriptBrackets CakeFg1
hi! link javascriptDOMElemAttrs CakeFg1
hi! link javascriptDOMEventMethod CakeFg1
hi! link javascriptDOMNodeMethod CakeFg1
hi! link javascriptDOMStorageMethod CakeFg1
hi! link javascriptHeadersMethod CakeFg1

hi! link javascriptAsyncFuncKeyword CakeRed
hi! link javascriptAwaitFuncKeyword CakeRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword CakeAqua
hi! link jsExtendsKeyword CakeAqua
hi! link jsExportDefault CakeAqua
hi! link jsTemplateBraces CakeAqua
hi! link jsGlobalNodeObjects CakeBlue
hi! link jsGlobalObjects CakeBlue
hi! link jsObjectKey CakeGreenBold
hi! link jsFunction CakeAqua
hi! link jsFuncCall CakeBlue
hi! link jsFuncParens CakeFg3
hi! link jsParens CakeFg3
hi! link jsNull CakePurple
hi! link jsUndefined CakePurple
hi! link jsClassDefinition CakeYellow
hi! link jsOperatorKeyword CakeRed

" }}}
" TypeScript: {{{

hi! link typescriptReserved CakeAqua
hi! link typescriptLabel CakeAqua
hi! link typescriptFuncKeyword CakeAqua
hi! link typescriptIdentifier CakeOrange
hi! link typescriptBraces CakeFg1
hi! link typescriptEndColons CakeFg1
hi! link typescriptDOMObjects CakeFg1
hi! link typescriptAjaxMethods CakeFg1
hi! link typescriptLogicSymbols CakeFg1
hi! link typescriptDocSeeTag Comment
hi! link typescriptDocParam Comment
hi! link typescriptDocTags vimCommentTitle
hi! link typescriptGlobalObjects CakeFg1
hi! link typescriptParens CakeFg3
hi! link typescriptOpSymbols CakeFg3
hi! link typescriptHtmlElemProperties CakeFg1
hi! link typescriptNull CakePurple
hi! link typescriptInterpolationDelimiter CakeAqua

" }}}
" JSX: maxmellon/vim-jsx-pretty: {{{

hi! link jsxTagName CakeAqua
hi! link jsxComponentName CakeGreen
hi! link jsxCloseString CakeFg4
hi! link jsxAttrib CakeYellow
hi! link jsxEqual CakeAqua

"}}}
" PureScript: {{{

hi! link purescriptModuleKeyword CakeAqua
hi! link purescriptModuleName CakeFg1
hi! link purescriptWhere CakeAqua
hi! link purescriptDelimiter CakeFg4
hi! link purescriptType CakeFg1
hi! link purescriptImportKeyword CakeAqua
hi! link purescriptHidingKeyword CakeAqua
hi! link purescriptAsKeyword CakeAqua
hi! link purescriptStructure CakeAqua
hi! link purescriptOperator CakeBlue

hi! link purescriptTypeVar CakeFg1
hi! link purescriptConstructor CakeFg1
hi! link purescriptFunction CakeFg1
hi! link purescriptConditional CakeOrange
hi! link purescriptBacktick CakeOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp CakeFg3
hi! link coffeeSpecialOp CakeFg3
hi! link coffeeCurly CakeOrange
hi! link coffeeParen CakeFg3
hi! link coffeeBracket CakeOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter CakeGreen
hi! link rubyInterpolationDelimiter CakeAqua
hi! link rubyDefinedOperator rubyKeyword

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier CakeRed
hi! link objcDirective CakeBlue

" }}}
" Go: {{{

hi! link goDirective CakeAqua
hi! link goConstants CakePurple
hi! link goDeclaration CakeRed
hi! link goDeclType CakeBlue
hi! link goBuiltins CakeOrange

" }}}
" Lua: {{{

hi! link luaIn CakeRed
hi! link luaFunction CakeAqua
hi! link luaTable CakeOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp CakeFg3
hi! link moonExtendedOp CakeFg3
hi! link moonFunction CakeFg3
hi! link moonObject CakeYellow

" }}}
" Java: {{{

hi! link javaAnnotation CakeBlue
hi! link javaDocTags CakeAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen CakeFg3
hi! link javaParen1 CakeFg3
hi! link javaParen2 CakeFg3
hi! link javaParen3 CakeFg3
hi! link javaParen4 CakeFg3
hi! link javaParen5 CakeFg3
hi! link javaOperator CakeOrange

hi! link javaVarArg CakeGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter CakeGreen
hi! link elixirInterpolationDelimiter CakeAqua

hi! link elixirModuleDeclaration CakeYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition CakeFg1
hi! link scalaCaseFollowing CakeFg1
hi! link scalaCapitalWord CakeFg1
hi! link scalaTypeExtension CakeFg1

hi! link scalaKeyword CakeRed
hi! link scalaKeywordModifier CakeRed

hi! link scalaSpecial CakeAqua
hi! link scalaOperator CakeFg1

hi! link scalaTypeDeclaration CakeYellow
hi! link scalaTypeTypePostDeclaration CakeYellow

hi! link scalaInstanceDeclaration CakeFg1
hi! link scalaInterpolation CakeAqua

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)
call s:HL('markdownBold', s:fg3, s:none, s:bold)
call s:HL('markdownBoldItalic', s:fg3, s:none, s:bold . s:italic)

hi! link markdownH1 CakeGreenBold
hi! link markdownH2 CakeGreenBold
hi! link markdownH3 CakeYellowBold
hi! link markdownH4 CakeYellowBold
hi! link markdownH5 CakeYellow
hi! link markdownH6 CakeYellow

hi! link markdownCode CakeAqua
hi! link markdownCodeBlock CakeAqua
hi! link markdownCodeDelimiter CakeAqua

hi! link markdownBlockquote CakeGray
hi! link markdownListMarker CakeGray
hi! link markdownOrderedListMarker CakeGray
hi! link markdownRule CakeGray
hi! link markdownHeadingRule CakeGray

hi! link markdownUrlDelimiter CakeFg3
hi! link markdownLinkDelimiter CakeFg3
hi! link markdownLinkTextDelimiter CakeFg3

hi! link markdownHeadingDelimiter CakeOrange
hi! link markdownUrl CakePurple
hi! link markdownUrlTitleDelimiter CakeGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

hi! link haskellType CakeBlue
hi! link haskellIdentifier CakeAqua
hi! link haskellSeparator CakeFg4
hi! link haskellDelimiter CakeOrange
hi! link haskellOperators CakePurple

hi! link haskellBacktick CakeOrange
hi! link haskellStatement CakePurple
hi! link haskellConditional CakePurple

hi! link haskellLet CakeRed
hi! link haskellDefault CakeRed
hi! link haskellWhere CakeRed
hi! link haskellBottom CakeRedBold
hi! link haskellImportKeywords CakePurpleBold
hi! link haskellDeclKeyword CakeOrange
hi! link haskellDecl CakeOrange
hi! link haskellDeriving CakePurple
hi! link haskellAssocType CakeAqua

hi! link haskellNumber CakeAqua
hi! link haskellPragma CakeRedBold

hi! link haskellTH CakeAquaBold
hi! link haskellForeignKeywords CakeGreen
hi! link haskellKeyword CakeRed
hi! link haskellFloat CakeAqua
hi! link haskellInfix CakePurple
hi! link haskellQuote CakeGreenBold
hi! link haskellShebang CakeYellowBold
hi! link haskellLiquid CakePurpleBold
hi! link haskellQuasiQuoted CakeBlueBold
hi! link haskellRecursiveDo CakePurple
hi! link haskellQuotedType CakeRed
hi! link haskellPreProc CakeFg4
hi! link haskellTypeRoles CakeRedBold
hi! link haskellTypeForall CakeRed
hi! link haskellPatternKeyword CakeBlue

" }}}
" Json: {{{

hi! link jsonKeyword CakeGreen
hi! link jsonQuote CakeGreen
hi! link jsonBraces CakeFg1
hi! link jsonString CakeFg1

" }}}
" Mail: {{{

" Override some defaults defined by mail.vim
" mail quoted text
hi! link mailQuoted1 GruvBoxAqua
hi! link mailQuoted2 GruvBoxPurple
hi! link mailQuoted3 GruvBoxYellow
hi! link mailQuoted4 GruvBoxGreen
hi! link mailQuoted5 GruvBoxRed
hi! link mailQuoted6 GruvBoxOrange

hi! link mailSignature Comment

" }}}
" C#: {{{

hi! link csBraces CakeFg1
hi! link csEndColon CakeFg1
hi! link csLogicSymbols CakeFg1
hi! link csParens CakeFg3
hi! link csOpSymbols CakeFg3
hi! link csInterpolationDelimiter CakeFg3
hi! link csInterpolationAlignDel CakeAquaBold
hi! link csInterpolationFormat CakeAqua
hi! link csInterpolationFormatDel CakeAquaBold

" }}}
" Rust: {{{

hi! link rustSigil CakeOrange
hi! link rustEscape CakeAqua
hi! link rustStringContinuation CakeAqua
hi! link rustEnum CakeAqua
hi! link rustStructure CakeAqua
hi! link rustModPathSep CakeFg2
hi! link rustCommentLineDoc Comment
hi! link rustDefault CakeAqua

" }}}
" Ocaml: {{{

hi! link ocamlOperator CakeFg1
hi! link ocamlKeyChar CakeOrange
hi! link ocamlArrow CakeOrange
hi! link ocamlInfixOpKeyword CakeRed
hi! link ocamlConstructor CakeOrange

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! CakeHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! CakeHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
