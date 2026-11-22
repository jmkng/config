hi clear
if exists('syntax_on')
    syntax reset
endif
let g:colors_name = 'monowire'

let s:normal         = '#d5d3d2'
let s:dark_0         = '#3a3837'
let s:dark_1         = '#242221'
let s:dark_2         = '#1a1817'
let s:dark_3         = '#141211'
let s:bright_0       = '#615e5d'
let s:bright_1       = '#7b7877'
let s:bright_2       = '#a19e9c'

let s:hl_1           = '#f24e4e'  " Red / Error / Cursor 1
let s:hl_2           = '#f2aa4e'  " Orange / Warning / Search
let s:hl_3           = '#4eaaf2'  " Blue / Info / Operator Cursor
let s:eob            = '#755252'  " End of buffer
let s:nt             = '#9c6e64'  " Non-text


hi Normal       guifg=#FFFFFF guibg=NONE gui=NONE ctermfg=252 ctermbg=233 cterm=NONE
hi Visual       guifg=#141211 guibg=#d5d3d2 gui=NONE ctermfg=16  ctermbg=248 cterm=NONE

hi Cursor       guifg=NONE    guibg=#f24e4e gui=NONE ctermfg=NONE ctermbg=203 cterm=NONE
hi CursorI      guifg=NONE    guibg=#ffffff gui=NONE ctermfg=NONE ctermbg=255 cterm=NONE
hi CursorR      guifg=NONE    guibg=#f2aa4e gui=NONE ctermfg=NONE ctermbg=203 cterm=NONE
hi CursorO      guifg=NONE    guibg=#4eaaf2 gui=NONE ctermfg=NONE ctermbg=39  cterm=NONE

hi ColorColumn  guifg=NONE    guibg=#1a1817 gui=NONE ctermfg=NONE ctermbg=234 cterm=NONE
hi CursorLine   guifg=NONE    guibg=#242221 gui=NONE ctermfg=NONE ctermbg=234 cterm=NONE
hi CursorLineNr guifg=#a19e9c guibg=#242221 gui=NONE ctermfg=252 ctermbg=235 cterm=NONE
hi Folded       guifg=#d5d3d2 guibg=#242221 gui=italic ctermfg=252 ctermbg=235 cterm=italic
hi Search       guifg=#141211 guibg=#f2aa4e gui=bold ctermfg=16  ctermbg=214 cterm=bold
hi IncSearch    guifg=#141211 guibg=#f2aa4e gui=bold,reverse ctermfg=16 ctermbg=214 cterm=bold,reverse
hi LineNr       guifg=#615e5d guibg=NONE    gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE
hi VertSplit    guifg=#615e5d guibg=NONE    gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE
hi WildMenu     guifg=#141211 guibg=#d5d3d2 gui=NONE ctermfg=16  ctermbg=248 cterm=NONE
hi SpecialKey   guifg=NONE    guibg=NONE    gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
hi clear FoldColumn
hi clear SignColumn

hi Error        guifg=#f24e4e guibg=NONE    gui=bold ctermfg=203 ctermbg=NONE cterm=bold
hi ErrorMsg     guifg=#f24e4e guibg=NONE    gui=bold ctermfg=203 ctermbg=NONE cterm=bold
hi Warning      guifg=#f2aa4e guibg=NONE    gui=NONE ctermfg=214 ctermbg=NONE cterm=NONE
hi WarningMsg   guifg=#f2aa4e guibg=NONE    gui=bold ctermfg=214 ctermbg=NONE cterm=bold
hi MoreMsg      guifg=#4eaaf2 guibg=NONE    gui=bold ctermfg=153 ctermbg=NONE cterm=bold

hi MatchParen   guifg=#141211 guibg=#f2aa4e gui=NONE ctermfg=16 ctermbg=214 cterm=NONE
hi! link ParenMatch MatchParen

hi Pmenu        guifg=#7b7877 guibg=#1a1817 gui=NONE ctermfg=246 ctermbg=235 cterm=NONE
hi PmenuSbar    guifg=NONE    guibg=#1a1817 gui=NONE ctermfg=NONE ctermbg=235 cterm=NONE
hi PmenuSel     guifg=#1a1817 guibg=#a19e9c gui=NONE ctermfg=252 ctermbg=235 cterm=NONE
hi PmenuThumb   guifg=NONE    guibg=#3a3837 gui=NONE ctermfg=NONE ctermbg=235 cterm=NONE

hi StatusLine   guifg=#a19e9c guibg=NONE    gui=underline ctermfg=248 ctermbg=NONE cterm=underline
hi StatusLineNC guifg=#615e5d guibg=NONE    gui=underline ctermfg=240 ctermbg=NONE cterm=underline

hi TabLine      guifg=#615e5d guibg=NONE    gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE
hi TabLineFill  guifg=#615e5d guibg=NONE    gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE
hi TabLineSel   guifg=#a19e9c guibg=NONE    gui=bold ctermfg=248 ctermbg=NONE cterm=bold

