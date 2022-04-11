if cake#should_abort()
  finish
endif

if exists('g:loaded_fzf') && ! exists('g:fzf_colors')
  let g:fzf_colors = {
    \ 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Search'],
    \ 'fg+':     ['fg', 'Normal'],
    \ 'bg+':     ['bg', 'Normal'],
    \ 'hl+':     ['fg', 'CakeOrange'],
    \ 'info':    ['fg', 'CakePurple'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'CakeGreen'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'],
    \}
endif

if exists('g:ale_enabled')
  hi! link ALEError              CakeErrorLine
  hi! link ALEWarning            CakeWarnLine
  hi! link ALEInfo               CakeInfoLine

  hi! link ALEErrorSign          CakeRed
  hi! link ALEWarningSign        CakeOrange
  hi! link ALEInfoSign           CakeCyan

  hi! link ALEVirtualTextError   Comment
  hi! link ALEVirtualTextWarning Comment
endif
if exists('g:loaded_ctrlp')
  hi! link CtrlPMatch     IncSearch
  hi! link CtrlPBufferHid Normal
endif
if exists('g:loaded_gitgutter')
  hi! link GitGutterAdd    DiffAdd
  hi! link GitGutterChange DiffChange
  hi! link GitGutterDelete DiffDelete
endif
if has('nvim-0.5') && luaeval("pcall(require, 'gitsigns')")
  hi! link GitSignsAdd      DiffAdd
  hi! link GitSignsAddLn    DiffAdd
  hi! link GitSignsAddNr    DiffAdd
  hi! link GitSignsChange   DiffChange
  hi! link GitSignsChangeLn DiffChange
  hi! link GitSignsChangeNr DiffChange
  hi! link GitSignsDelete   DiffDelete
  hi! link GitSignsDeleteLn DiffDelete
  hi! link GitSignsDeleteNr DiffDelete
endif

if exists('g:loaded_nvim_treesitter')
  hi! link TSPunctSpecial Special
  hi! link TSConstMacro Macro
  hi! link TSStringEscape Character
  hi! link TSSymbol CakePurple
  hi! link TSAnnotation CakeYellow
  hi! link TSAttribute CakeGreenItalic
  hi! link TSFuncBuiltin CakeCyan
  hi! link TSFuncMacro Function
  hi! link TSParameter CakeOrangeItalic
  hi! link TSParameterReference CakeOrange
  hi! link TSField CakeOrange
  hi! link TSConstructor CakeCyan
  hi! link TSLabel CakePurpleItalic
  hi! link TSVariableBuiltin CakePurpleItalic
  hi! link TSStrong CakeFgBold
  hi! link TSEmphasis CakeFg
  hi! link TSUnderline Underlined
  hi! link TSTitle CakeYellow
  hi! link TSLiteral CakeYellow
  hi! link TSURI CakeYellow
  hi! link TSTagAttribute CakeGreenItalic
endif
if exists('g:loaded_cmp')
  hi! link CmpItemAbbrDeprecated CakeError

  hi! link CmpItemAbbrMatch CakeCyan
  hi! link CmpItemAbbrMatchFuzzy CakeCyan

  hi! link CmpItemKindText CakeFg
  hi! link CmpItemKindMethod Function
  hi! link CmpItemKindFunction Function
  hi! link CmpItemKindConstructor CakeCyan
  hi! link CmpItemKindField CakeOrange
  hi! link CmpItemKindVariable CakePurpleItalic
  hi! link CmpItemKindClass CakeCyan
  hi! link CmpItemKindInterface CakeCyan
  hi! link CmpItemKindModule CakeYellow
  hi! link CmpItemKindProperty CakePink
  hi! link CmpItemKindUnit CakeFg
  hi! link CmpItemKindValue CakeYellow
  hi! link CmpItemKindEnum CakePink
  hi! link CmpItemKindKeyword CakePink
  hi! link CmpItemKindSnippet CakeFg
  hi! link CmpItemKindColor CakeYellow
  hi! link CmpItemKindFile CakeYellow
  hi! link CmpItemKindReference CakeOrange
  hi! link CmpItemKindFolder CakeYellow
  hi! link CmpItemKindEnumMember CakePurple
  hi! link CmpItemKindConstant CakePurple
  hi! link CmpItemKindStruct CakePink
  hi! link CmpItemKindEvent CakeFg
  hi! link CmpItemKindOperator CakePink
  hi! link CmpItemKindTypeParameter CakeCyan

  hi! link CmpItemMenu Comment
endif
