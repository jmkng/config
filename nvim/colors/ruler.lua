-- Ruler
--
-- This is a theme with "just enough" color and contrast.
-- It uses those colors to draw attention to things that may warrant attention.
--
-- TODO:
--      [x] Highlight mutable data (var)
--      [ ] Highlight undefined (Zig)

vim.g.colors_name = "ruler"

vim.opt.guicursor:append({
    "n-c:blinkwait800-iCursor",
    "i-v:ver10-Cursor",
    "r:hor10-Cursor",
    "ci:ver10-iCursor",
    "cr:hor10-iCujsor",
    "sm:iCursor",
    "o:hor50-Error",
})


--vim.cmd("hi clear")
--if vim.fn.exists("syntax_on") == 1 then
--    vim.cmd("syntax reset")
--end

-- Groups
--
-- 1. Attention
--
-- Ruler will try to highlight things that may warrant extra attention.
--
-- Associated highlight groups:
--      @ruler.mutable
--
-- Examples:
--      1. Mutable state, meaning usage of "mut" in Rust, or "var" in Zig, etc.
--
-- 2. Danger
--
-- Ruler will try to highlight usage of dangerous constructs.
--
-- Associated highlight groups:
--      TODO
--
-- Examples:
--      1. Keyword "undefined" in, for example, Zig.
--      2. Unsafe blocks in Rust.

-- Uses a human readable color name (ex. blue)
-- where each color is a table containing shades of that color organized by lightness,
-- represented as variables prefixed by "l".
local colors = {
    gray = {
        L0   = "#000000",
        L10  = "#191919",
        L12  = "#1E1E1E",
        L15  = "#252525",
        L17  = "#2C2C2C",
        L20  = "#313131",
        L22  = "#393939",
        L25  = "#3F3F3F",
        L27  = "#454545",
        L30  = "#494949",
        L35  = "#565656",
        L40  = "#616161",
        L45  = "#6F6F6F",
        L50  = "#7B7B7B",
        L60  = "#969696",
        L65  = "#A7A7A7",
        L70  = "#AFAFAF",
        L75  = "#BCBCBC",
        L80  = "#CACACA",
        L85  = "#D7D7D7",
        L90  = "#E4E4E4",
        L95  = "#F1F1F1",
        L100 = "#FFFFFF",
    },
    blue = {
        L10 = "#001B35",
        L15 = "#00254B",
        L20 = "#003265",
        L25 = "#003E7D",
        L30 = "#004C99",
        L35 = "#0059B4",
        L40 = "#0066CE",
        L45 = "#0070E3",
        L50 = "#017EFF",
        L55 = "#198AFF",
        L60 = "#3398FF",
        L65 = "#4EA5FF",
        L70 = "#65B1FF",
        L75 = "#7FBEFF",
        L80 = "#99CBFF",
        L85 = "#B3D8FF",
        L90 = "#CAE4FF",
        L95 = "#E5F2FF",
    },
    cyan = {
        L12 = "#073236",
        L30 = "#118089",
        L40 = "#16A9B6",
        L50 = "#1CD4E3",
        L70 = "#78E5EF",
        L60 = "#3FD1EF", -- Updated
        L65 = "#5EE0EC",
        L75 = "#8BEAF1",
        L80 = "#A3EEF4",
        L85 = "#BBF2F7",
        L90 = "#D2F7FA",
    },
    teal = {
        L10 = "#003131",
        L15 = "#004C4C",
        L20 = "#006665",
        L25 = "#008080",
        L30 = "#009898",
        L35 = "#00B1B0",
        L40 = "#00CBCA",
        L45 = "#00E3E3",
        L50 = "#02FFFE",
        L55 = "#18FFFE",
        L60 = "#33FFFE",
        L65 = "#4BFFFF",
        L70 = "#67FFFF",
        L75 = "#82FFFF",
        L80 = "#98FFFF",
        L85 = "#B3FFFF",
        L90 = "#CEFFFF",
    },
    yellow = {
        L10 = "#323301",
        L15 = "#494B02",
        L20 = "#606302",
        L25 = "#7A7E03",
        L30 = "#8F9403",
        L35 = "#ABB004",
        L40 = "#C3C904",
        L45 = "#D8DE04",
        L50 = "#F3FA07",
        L55 = "#F4FA1F",
        L60 = "#F5FB39",
        L65 = "#F7FB50",
        L70 = "#F8FC6A",
        L75 = "#F9FC81",
        L80 = "#FAFD9C",
        L85 = "#FBFDB4",
        L90 = "#FDFECD",
        L95 = "#FEFFE7",
    },
    orange = {
        L50 = "#D96E28",
        L75 = "#ECB794",
        L80 = "#F0C5A8",
        L85 = "#F4D4BE",
        L90 = "#F7E1D2",
    },
    red = {
        L10 = "#340005",
        L15 = "#4B0008",
        L20 = "#67000B",
        L25 = "#7E000D",
        L30 = "#990010",
        L35 = "#B20012",
        L40 = "#CB0015",
        L45 = "#E50018",
        L50 = "#FF011B",
        L55 = "#FF1930",
        L60 = "#DD5357", -- use me
        L65 = "#FF4D5F",
        L70 = "#FF6676",
        L75 = "#FF808D",
        L80 = "#FF9B9E", -- don't overwrite me
        L85 = "#FFB3BB",
        L90 = "#FFCBD1",
    },
    purple = {
        L50 = "#BD01FF",
        L85 = "#EBB2FF",
        L90 = "#F2CCFF",
    },
    green = {
        L20 = "#06613A",
        L30 = "#099156",
        L40 = "#0CBE71",
        L50 = "#10EE8D",
        L60 = "#3EF2A4",
        L70 = "#70F6BC",
        L80 = "#A0F9D2",
        L90 = "#D0FCE9",
    },
}

