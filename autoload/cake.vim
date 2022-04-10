let s:overrides = get(g:, "cake_color_overrides", {})

" white_mask_<number>: Color of a white mask overlayed on top of
" `s:colors.black`, where `number * 12` is the alpha value of the white mask

let s:colors = {
      \ "red": get(s:overrides, "red", { "gui": "#E44F5C", "cterm": "204", "cterm16": "1" }),
      \ "light_red": get(s:overrides, "light_red", { "gui": "#F0B6D5", "cterm": "204", "cterm16": "1" }),
      \ "dark_red": get(s:overrides, "dark_red", { "gui": "#E56E90", "cterm": "196", "cterm16": "9" }),
      \ "green": get(s:overrides, "green", { "gui": "#BEE5B0", "cterm": "114", "cterm16": "2" }),
      \ "yellow": get(s:overrides, "yellow", { "gui": "#F8F1AE", "cterm": "180", "cterm16": "3" }),
      \ "dark_yellow": get(s:overrides, "dark_yellow", { "gui": "#FBBB62", "cterm": "173", "cterm16": "11" }),
      \ "blue": get(s:overrides, "blue", { "gui": "#9BBEED", "cterm": "39", "cterm16": "4" }),
      \ "purple": get(s:overrides, "purple", { "gui": "#9A7FAE", "cterm": "170", "cterm16": "5" }),
      \ "blue_purple": get(s:overrides, "blue_purple", { "gui": "#807DDB", "cterm": "39", "cterm16": "4"}),
      \ "cyan": get(s:overrides, "cyan", { "gui": "#A4D8D8", "cterm": "38", "cterm16": "6" }),
      \ "white": get(s:overrides, "white", { "gui": "#FAF8F6", "cterm": "145", "cterm16": "7" }),
      \ "black": get(s:overrides, "black", { "gui": "#1D1C1A", "cterm": "235", "cterm16": "0" }),
      \ "visual_black": get(s:overrides, "visual_black", { "gui": "NONE", "cterm": "NONE", "cterm16": "0" }),
      \ "comment_grey": get(s:overrides, "comment_grey", { "gui": "#697098", "cterm": "59", "cterm16": "15" }),
      \ "gutter_fg_grey": get(s:overrides, "gutter_fg_grey", { "gui": "#4B5263", "cterm": "238", "cterm16": "15" }),
      \ "cursor_grey": get(s:overrides, "cursor_grey", { "gui": "#2C323C", "cterm": "236", "cterm16": "8" }),
      \ "visual_grey": get(s:overrides, "visual_grey", { "gui": "#4C4942", "cterm": "237", "cterm16": "15" }),
      \ "menu_grey": get(s:overrides, "menu_grey", { "gui": "#3E4452", "cterm": "237", "cterm16": "8" }),
      \ "special_grey": get(s:overrides, "special_grey", { "gui": "#3B4048", "cterm": "238", "cterm16": "15" }),
      \ "vertsplit": get(s:overrides, "vertsplit", { "gui": "#181A1F", "cterm": "59", "cterm16": "15" }),
      \ "white_mask_1": get(s:overrides, "white_mask_1", { "gui": "#333747", "cterm": "237", "cterm16": "15" }),
      \ "white_mask_3": get(s:overrides, "white_mask_3", { "gui": "#474b59", "cterm": "238", "cterm16": "15" }),
      \ "white_mask_11": get(s:overrides, "white_mask_11", { "gui": "#989aa2", "cterm": "238", "cterm16": "15" })
      \}

function! cake#GetColors()
  return s:colors
endfunction
