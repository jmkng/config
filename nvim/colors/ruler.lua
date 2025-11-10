vim.g.colors_name = "ruler"

local variants = {
    GRAY = "gray",
}

local override = variants.GRAY -- Change me.

vim.opt.guicursor:append({
    "n-c:blinkwait800-iCursor",
    "i-v:ver10-Cursor",
    "r:hor10-Cursor",
    "ci:ver10-iCursor",
    "cr:hor10-iCujsor",
    "sm:iCursor",
    "o:hor50-Error",
})

-- Groups
--
-- 1. Attention
--
-- Try to highlight things that may warrant extra attention.
--
-- Associated highlight groups:
--      @ruler.mutable
--
-- Examples:
--      1. Mutable state, meaning usage of "mut" in Rust, or "var" in Zig, etc.
--
-- 2. Danger
--
-- Try to highlight usage of dangerous constructs.
--
-- Associated highlight groups:
--      TODO
--
-- Examples:
--      1. Keyword "undefined" in, for example, Zig.
--      2. Unsafe blocks in Rust. (Maybe? might be annoying)

-- Uses a human readable color name (ex. blue)
-- where each color is a table containing shades of that color organized by lightness,
-- represented as variables prefixed by "l".
local colors = {
    gray = {
        L0   = "#000000",
        L5   = "#0D0D0D",
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
        L50  = "#808080",
        L55  = "#8B8B8B",
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
        L5 = "#000C18",
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
        L5 = "#031819",
        L10 = "#052D30",
        L12 = "#063438",
        L15 = "#073F43",
        L20 = "#0A575D",
        L25 = "#0D6B73",
        L30 = "#0F8089",
        L35 = "#1297A2",
        L40 = "#14AAB6",
        L45 = "#17C0CE",
        L50 = "#19D6E5",
        L55 = "#2FDAE8",
        L60 = "#46DEEA",
        L65 = "#5DE2ED",
        L70 = "#77E7F0",
        L75 = "#8EEBF2",
        L80 = "#A3EFF5",
        L85 = "#BAF3F7",
        L90 = "#D0F7FA",
        L95 = "#E9FBFD",
    },
    teal = {
        L5 = "#001919",
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
        L95 = "#E6FFFF",
    },
    yellow = {
        L5 = "#181900",
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
        L5 = "#170B04",
        L10 = "#2C1508",
        L15 = "#42200C",
        L20 = "#55290F",
        L25 = "#6E3513",
        L30 = "#844017",
        L35 = "#96491B",
        L40 = "#AB531E",
        L45 = "#C45E23",
        L50 = "#D96927",
        L55 = "#DD783C",
        L60 = "#E08650",
        L65 = "#E49668",
        L70 = "#E8A47D",
        L75 = "#ECB392",
        L80 = "#F0C3A8",
        L85 = "#F3D1BC",
        L90 = "#F7E0D2",
        L95 = "#FBEFE7",
    },
    red = {
        L5 = "#160405",
        L10 = "#2C090A",
        L15 = "#3E0C0E",
        L20 = "#541113",
        L25 = "#6B1518",
        L30 = "#80191D",
        L35 = "#951D21",
        L40 = "#AC2227",
        L45 = "#BF252B",
        L50 = "#D62C32",
        L55 = "#D93D43",
        L60 = "#DE555A",
        L65 = "#E26A6E",
        L70 = "#E68084",
        L75 = "#EA9497",
        L80 = "#FF9B9E",
        L85 = "#F3C0C2",
        L90 = "#F7D4D5",
        L95 = "#FAE8E8",
    },
    purple = {
        L5 = "#130019",
        L10 = "#270035",
        L15 = "#37004B",
        L20 = "#4C0066",
        L25 = "#5F007F",
        L30 = "#720099",
        L35 = "#8400B1",
        L40 = "#9800CC",
        L45 = "#AB00E5",
        L50 = "#BC00FD",
        L55 = "#C51AFF",
        L60 = "#CB34FF",
        L65 = "#D14CFF",
        L70 = "#D866FF",
        L75 = "#DE7FFF",
        L80 = "#E599FF",
        L85 = "#ECB5FF",
        L90 = "#F2CCFF",
        L95 = "#F9E6FF",
    },
    green = {
        L5 = "#021A10",
        L10 = "#032F1C",
        L15 = "#05472A",
        L20 = "#06623A",
        L25 = "#087848",
        L30 = "#098E55",
        L35 = "#0BA763",
        L40 = "#0CBF72",
        L45 = "#0EDA82",
        L50 = "#0FEF8E",
        L55 = "#29F29B",
        L60 = "#3FF3A5",
        L65 = "#58F4B1",
        L70 = "#6EF6BB",
        L75 = "#88F7C7",
        L80 = "#9DF9D1",
        L85 = "#B6FADD",
        L90 = "#CFFCE9",
        L95 = "#E6FDF3",
    },
}

