vim.o.statusline = table.concat({
    "%#StatusLineFileName#%f %*",
    "%#StatusLineChanged#%m%*",
    "%r",
    "%#StatusLineMode# *%{mode()}* %*",
    "%=",
    "%l(%p%%),%c",
    --"%#StatusLineQuickfix#%{v:lua.set_quickfix_status()}%*",
}, " ")