-- Each rule should be equal to a table that contains "dark" and/or "light" tables,
-- which define rules for that background.
--
-- Ruler groups (ex. @ruler.mutable) should generally use higher contrast colors,
-- to ensure they are highly visible.
local sbg = colors.gray.L20    -- Shortcut for common bg color
local soff_bg = colors.gray.L15 -- Shortcut for status line, etc

local rules = {
    Normal = {
        dark = { fg = colors.gray.L100, bg = sbg },
    },
    NormalFloat = {
        dark = { bg = colors.gray.L0 },
    },
    LineNr = { dark = { fg = colors.gray.L30, bg = sbg } },

    StatusLine = { dark = { fg = colors.gray.L100, bg = colors.gray.L0, bold = false } },
    StatusLineNC = { dark = { fg = colors.gray.L60, bg = soff_bg, bold = false } },

    WinSeparator = { dark = { fg = soff_bg, bg = soff_bg, bold = false } },

    EndOfBuffer = { dark = { fg = colors.cyan.L50, bg = colors.gray.L30 } },

    FloatBorder = {
        dark = { fg = colors.gray.L0, bg = colors.gray.L0 },
    },
    CursorColumn = { dark = { bg = "NONE" } },
    --CursorLine = { dark = { bg = colors.gray.L20 } },
    --CursorLineNr = { dark = { fg = colors.gray.L80, bg = colors.gray.L20 } },
    CursorLine = { dark = { bg = colors.gray.L35 } },
    CursorLineNr = { dark = { fg = colors.gray.L30, bg = "NONE" } },
    FoldColumn = { dark = { fg = colors.gray.L100, bg = colors.gray.L30 } },
    Folded = { dark = { fg = colors.gray.L100, bg = colors.gray.L30 } },
    ColorColumn = { dark = { bg = colors.gray.L17 } },
    Directory = { dark = { fg = colors.gray.L100 } },
    Comment = { dark = { fg = colors.orange.L75 } },
    Ignore = { dark = { fg = colors.gray.L50 } },
    WarningMsg = { dark = { fg = colors.yellow.L60 } },
    ErrorMsg = { dark = { fg = colors.red.L60 } },
    ModeMsg = { dark = { fg = colors.gray.L100, bold = true } },
    MoreMsg = { dark = { fg = colors.gray.L100 } },
    Todo = { dark = { fg = colors.purple.L90, bg = colors.purple.L50 } },
    Error = { dark = { fg = colors.red.L90, bg = colors.red.L50 } },
    ["@variable"] = { dark = { fg = colors.gray.L100 } },
    Identifier = { dark = { fg = colors.gray.L100 } },
    Function = { dark = { fg = colors.gray.L100, bold = false } },
    Keyword = { dark = { fg = colors.blue.L75 } },
    Operator = { dark = { fg = colors.gray.L100, bold = false } },
    String = { dark = { fg = colors.green.L80, bold = false } },
    Number = { dark = { fg = colors.green.L80, bold = false } },
    Float = { dark = { fg = colors.green.L80, bold = false } },
    PreProc = { dark = { fg = colors.red.L80 } },
    Special = { dark = { fg = colors.gray.L100 } },
    SpecialKey = { dark = { fg = colors.cyan.L80 } },
    Visual = { dark = { fg = colors.blue.L90, bg = colors.blue.L35 } },
    Search = { dark = { fg = colors.yellow.L60, bg = colors.yellow.L20 } },
    CurSearch = { dark = { fg = colors.gray.L10, bg = colors.yellow.L50 } },
    IncSearch = { dark = { fg = colors.yellow.L10, bg = colors.yellow.L50, bold = true } },
    Title = { dark = { fg = colors.gray.L100 } },
    Question = { dark = { fg = colors.gray.L100 } },
    NonText = { dark = { fg = colors.gray.L100 } },
    ["@ruler.mutable"] = {
        dark = { fg = colors.yellow.L60 },
    },
}

local function apply_highlights(palette)
    local set = vim.api.nvim_set_hl
    for group_name, opts in pairs(palette) do
        set(0, group_name, opts)
    end
end

local function load()
    local bg = vim.o.background or "dark"

    local selected = {}
    for group_name, versions in pairs(rules) do
        if versions[bg] then
            selected[group_name] = versions[bg]
        end
    end

    apply_highlights(selected)
end

vim.api.nvim_create_autocmd("OptionSet", {
    group = vim.api.nvim_create_augroup("theme_autoload", { clear = true }),
    callback = load,
})

load()
