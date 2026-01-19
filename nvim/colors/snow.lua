vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "snow"
vim.o.background = "light"

local function hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

local comment = "#676767"
hl("@keyword.directive", { fg = "#D8432B" })
hl("@keyword.import", { fg = "#D6C2C2" })
hl("@lsp.type.const", { link = "Constant" })
hl("@variable", { link = "Normal" })
hl("Boolean", { fg = "#838580" })
hl("ColorColumn", { bg = "#DADADA" })
hl("Comment", { fg = "#7F7F7F" })
hl("Constant", { fg = "#768789" })
hl("CurSearch", { fg = "black", bg = "#E0DC00" })
hl("Cursor", { fg = "fg", bg = "#00FFFF" })
hl("CursorColumn", { bg = "#DADADA" })
hl("CursorIM", { fg = "fg", bg = "#00FFFF" })
hl("CursorLine", { bg = "#F1F1F1" })
hl("CursorLineNr", { bg = "white" })
hl("DiffAdd", { fg = "#008000" })
hl("DiffChange", { fg = "#875f00" })
hl("DiffDelete", { fg = "#800000" })
hl("DiffText", { fg = "#000080" })
hl("Directory", { fg = "#574C0F" })
hl("EndOfBuffer", { fg = "#E5E5E5", bg = "NONE" })
hl("Error", { fg = "#FF5555", bg = "white" })
hl("ErrorMsg", { fg = "#FF5555", bg = "white" })
hl("FloatBorder", { fg = "#E5E5E5", bg = "#E5E5E5" })
hl("FoldColumn", { fg = "#A8A8A8" })
hl("Folded", { fg = "#585858" })
hl("Function", { fg = "#8B768B" })
hl("Identifier", { fg = "#867A7A" })
hl("IncSearch", { fg = "white", bg = "#1AA1C1" })
hl("Keyword", { link = "Normal" })
hl("LineNr", { fg = "#666666" })
hl("MatchParen", { underline = true })
hl("Menu", {})
hl("ModeMsg", { fg = "#5F005F" })
hl("MoreMsg", { fg = "#C90906" })
hl("NonText", { fg = "#A8A8A8" })
hl("Normal", { fg = "#404040", bg = "NONE" })
hl("NormalFloat", { bg = "#E5E5E5" })
hl("Number", { fg = "#85626B" })
hl("Operator", { fg = "#ABA48B" })
hl("Pmenu", { fg = "fg", bg = "#E5E5E5" })
hl("PmenuSel", { fg = "fg", bg = "#CCCCCC" })
hl("PreProc", { link = "Normal" })
hl("Question", { fg = "#5F005F" })
hl("Scrollbar", {})
hl("Search", { fg = "black", bg = "#FFFD08" })
hl("SpecialComment", { fg = comment })
hl("SpellBad", { fg = "#CD00CD", underline = true })
hl("SpellCap", { fg = "#CD00CD", underline = true })
hl("SpellLocal", { fg = "#CD00CD", underline = true })
hl("SpellRare", { fg = "#CD00CD", underline = true })
hl("StatusLine", { bg = "#DEDEDE" })
hl("StatusLineChanged", { fg = "#CD4400" })
hl("StatusLineNC", { bg = "#F0F0F0" })
hl("StorageClass", { fg = "#9B9999" })
hl("String", { fg = "#8C8E6E" })
hl("TabLine", { bg = "#BFBFBF" })
hl("TabLineFill", { link = "Normal" })
hl("Todo", { fg = "#F2E1F2", bg = "#833986" })
hl("Tooltip", {})
hl("Type", { fg = "#8E836E" })
hl("Visual", { bg = "#D9D9D9" })
hl("WarningMsg", { fg = "#FF5555", bg = "white" })
hl("WildMenu", { fg = "#000000", bg = "white" })
hl("WinSeparator", { fg = "#323232" })

local blank = {}
local blank_groups = {
    "Character", "Conceal", "Conditional", "Debug", "Define",
    "Delimiter", "Directive", "Exception", "Format",
    "Ignore", "Include", "Label", "Macro", "PreCondit",
    "Repeat", "SpecialChar", "Special", "Statement",
    "Structure", "Tag", "Title", "Typedef", "Underlined"
}
for _, group in ipairs(blank_groups) do hl(group, blank) end
