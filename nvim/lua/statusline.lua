vim.o.statusline = table.concat({
    "%#StatusLineFileName#%f%*",
    "%m",
    "%r",
    "%=",
    "%l(%p%%),%c",
    --"%#StatusLineQuickfix#%{v:lua.set_quickfix_status()}%*",
}, " ")
