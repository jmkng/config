vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "soot"
vim.o.background = "dark"

local function hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

hl("DiagnosticUnderlineError", { fg = "#FF0000" })
hl("@keyword.import", { link = "PreProc" })
hl("@variable", { link = "Normal" })
hl("ColorColumn", { bg = "#DADADA" })
hl("Comment", { fg = "#7F7F7F" })
hl("CurSearch", { fg = "black", bg = "#E0DC00" })
hl("Cursor", { fg = "fg", bg = "#00FFFF" })
hl("CursorColumn", { bg = "#DADADA" })
hl("CursorIM", { fg = "fg", bg = "#00FFFF" })
hl("CursorLine", { bg = "#1F1F1F" })
hl("CursorLineNr", { bg = "white" })
hl("DiffAdd", { fg = "#008000" })
hl("DiffChange", { fg = "#875f00" })
hl("DiffDelete", { fg = "#800000" })
hl("DiffText", { fg = "#000080" })
hl("Directory", { fg = "#FCF9EB" })
hl("EndOfBuffer", { fg = "#282828", bg = "NONE" })
hl("Error", { fg = "#FF5555", bg = "white" })
hl("ErrorMsg", { fg = "#FF5555", bg = "white" })
hl("FloatBorder", { fg = "#4D4D4D", bg = "#4D4D4D" })
hl("FoldColumn", { fg = "#A8A8A8" })
hl("Folded", { fg = "#585858" })
hl("Function", { link = "Keyword" })
hl("Identifier", { link = "Normal" })
hl("IncSearch", { fg = "white", bg = "#1AA1C1" })
hl("Keyword", { link = "Normal" })
hl("LineNr", { fg = "#A8A8A8" })
hl("MatchParen", { underline = true })
hl("Menu", {})
hl("ModeMsg", { fg = "#5F005F" })
hl("MoreMsg", { fg = "#5F005F" })
hl("NonText", { fg = "#A8A8A8" })
hl("Normal", { fg = "#FFFFFF", bg = "NONE" })
hl("NormalFloat", { bg = "#4D4D4D" })
hl("Number", { link = "String" })
hl("Operator", { link = "Normal" })
hl("PmenuSel", { fg = "fg", bg = "#FF00FF" })
hl("PreProc", { link = "Normal" })
hl("Question", { fg = "#5F005F" })
hl("Scrollbar", {})
hl("Search", { fg = "black", bg = "#FFFD08" })
hl("SpellBad", { fg = "#CD00CD", underline = true })
hl("SpellCap", { fg = "#CD00CD", underline = true })
hl("SpellLocal", { fg = "#CD00CD", underline = true })
hl("SpellRare", { fg = "#CD00CD", underline = true })
hl("StatusLine", { fg = "fg", bg = "#000000" })
hl("StatusLineMode", { bg = "#656565" })
hl("StatusLineNC", { fg = "#999999", bg = "#000000" })
hl("StorageClass", { fg = "#797777" })
hl("String", { link = "Normal" })
hl("TabLine", { bg = "#BFBFBF" })
hl("TabLineFill", { link = "Normal" })
hl("Todo", { fg = "#F2E1F2", bg = "#833986" })
hl("Tooltip", {})
hl("Type", { link = "Normal" })
hl("Visual", { bg = "#3F3F3F" })
hl("WarningMsg", { fg = "#FF5555", bg = "white" })
hl("WildMenu", { fg = "#000000", bg = "white" })
hl("WinSeparator", { fg = "#C6C6C6" })

local blank = {}
local blank_groups = {
    "Boolean", "Character", "Conceal", "Conditional", "Constant", "Debug", "Define",
    "Delimiter", "Directive", "Exception", "Format",
    "Ignore", "Include", "Label", "Macro", "PreCondit",
    "Repeat", "SpecialChar", "SpecialComment", "Special", "Statement",
    "Structure", "Tag", "Title", "Typedef", "Underlined",
}
for _, group in ipairs(blank_groups) do hl(group, blank) end
