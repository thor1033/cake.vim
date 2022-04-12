scriptencoding utf8

if v:version > 580
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'cake'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

let s:fg        = g:cake#palette.fg

let s:bglighter = g:cake#palette.bglighter
let s:bglight   = g:cake#palette.bglight
let s:bg        = g:cake#palette.bg
let s:bgdark    = g:cake#palette.bgdark
let s:bgdarker  = g:cake#palette.bgdarker

let s:comment   = g:cake#palette.comment
let s:selection = g:cake#palette.selection
let s:subtle    = g:cake#palette.subtle

let s:cyan      = g:cake#palette.cyan
let s:green     = g:cake#palette.green
let s:orange    = g:cake#palette.orange
let s:pink      = g:cake#palette.pink
let s:purple    = g:cake#palette.purple
let s:red       = g:cake#palette.red
let s:yellow    = g:cake#palette.yellow

let s:none      = ['NONE', 'NONE']

if has('nvim')
  for s:i in range(16)
    let g:terminal_color_{s:i} = g:cake#palette['color_' . s:i]
  endfor
endif

if has('terminal')
  let g:terminal_ansi_colors = []
  for s:i in range(16)
    call add(g:terminal_ansi_colors, g:cake#palette['color_' . s:i])
  endfor
endif

if !exists('g:cake_bold')
  let g:cake_bold = 1
endif

if !exists('g:cake_italic')
  let g:cake_italic = 1
endif

if !exists('g:cake_underline')
  let g:cake_underline = 1
endif

if !exists('g:cake_undercurl')
  let g:cake_undercurl = g:cake_underline
endif

if !exists('g:cake_full_special_attrs_support')
  let g:cake_full_special_attrs_support = has('gui_running')
endif

if !exists('g:cake_inverse')
  let g:cake_inverse = 1
endif

if !exists('g:cake_colorterm')
  let g:cake_colorterm = 1
endif

let s:attrs = {
      \ 'bold': g:cake_bold == 1 ? 'bold' : 0,
      \ 'italic': g:cake_italic == 1 ? 'italic' : 0,
      \ 'underline': g:cake_underline == 1 ? 'underline' : 0,
      \ 'undercurl': g:cake_undercurl == 1 ? 'undercurl' : 0,
      \ 'inverse': g:cake_inverse == 1 ? 'inverse' : 0,
      \}

function! s:h(scope, fg, ...) " bg, attr_list, special
  let l:fg = copy(a:fg)
  let l:bg = get(a:, 1, ['NONE', 'NONE'])

  let l:attr_list = filter(get(a:, 2, ['NONE']), 'type(v:val) == 1')
  let l:attrs = len(l:attr_list) > 0 ? join(l:attr_list, ',') : 'NONE'

  let l:special = get(a:, 3, ['NONE', 'NONE'])
  if l:special[0] !=# 'NONE' && l:fg[0] ==# 'NONE' && !g:cake_full_special_attrs_support
    let l:fg[0] = l:special[0]
    let l:fg[1] = l:special[1]
  endif

  let l:hl_string = [
        \ 'highlight', a:scope,
        \ 'guifg=' . l:fg[0], 'ctermfg=' . l:fg[1],
        \ 'guibg=' . l:bg[0], 'ctermbg=' . l:bg[1],
        \ 'gui=' . l:attrs, 'cterm=' . l:attrs,
        \ 'guisp=' . l:special[0],
        \]

  execute join(l:hl_string, ' ')
endfunction


call s:h('CakeBgLight', s:none, s:bglight)
call s:h('CakeBgLighter', s:none, s:bglighter)
call s:h('CakeBgDark', s:none, s:bgdark)
call s:h('CakeBgDarker', s:none, s:bgdarker)

call s:h('CakeFg', s:fg)
call s:h('CakeFgUnderline', s:fg, s:none, [s:attrs.underline])
call s:h('CakeFgBold', s:fg, s:none, [s:attrs.bold])

call s:h('CakeComment', s:comment)
call s:h('CakeCommentBold', s:comment, s:none, [s:attrs.bold])

call s:h('CakeSelection', s:none, s:selection)

call s:h('CakeSubtle', s:subtle)

call s:h('CakeCyan', s:cyan)
call s:h('CakeCyanItalic', s:cyan, s:none, [s:attrs.italic])

call s:h('CakeGreen', s:green)
call s:h('CakeGreenBold', s:green, s:none, [s:attrs.bold])
call s:h('CakeGreenItalic', s:green, s:none, [s:attrs.italic])
call s:h('CakeGreenItalicUnderline', s:green, s:none, [s:attrs.italic, s:attrs.underline])

call s:h('CakeOrange', s:orange)
call s:h('CakeOrangeBold', s:orange, s:none, [s:attrs.bold])
call s:h('CakeOrangeItalic', s:orange, s:none, [s:attrs.italic])
call s:h('CakeOrangeBoldItalic', s:orange, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('CakeOrangeInverse', s:bg, s:orange)

call s:h('CakePink', s:pink)
call s:h('CakePinkItalic', s:pink, s:none, [s:attrs.italic])

call s:h('CakePurple', s:purple)
call s:h('CakePurpleBold', s:purple, s:none, [s:attrs.bold])
call s:h('CakePurpleItalic', s:purple, s:none, [s:attrs.italic])
call s:h('CakePurpleInverse', s:bg, s:purple)

call s:h('CakeRed', s:red)
call s:h('CakeRedInverse', s:fg, s:red)

call s:h('CakeYellow', s:yellow)
call s:h('CakeYellowItalic', s:yellow, s:none, [s:attrs.italic])

call s:h('CakeError', s:red, s:none, [], s:red)

call s:h('CakeErrorLine', s:none, s:none, [s:attrs.undercurl], s:red)
call s:h('CakeWarnLine', s:none, s:none, [s:attrs.undercurl], s:orange)
call s:h('CakeInfoLine', s:none, s:none, [s:attrs.undercurl], s:cyan)

call s:h('CakeTodo', s:cyan, s:none, [s:attrs.bold, s:attrs.inverse])
call s:h('CakeSearch', s:green, s:none, [s:attrs.inverse])
call s:h('CakeBoundary', s:comment, s:bgdark)
call s:h('CakeLink', s:cyan, s:none, [s:attrs.underline])

call s:h('CakeDiffChange', s:orange, s:none)
call s:h('CakeDiffText', s:bg, s:orange)
call s:h('CakeDiffDelete', s:red, s:bgdark)


set background=dark

call s:h('Normal', s:fg, g:cake_colorterm || has('gui_running') ? s:bg : s:none )
call s:h('StatusLine', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineNC', s:none, s:bglight)
call s:h('StatusLineTerm', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineTermNC', s:none, s:bglight)
call s:h('WildMenu', s:bg, s:purple, [s:attrs.bold])
call s:h('CursorLine', s:none, s:subtle)

hi! link ColorColumn  CakeBgDark
hi! link CursorColumn CursorLine
hi! link CursorLineNr CakeYellow
hi! link DiffAdd      CakeGreen
hi! link DiffAdded    DiffAdd
hi! link DiffChange   CakeDiffChange
hi! link DiffDelete   CakeDiffDelete
hi! link DiffRemoved  DiffDelete
hi! link DiffText     CakeDiffText
hi! link Directory    CakePurpleBold
hi! link ErrorMsg     CakeRedInverse
hi! link FoldColumn   CakeSubtle
hi! link Folded       CakeBoundary
hi! link IncSearch    CakePurpleInverse
call s:h('LineNr', s:comment)
hi! link MoreMsg      CakeFgBold
hi! link NonText      CakeSubtle
hi! link Pmenu        CakeBgDark
hi! link PmenuSbar    CakeBgDark
hi! link PmenuSel     CakeSelection
hi! link PmenuThumb   CakeSelection
hi! link Question     CakeFgBold
hi! link Search       CakeSearch
call s:h('SignColumn', s:comment)
call s:h('Cursor' ,s:purple)
hi! link TabLine      CakeBoundary
hi! link TabLineFill  CakeBgDark
hi! link TabLineSel   Normal
hi! link Title        CakeGreenBold
hi! link VertSplit    CakeBoundary
hi! link Visual       CakeSelection
hi! link VisualNOS    Visual
hi! link WarningMsg   CakeOrangeInverse

call s:h('MatchParen', s:green, s:none, [s:attrs.underline])
call s:h('Conceal', s:cyan, s:none)

if has('nvim')
  hi! link SpecialKey CakeRed
  hi! link LspReferenceText CakeSelection
  hi! link LspReferenceRead CakeSelection
  hi! link LspReferenceWrite CakeSelection
  hi! link LspDiagnosticsDefaultInformation DiagnosticInfo
  hi! link LspDiagnosticsDefaultHint DiagnosticHint
  hi! link LspDiagnosticsDefaultError DiagnosticError
  hi! link LspDiagnosticsDefaultWarning DiagnosticWarn
  hi! link LspDiagnosticsUnderlineError DiagnosticUnderlineError
  hi! link LspDiagnosticsUnderlineHint DiagnosticUnderlineHint
  hi! link LspDiagnosticsUnderlineInformation DiagnosticUnderlineInfo
  hi! link LspDiagnosticsUnderlineWarning DiagnosticUnderlineWarn
  
  hi! link DiagnosticInfo CakeCyan
  hi! link DiagnosticHint CakeCyan
  hi! link DiagnosticError CakeError
  hi! link DiagnosticWarn CakeOrange
  hi! link DiagnosticUnderlineError CakeErrorLine
  hi! link DiagnosticUnderlineHint CakeInfoLine
  hi! link DiagnosticUnderlineInfo CakeInfoLine
  hi! link DiagnosticUnderlineWarn CakeWarnLine
else
  hi! link SpecialKey CakePink
endif

hi! link Comment CakeComment
hi! link Underlined CakeFgUnderline
hi! link Todo CakeTodo

hi! link Error CakeError
hi! link SpellBad CakeErrorLine
hi! link SpellLocal CakeWarnLine
hi! link SpellCap CakeInfoLine
hi! link SpellRare CakeInfoLine

hi! link Constant CakePurple
hi! link String CakeYellow
hi! link Character CakePink
hi! link Number Constant
hi! link Boolean Constant
hi! link Float Constant

hi! link Identifier CakeFg
hi! link Function CakeGreen

hi! link Statement CakePink
hi! link Conditional CakePink
hi! link Repeat CakePink
hi! link Label CakePink
hi! link Operator CakePink
hi! link Keyword CakePink
hi! link Exception CakePink

hi! link PreProc CakePink
hi! link Include CakePink
hi! link Define CakePink
hi! link Macro CakePink
hi! link PreCondit CakePink
hi! link StorageClass CakePink
hi! link Structure CakePink
hi! link Typedef CakePink

hi! link Type CakeCyanItalic

hi! link Delimiter CakeFg

hi! link Special CakePink
hi! link SpecialComment CakeCyanItalic
hi! link Tag CakeCyan
hi! link helpHyperTextJump CakeLink
hi! link helpCommand CakePurple
hi! link helpExample CakeGreen
hi! link helpBacktick Special
