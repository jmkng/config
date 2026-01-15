vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "soot"
vim.o.background = "dark"

local function hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

local comment = "#676767"
hl("@keyword.import", { fg = "#D6C2C2" })
hl("@variable", { link = "Normal" })
hl("ColorColumn", { bg = "#DADADA" })
hl("SpecialComment", { fg = comment })
hl("Comment", { fg = comment })
hl("CurSearch", { fg = "black", bg = "#E0DC00" })
hl("Constant", { fg = "#94A2A3" })
hl("@lsp.type.const", { link = "Constant" })
hl("Cursor", { fg = "fg", bg = "#00FFFF" })
hl("CursorColumn", { bg = "#DADADA" })
hl("CursorIM", { fg = "fg", bg = "#00FFFF" })
hl("CursorLine", { bg = "#262626" })
hl("CursorLineNr", { fg = "#B2B2B2", bg = "#262626" })
hl("DiffAdd", { fg = "#008000" })
hl("DiffChange", { fg = "#875f00" })
hl("DiffDelete", { fg = "#800000" })
hl("DiffText", { fg = "#000080" })
hl("Directory", { fg = "#FCF9EB" })
hl("EndOfBuffer", { fg = "#282828", bg = "NONE" })
hl("Error", { fg = "#FF5555", bg = "white" })
hl("ErrorMsg", { fg = "#FF5555", bg = "white" })
hl("FloatBorder", { fg = "#333333", bg = "#333333" })
hl("FoldColumn", { fg = "#A8A8A8" })
hl("Folded", { fg = "#585858" })
hl("Function", { fg = "#B1A5B3" })
hl("Identifier", { fg = "#A29A9A" })
hl("IncSearch", { fg = "white", bg = "#1AA1C1" })
hl("Keyword", { link = "Normal" })
hl("LineNr", { fg = "#666666" })
hl("MatchParen", { underline = true })
hl("Menu", {})
hl("ModeMsg", { fg = "#5F005F" })
hl("MoreMsg", { fg = "#C90906" })
hl("NonText", { fg = "#A8A8A8" })
hl("Normal", { fg = "#FFFFFF", bg = "NONE" })
hl("NormalFloat", { bg = "#333333" })
hl("Boolean", { fg = "#838580" })
hl("Number", { fg = "#9F7D86" })
hl("Operator", { fg = "#ABA48B" })
hl("Pmenu", { fg = "fg", bg = "#333333" })
hl("PmenuSel", { fg = "fg", bg = "#808080" })
hl("PreProc", { link = "Normal" })
hl("@keyword.directive", { fg = "#D8432B" })
hl("Question", { fg = "#5F005F" })
hl("Scrollbar", {})
hl("Search", { fg = "black", bg = "#FFFD08" })
hl("SpellBad", { fg = "#CD00CD", underline = true })
hl("SpellCap", { fg = "#CD00CD", underline = true })
hl("SpellLocal", { fg = "#CD00CD", underline = true })
hl("SpellRare", { fg = "#CD00CD", underline = true })
hl("StatusLine", { bg = "#000000" })
hl("StatusLineChanged", { fg = "#CD4400" })
hl("StatusLineNC", { fg = "#999999", bg = "#333333" })
hl("StorageClass", { fg = "#9B9999" })
hl("String", { fg = "#A4A58C" })
hl("TabLine", { bg = "#BFBFBF" })
hl("TabLineFill", { link = "Normal" })
hl("Todo", { fg = "#F2E1F2", bg = "#833986" })
hl("Tooltip", {})
hl("Type", { fg = "#D3CFC6" })
hl("Visual", { bg = "#262626" })
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