hi Comment      guifg=#7b7877 guibg=NONE    gui=italic      ctermfg=243  ctermbg=NONE cterm=italic
hi String       guifg=#a19e9c guibg=NONE    gui=NONE        ctermfg=247  ctermbg=NONE cterm=NONE
hi EndOfBuffer  guifg=#755252 guibg=NONE    gui=NONE        ctermfg=95   ctermbg=NONE cterm=NONE
hi NonText      guifg=#9c6e64 guibg=NONE    gui=NONE        ctermfg=95   ctermbg=NONE cterm=NONE
hi Todo         guifg=#f2aa4e guibg=NONE    gui=bold,italic ctermfg=214  ctermbg=NONE cterm=bold,italic
hi Whitespace   guifg=#3a3837 guibg=NONE    gui=NONE        ctermfg=236  ctermbg=NONE cterm=NONE

hi Function     guifg=NONE    guibg=NONE    gui=italic      ctermfg=NONE ctermbg=NONE cterm=italic
hi Constant     guifg=#C2A1B9 guibg=NONE    gui=italic      ctermfg=NONE ctermbg=NONE cterm=italic
hi Identifier   guifg=NONE    guibg=NONE    gui=italic      ctermfg=NONE ctermbg=NONE cterm=italic
hi Include      guifg=NONE    guibg=NONE    gui=italic      ctermfg=NONE ctermbg=NONE cterm=italic
hi Keyword      guifg=NONE    guibg=NONE    gui=bold        ctermfg=NONE ctermbg=NONE cterm=bold
hi Question     guifg=NONE    guibg=NONE    gui=NONE        ctermfg=NONE ctermbg=NONE cterm=NONE
hi Statement    guifg=NONE    guibg=NONE    gui=bold        ctermfg=NONE ctermbg=NONE cterm=bold
hi Type         guifg=NONE    guibg=NONE    gui=bold        ctermfg=NONE ctermbg=NONE cterm=bold
hi Underlined   guifg=NONE    guibg=NONE    gui=underline   ctermfg=NONE ctermbg=NONE cterm=underline
hi Title        guifg=NONE    guibg=NONE    gui=bold        ctermfg=NONE ctermbg=NONE cterm=bold

hi DiffAdd      guifg=#88aa77 guibg=NONE    gui=NONE        ctermfg=107  ctermbg=NONE cterm=NONE
hi DiffDelete   guifg=#aa7766 guibg=NONE    gui=NONE        ctermfg=137  ctermbg=NONE cterm=NONE
hi DiffChange   guifg=#7788aa guibg=NONE    gui=NONE        ctermfg=67   ctermbg=NONE cterm=NONE
hi DiffText     guifg=#7788aa guibg=NONE    gui=underline   ctermfg=67   ctermbg=NONE cterm=underline

hi QuickFixLine    guibg=#333333
hi QFNormal        guibg=#222222
hi QFEndOfBuffer   guifg=#222222

hi clear Conceal
"hi clear Constant
hi clear Define
hi clear Directory
hi clear Label
hi clear Number
hi clear Operator
hi clear PreProc
hi clear Special
hi clear Noise

hi! link CursorWordHighlight Underlined
hi! link CocHighlightText Underlined

hi ALEError         guisp=#ff4444 gui=undercurl ctermfg=203 cterm=underline
hi ALEWarning       guisp=#dd9922 gui=undercurl ctermfg=214 cterm=underline
hi ALEErrorSign     guifg=#ff4444 ctermfg=203
hi ALEWarningSign   guifg=#dd9922 ctermfg=214

hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal
hi! link SpellBad   ALEError
hi! link SpellCap   ALEError
hi! link SpellRare  ALEError
hi! link SpellLocal ALEWarning

hi CocErrorHighlight   guisp=#ff4444 gui=undercurl ctermfg=203 cterm=underline
hi CocWarningHighlight guisp=#dd9922 gui=undercurl ctermfg=214 cterm=underline
hi CocInfoHighlight    guisp=#00afff gui=undercurl ctermfg=153 cterm=underline
hi CocHintHighlight    guisp=#00afff gui=undercurl ctermfg=153 cterm=underline
hi CocErrorSign        guifg=#ff4444 ctermfg=203
hi CocWarningSign      guifg=#dd9922 ctermfg=214
hi CocInfoSign         guifg=#00afff ctermfg=153
hi CocHintSign         guifg=#00afff ctermfg=153

hi Sneak            guifg=#000000 guibg=#4eaaf2 gui=NONE ctermfg=16 ctermbg=153 cterm=NONE
hi SneakLabel       guifg=#000000 guibg=#4eaaf2 gui=bold ctermfg=16 ctermbg=153 cterm=bold
hi SneakLabelMask   guifg=#4eaaf2 guibg=#4eaaf2 gui=NONE ctermfg=153 ctermbg=153 cterm=NONE

hi QuickScopePrimary   gui=underline guisp=#ff4444
hi QuickScopeSecondary gui=underline guisp=#ff4444

hi! link HighlightedyankRegion Warning
