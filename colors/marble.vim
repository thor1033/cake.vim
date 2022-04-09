scriptencoding utf8

if v:version > 580
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'marble'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

let s:fg        = g:marble#palette.fg

let s:bglighter = g:marble#palette.bglighter
let s:bglight   = g:marble#palette.bglight
let s:bg        = g:marble#palette.bg
let s:bgdark    = g:marble#palette.bgdark
let s:bgdarker  = g:marble#palette.bgdarker

let s:comment   = g:marble#palette.comment
let s:selection = g:marble#palette.selection
let s:subtle    = g:marble#palette.subtle

let s:cyan      = g:marble#palette.cyan
let s:green     = g:marble#palette.green
let s:orange    = g:marble#palette.orange
let s:pink      = g:marble#palette.pink
let s:purple    = g:marble#palette.purple
let s:red       = g:marble#palette.red
let s:yellow    = g:marble#palette.yellow

let s:none      = ['NONE', 'NONE']

if has('nvim')
  for s:i in range(16)
    let g:terminal_color_{s:i} = g:marble#palette['color_' . s:i]
  endfor
endif

if has('terminal')
  let g:terminal_ansi_colors = []
  for s:i in range(16)
    call add(g:terminal_ansi_colors, g:marble#palette['color_' . s:i])
  endfor
endif

if !exists('g:marble_bold')
  let g:marble_bold = 1
endif

if !exists('g:marble_italic')
  let g:marble_italic = 1
endif

if !exists('g:marble_underline')
  let g:marble_underline = 1
endif

if !exists('g:marble_undercurl')
  let g:marble_undercurl = g:marble_underline
endif

if !exists('g:marble_full_special_attrs_support')
  let g:marble_full_special_attrs_support = has('gui_running')
endif

if !exists('g:marble_inverse')
  let g:marble_inverse = 1
endif

if !exists('g:marble_colorterm')
  let g:marble_colorterm = 1
endif

let s:attrs = {
      \ 'bold': g:marble_bold == 1 ? 'bold' : 0,
      \ 'italic': g:marble_italic == 1 ? 'italic' : 0,
      \ 'underline': g:marble_underline == 1 ? 'underline' : 0,
      \ 'undercurl': g:marble_undercurl == 1 ? 'undercurl' : 0,
      \ 'inverse': g:marble_inverse == 1 ? 'inverse' : 0,
      \}

function! s:h(scope, fg, ...) " bg, attr_list, special
  let l:fg = copy(a:fg)
  let l:bg = get(a:, 1, ['NONE', 'NONE'])

  let l:attr_list = filter(get(a:, 2, ['NONE']), 'type(v:val) == 1')
  let l:attrs = len(l:attr_list) > 0 ? join(l:attr_list, ',') : 'NONE'

  let l:special = get(a:, 3, ['NONE', 'NONE'])
  if l:special[0] !=# 'NONE' && l:fg[0] ==# 'NONE' && !g:marble_full_special_attrs_support
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


call s:h('MarbleBgLight', s:none, s:bglight)
call s:h('MarbleBgLighter', s:none, s:bglighter)
call s:h('MarbleBgDark', s:none, s:bgdark)
call s:h('MarbleBgDarker', s:none, s:bgdarker)

call s:h('MarbleFg', s:fg)
call s:h('MarbleFgUnderline', s:fg, s:none, [s:attrs.underline])
call s:h('MarbleFgBold', s:fg, s:none, [s:attrs.bold])

call s:h('MarbleComment', s:comment)
call s:h('MarbleCommentBold', s:comment, s:none, [s:attrs.bold])

call s:h('MarbleSelection', s:none, s:selection)

call s:h('MarbleSubtle', s:subtle)

call s:h('MarbleCyan', s:cyan)
call s:h('MarbleCyanItalic', s:cyan, s:none, [s:attrs.italic])

call s:h('MarbleGreen', s:green)
call s:h('MarbleGreenBold', s:green, s:none, [s:attrs.bold])
call s:h('MarbleGreenItalic', s:green, s:none, [s:attrs.italic])
call s:h('MarbleGreenItalicUnderline', s:green, s:none, [s:attrs.italic, s:attrs.underline])

call s:h('MarbleOrange', s:orange)
call s:h('MarbleOrangeBold', s:orange, s:none, [s:attrs.bold])
call s:h('MarbleOrangeItalic', s:orange, s:none, [s:attrs.italic])
call s:h('MarbleOrangeBoldItalic', s:orange, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('MarbleOrangeInverse', s:bg, s:orange)

call s:h('MarblePink', s:pink)
call s:h('MarblePinkItalic', s:pink, s:none, [s:attrs.italic])

call s:h('MarblePurple', s:purple)
call s:h('MarblePurpleBold', s:purple, s:none, [s:attrs.bold])
call s:h('MarblePurpleItalic', s:purple, s:none, [s:attrs.italic])

call s:h('MarbleRed', s:red)
call s:h('MarbleRedInverse', s:fg, s:red)

call s:h('MarbleYellow', s:yellow)
call s:h('MarbleYellowItalic', s:yellow, s:none, [s:attrs.italic])

call s:h('MarbleError', s:red, s:none, [], s:red)

call s:h('MarbleErrorLine', s:none, s:none, [s:attrs.undercurl], s:red)
call s:h('MarbleWarnLine', s:none, s:none, [s:attrs.undercurl], s:orange)
call s:h('MarbleInfoLine', s:none, s:none, [s:attrs.undercurl], s:cyan)

call s:h('MarbleTodo', s:cyan, s:none, [s:attrs.bold, s:attrs.inverse])
call s:h('MarbleSearch', s:green, s:none, [s:attrs.inverse])
call s:h('MarbleBoundary', s:comment, s:bgdark)
call s:h('MarbleLink', s:cyan, s:none, [s:attrs.underline])

call s:h('MarbleDiffChange', s:orange, s:none)
call s:h('MarbleDiffText', s:bg, s:orange)
call s:h('MarbleDiffDelete', s:red, s:bgdark)


set background=dark

call s:h('Normal', s:fg, g:marble_colorterm || has('gui_running') ? s:bg : s:none )
call s:h('StatusLine', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineNC', s:none, s:bglight)
call s:h('StatusLineTerm', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineTermNC', s:none, s:bglight)
call s:h('WildMenu', s:bg, s:purple, [s:attrs.bold])
call s:h('CursorLine', s:none, s:subtle)

hi! link ColorColumn  MarbleBgDark
hi! link CursorColumn CursorLine
hi! link CursorLineNr MarbleYellow
hi! link DiffAdd      MarbleGreen
hi! link DiffAdded    DiffAdd
hi! link DiffChange   MarbleDiffChange
hi! link DiffDelete   MarbleDiffDelete
hi! link DiffRemoved  DiffDelete
hi! link DiffText     MarbleDiffText
hi! link Directory    MarblePurpleBold
hi! link ErrorMsg     MarbleRedInverse
hi! link FoldColumn   MarbleSubtle
hi! link Folded       MarbleBoundary
hi! link IncSearch    MarbleOrangeInverse
call s:h('LineNr', s:comment)
hi! link MoreMsg      MarbleFgBold
hi! link NonText      MarbleSubtle
hi! link Pmenu        MarbleBgDark
hi! link PmenuSbar    MarbleBgDark
hi! link PmenuSel     MarbleSelection
hi! link PmenuThumb   MarbleSelection
hi! link Question     MarbleFgBold
hi! link Search       MarbleSearch
call s:h('SignColumn', s:comment)
hi! link TabLine      MarbleBoundary
hi! link TabLineFill  MarbleBgDark
hi! link TabLineSel   Normal
hi! link Title        MarbleGreenBold
hi! link VertSplit    MarbleBoundary
hi! link Visual       MarbleSelection
hi! link VisualNOS    Visual
hi! link WarningMsg   MarbleOrangeInverse

call s:h('MatchParen', s:green, s:none, [s:attrs.underline])
call s:h('Conceal', s:cyan, s:none)

if has('nvim')
  hi! link SpecialKey MarbleRed
  hi! link LspReferenceText MarbleSelection
  hi! link LspReferenceRead MarbleSelection
  hi! link LspReferenceWrite MarbleSelection
  hi! link LspDiagnosticsDefaultInformation DiagnosticInfo
  hi! link LspDiagnosticsDefaultHint DiagnosticHint
  hi! link LspDiagnosticsDefaultError DiagnosticError
  hi! link LspDiagnosticsDefaultWarning DiagnosticWarn
  hi! link LspDiagnosticsUnderlineError DiagnosticUnderlineError
  hi! link LspDiagnosticsUnderlineHint DiagnosticUnderlineHint
  hi! link LspDiagnosticsUnderlineInformation DiagnosticUnderlineInfo
  hi! link LspDiagnosticsUnderlineWarning DiagnosticUnderlineWarn
  
  hi! link DiagnosticInfo MarbleCyan
  hi! link DiagnosticHint MarbleCyan
  hi! link DiagnosticError MarbleError
  hi! link DiagnosticWarn MarbleOrange
  hi! link DiagnosticUnderlineError MarbleErrorLine
  hi! link DiagnosticUnderlineHint MarbleInfoLine
  hi! link DiagnosticUnderlineInfo MarbleInfoLine
  hi! link DiagnosticUnderlineWarn MarbleWarnLine
else
  hi! link SpecialKey MarblePink
endif

hi! link Comment MarbleComment
hi! link Underlined MarbleFgUnderline
hi! link Todo MarbleTodo

hi! link Error MarbleError
hi! link SpellBad MarbleErrorLine
hi! link SpellLocal MarbleWarnLine
hi! link SpellCap MarbleInfoLine
hi! link SpellRare MarbleInfoLine

hi! link Constant MarblePurple
hi! link String MarbleYellow
hi! link Character MarblePink
hi! link Number Constant
hi! link Boolean Constant
hi! link Float Constant

hi! link Identifier MarbleFg
hi! link Function MarbleGreen

hi! link Statement MarblePink
hi! link Conditional MarblePink
hi! link Repeat MarblePink
hi! link Label MarblePink
hi! link Operator MarblePink
hi! link Keyword MarblePink
hi! link Exception MarblePink

hi! link PreProc MarblePink
hi! link Include MarblePink
hi! link Define MarblePink
hi! link Macro MarblePink
hi! link PreCondit MarblePink
hi! link StorageClass MarblePink
hi! link Structure MarblePink
hi! link Typedef MarblePink

hi! link Type MarbleCyanItalic

hi! link Delimiter MarbleFg

hi! link Special MarblePink
hi! link SpecialComment MarbleCyanItalic
hi! link Tag MarbleCyan
hi! link helpHyperTextJump MarbleLink
hi! link helpCommand MarblePurple
hi! link helpExample MarbleGreen
hi! link helpBacktick Special