-- Each rule should be equal to a table that contains "dark" and/or "light" tables,
-- which define rules for that background.
--
-- Ruler groups (ex. @ruler.mutable) should generally use higher contrast colors,
-- to ensure they are highly visible.
local themes = {
    ["@ruler.mutable"] = {
        dark = { fg = colors.cyan.L80 },
        light = { fg = colors.cyan.L20 },
        [variants.GRAY] = { fg = colors.cyan.L80 },
    },
    Normal = {
        dark = { fg = colors.gray.L100, bg = colors.gray.L0 },
        light = { fg = colors.gray.L10, bg = colors.gray.L100 },
        [variants.GRAY] = { fg = colors.gray.L100, bg = colors.gray.L25 },
    },
    NormalFloat = {
        dark = { bg = colors.gray.L0 },
        [variants.GRAY] = { bg = colors.gray.L15 }
    },
    Floatborder = {
        dark = { fg = colors.gray.L100, bg = colors.gray.L0 },
        [variants.GRAY] = { fg = colors.gray.L15, bg = colors.gray.L15 }
    },
    Pmenu = {
        dark = { fg = colors.gray.L100, bg = colors.gray.L0 },
        [variants.GRAY] = { fg = colors.gray.L100, bg = colors.gray.L15 }
    },
    PmenuSel = {
        dark = { fg = colors.gray.L100, bg = colors.gray.L0 },
        [variants.GRAY] = { fg = colors.gray.L0, bg = colors.gray.L90 }
    },
    LineNr = {
        dark = { fg = colors.gray.L50, bg = colors.gray.L0 },
        [variants.GRAY] = { fg = colors.gray.L50, bg = colors.gray.L25 }
    },
    StatusLine = {
        dark = { fg = colors.gray.L100, bg = colors.gray.L0 },
        [variants.GRAY] = { fg = colors.gray.L80, bg = colors.gray.L15 }
    },
    StatusLineNC = {
        dark = { fg = colors.gray.L60, bg = colors.gray.L15 },
        [variants.GRAY] = { fg = colors.gray.L50, bg = colors.gray.L15 }
    },
    StatusLineQuickfix = {
        dark = { fg = colors.cyan.L50 },
        [variants.GRAY] = { fg = colors.cyan.L50 }
    },
    StatusLineFileName = {
        dark = { fg = colors.yellow.L50, bg = colors.gray.L0 },
        [variants.GRAY] = { fg = colors.yellow.L50, bg = colors.gray.L15 },
    },
    WinSeparator = {
        dark = { fg = colors.gray.L15, bg = colors.gray.L15 },
        [variants.GRAY] = { fg = colors.gray.L15, bg = colors.gray.L15 }
    },
    EndOfBuffer = {
        dark = { fg = colors.gray.L25, bg = colors.gray.L0 },
        [variants.GRAY] = { fg = colors.gray.L50, bg = colors.gray.L25 }
    },
    CursorColumn = {
        dark = { bg = colors.gray.L10 },
        [variants.GRAY] = { bg = colors.gray.L30 }
    },
    CursorLine = {
        dark = { bg = colors.gray.L15 },
        [variants.GRAY] = { bg = colors.gray.L30 }
    },
    CursorLineNr = {
        dark = { fg = colors.gray.L50, bg = colors.gray.L15 },
        [variants.GRAY] = { fg = colors.gray.L50, bg = colors.gray.L30 }
    },
    CursorLineSign = {
        dark = { bg = colors.gray.L0 },
        [variants.GRAY] = { bg = colors.gray.L25 }
    },
    ColorColumn = {
        dark = { bg = colors.gray.L17 },
        [variants.GRAY] = { bg = colors.gray.L50 }
    },
    Directory = {
        dark = { fg = colors.gray.L100 },
        [variants.GRAY] = { fg = colors.gray.L90 }
    },
    Comment = {
        dark = { fg = colors.gray.L55 },
        [variants.GRAY] = { fg = colors.gray.L65 }
    },
    WarningMsg = {
        dark = { fg = colors.yellow.L60 },
        [variants.GRAY] = { fg = colors.yellow.L60 }
    },
    ErrorMsg = {
        dark = { fg = colors.red.L60 },
        [variants.GRAY] = { fg = colors.red.L60 }
    },
    ModeMsg = {
        dark = { fg = colors.gray.L100 },
        [variants.GRAY] = { fg = colors.gray.L100 }
    },
    MoreMsg = {
        dark = { fg = colors.gray.L100 },
        [variants.GRAY] = { fg = colors.gray.L100 }
    },
    Todo = {
        dark = { fg = colors.purple.L60, bg = colors.gray.L0 },
        [variants.GRAY] = { fg = colors.purple.L60, bg = colors.gray.L0 },
    },
    Function = {
        dark = { fg = colors.gray.L100 },
        [variants.GRAY] = { fg = colors.gray.L100 }
    },
    Keyword = {
        dark = { fg = colors.gray.L100, bold = true },
        [variants.GRAY] = { fg = colors.gray.L100, bold = true }
    },
    Operator = {
        dark = { fg = colors.gray.L100 },
        [variants.GRAY] = { fg = colors.gray.L100 },
    },
    String = {
        dark = { fg = colors.green.L80 },
        [variants.GRAY] = { fg = colors.green.L80 },
    },
    Number = {
        dark = { fg = colors.green.L80 },
        [variants.GRAY] = { fg = colors.green.L80 },
    },
    Float = {
        dark = { fg = colors.green.L80 },
        [variants.GRAY] = { fg = colors.green.L80 },
    },
    PreProc = {
        dark = { fg = colors.red.L80 },
        [variants.GRAY] = { fg = colors.red.L80 },
    },
    Special = {
        dark = { fg = colors.gray.L100 },
        [variants.GRAY] = { fg = colors.gray.L100 },
    },
    SpecialKey = {
        dark = { fg = colors.cyan.L80 },
        [variants.GRAY] = { fg = colors.cyan.L80 },
    },
    Visual = {
        dark = { fg = colors.blue.L90, bg = colors.blue.L35 },
        [variants.GRAY] = { fg = colors.blue.L90, bg = colors.blue.L35 },
    },
    Search = {
        dark = { fg = colors.gray.L10, bg = colors.gray.L75 },
        [variants.GRAY] = { fg = colors.gray.L10, bg = colors.gray.L75 },
    },
    CurSearch = {
        dark = { fg = colors.gray.L0, bg = colors.gray.L100 },
        [variants.GRAY] = { fg = colors.gray.L0, bg = colors.gray.L100 },
    },
    IncSearch = {
        dark = { fg = colors.yellow.L10, bg = colors.yellow.L50 },
        [variants.GRAY] = { fg = colors.yellow.L10, bg = colors.yellow.L50 },
    },
}

local function apply_highlights(palette)
    local set = vim.api.nvim_set_hl
    for group_name, opts in pairs(palette) do
        set(0, group_name, opts)
    end
end

local function load()
    local bg
    if override ~= nil and override ~= "" then
        -- Use variant override if provided.
        bg = override
    else
        -- Or just use the background to pick. Dark is fallback.
        bg = vim.o.background or "dark"
    end

    local selected = {}
    for group_name, versions in pairs(themes) do
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
