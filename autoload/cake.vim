let g:cake#palette           = {}
let g:cake#palette.fg        = ['#FFFFFF', 253]

let g:cake#palette.bglighter = ['#FFFFFF', 238]
let g:cake#palette.bglight   = ['#FFFFFF', 237]
let g:cake#palette.bg        = ['#FFFFFF', 236]
let g:cake#palette.bgdark    = ['#1D1C1A', 235]
let g:cake#palette.bgdarker  = ['#1D1C1A', 234]

let g:cake#palette.comment   = ['#8E8E8D',  61]
let g:cake#palette.selection = ['#565554', 239]
let g:cake#palette.subtle    = ['#3A3937', 238]

let g:cake#palette.cyan      = ['#A4D8D8', 117]
let g:cake#palette.green     = ['#BEE5B0',  84]
let g:cake#palette.orange    = ['#F8C57C', 215]
let g:cake#palette.pink      = ['#EFB9C0', 212]
let g:cake#palette.purple    = ['#BCAFCF', 141]
let g:cake#palette.red       = ['#F08080', 203]
let g:cake#palette.yellow    = ['#F8F1AE', 228]

"
" ANSI
"
let g:cake#palette.color_0  = '#21222C'
let g:cake#palette.color_1  = '#F8C57C'
let g:cake#palette.color_2  = '#BEE5B0'
let g:cake#palette.color_3  = '#F8F1AE'
let g:cake#palette.color_4  = '#BCAFCF'
let g:cake#palette.color_5  = '#EFB9C0'
let g:cake#palette.color_6  = '#A4D8D8'
let g:cake#palette.color_7  = '#07060B'
let g:cake#palette.color_8  = '#BCAFCF'
let g:cake#palette.color_9  = '#FF6E6E'
let g:cake#palette.color_10 = '#69FF94'
let g:cake#palette.color_11 = '#FFFFA5'
let g:cake#palette.color_12 = '#D6ACFF'
let g:cake#palette.color_13 = '#FF92DF'
let g:cake#palette.color_14 = '#A4FFFF'
let g:cake#palette.color_15 = '#07060B'

" Helper function that takes a variadic list of filetypes as args and returns
" whether or not the execution of the ftplugin should be aborted.
func! cake#should_abort(...)
    if ! exists('g:colors_name') || g:colors_name !=# 'cake'
        return 1
    elseif a:0 > 0 && (! exists('b:current_syntax') || index(a:000, b:current_syntax) == -1)
        return 1
    endif
    return 0
endfunction
