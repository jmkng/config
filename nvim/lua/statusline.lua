_G.statusline_mode = function()
  local m = vim.api.nvim_get_mode().mode
  local map = {
    n  = "NOR",
    i  = "INS",
    v  = "VIS",
    V  = "VIL",
    ["\22"] = "VIB",
    c  = "CMD",
  }
  return map[m] or m
end


vim.o.statusline = table.concat({
    "%#StatusLineMode# %{v:lua.statusline_mode()} %*",
    "%#StatusLineFileName#%f %*",
    "%#StatusLineChanged#%m%*",
    "%r",
    -- "%#StatusLineMode# *%{mode()}* %*",
    "%=",
    "%l(%p%%),%c",
    --"%#StatusLineQuickfix#%{v:lua.set_quickfix_status()}%*",
}, " ")
