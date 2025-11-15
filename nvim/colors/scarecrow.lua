vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "scarecrow"

local palette = {
    _DEBUG             = "#ff0000",

    white              = "#ffffff",
    dark_blue          = "#004c63",
    dark_cyan          = "#007373",
    dark_green         = "#005523",
    dark_gray1         = "#191b1f",
    dark_gray2         = "#2d2f33",
    dark_gray3         = "#42464d",
    dark_gray4         = "#85838c",
    dark_magenta       = "#470045",
    dark_red           = "#590008",
    dark_yellow        = "#6b5300",

    light_blue         = "#A6DBFF",
    light_cyan         = "#8cf8f7",
    light_green        = "#b4f6c0",
    light_gray1        = "#EEF1F8",
    light_gray2        = "#E0E2EA",
    light_gray3        = "#C4C6CD",
    light_gray4        = "#9b9ea4",
    light_magenta      = "#FFCAFF",
    light_red          = "#FFC0B9",
    light_yellow       = "#FCE094",

    accent_viridian    = "#4e9e7a",
    accent_coral       = "#fc7a57",
    accent_french_gray = "#bab9cb",
    --accent_space_cadet = "#2d3047",
    accent_vanilla     = "#eddea4",
}

local set = vim.api.nvim_set_hl

set(0, "Normal", { fg = palette.white, bg = "NONE" })
set(0, "NormalNC", { fg = palette.white, bg = "NONE" })
set(0, "NormalFloat", { fg = palette.white, bg = "NONE" })
set(0, "FloatBorder", { fg = palette.dark_gray3, bg = "NONE" })
set(0, "TelescopeBorder", { fg = palette.dark_gray3, bg = "NONE" })
set(0, "WinSeparator", { fg = palette.dark_gray3, bg = "NONE" })

set(0, "CursorLine", { bg = "NONE" })
set(0, "LineNr", { fg = palette.dark_gray3, bg = "NONE" })
set(0, "CursorLineNr", { fg = palette.light_gray3, bg = "NONE" })
set(0, "Visual", { bg = palette.dark_gray3 })

set(0, "Directory", { fg = palette.white })
set(0, "Title", { fg = palette.white })

-- Syntax
set(0, "Comment", { fg = palette.dark_gray4 })
set(0, "Identifier", { fg = palette.white })
set(0, "Function", { fg = palette.accent_viridian })
set(0, "Keyword", { fg = palette.white })
set(0, "Statement", { fg = palette.light_yellow })
set(0, "Conditional", { fg = palette.accent_orange })
set(0, "Repeat", { fg = palette.light_yellow })
set(0, "Operator", { fg = palette.light_gray4 })
set(0, "String", { fg = palette.light_green })
set(0, "Constant", { fg = palette.white })
set(0, "Number", { fg = palette.light_green })
set(0, "Boolean", { fg = palette.light_green })
set(0, "Type", { fg = palette.accent_coral })

-- Diagnostics
set(0, "DiagnosticError", { fg = palette.light_red })
set(0, "DiagnosticWarn", { fg = palette.light_yellow })
set(0, "DiagnosticInfo", { fg = palette.light_blue })
set(0, "DiagnosticHint", { fg = palette.light_gray4 })

-- Misc
set(0, "PreProc", { fg = palette.light_gray4 })
set(0, "Include", { fg = palette.light_gray4 })
set(0, "Special", { fg = palette.light_gray4 })

-- StatusLine
set(0, "StatusLine", { fg = palette.white, bg = palette.dark_gray1 })
set(0, "StatusLineNC", { fg = palette.white, bg = palette.dark_gray1 })
