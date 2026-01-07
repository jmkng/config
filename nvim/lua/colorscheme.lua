vim.o.termguicolors = true

local function dark_bool_to_string(val)
    if val then return "dark" else return "light" end
end

local function _is_dark_macos()
    local handle = io.popen('defaults read -g AppleInterfaceStyle 2>/dev/null')
    if handle == nil then return end
    local result = handle:read("*a")
    handle:close()
    return result:match("Dark") ~= nil
end

local function is_dark()
    local d = true -- Dark default
    if vim.uv.os_uname().sysname == "Darwin" then
        d = _is_dark_macos()
        vim.notify("detected os: Darwin, using " .. dark_bool_to_string(d) .. " theme", vim.log.levels.INFO);
    end
    return d
end

if is_dark() then
    vim.o.background = "dark"
    vim.cmd.colorscheme("soot")
else
    vim.o.background = "light"
    vim.cmd.colorscheme("snow")
end
