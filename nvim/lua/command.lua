vim.api.nvim_create_user_command("Config", function()
    vim.cmd("edit " .. vim.fn.stdpath("config") .. "/" .. "init.lua")
end, { desc = "Edit editor configuration" })
vim.api.nvim_create_user_command('Keymap', function()
    vim.cmd("edit " .. vim.fn.stdpath("config") .. "/" .. "lua" .. "/" .. "keymap.lua")
end, { desc = "Edit editor user keymap" })
vim.api.nvim_create_user_command('Command', function()
    vim.cmd("edit " .. vim.fn.stdpath("config") .. "/" .. "lua" .. "/" .. "command.lua")
end, { desc = "Edit editor user commands" })
vim.api.nvim_create_user_command("Reload", function()
    vim.cmd("luafile $MYVIMRC")
    if vim.g.colors_name then
        vim.cmd("color " .. vim.g.colors_name)
    end
    -- Would be nice to have a way to reload treesitter queries,
    -- not sure how to make that work.
end, { desc = "Reload editor configuration" })
vim.api.nvim_create_user_command('Trim', function()
    vim.cmd([[%s/\s\+$//e]])
end, { desc = "Trim whitespace in current buffer" })

vim.api.nvim_create_user_command('CursorLine', function()
    vim.o.cursorline = not vim.o.cursorline
end, { desc = " cursorline" })
vim.api.nvim_create_user_command('CursorColumn', function()
    vim.o.cursorcolumn = not vim.o.cursorcolumn
end, { desc = " vertical cursorline" })
vim.api.nvim_create_user_command('LineNumber', function()
    vim.wo.number = not vim.wo.number
end, { desc = " line numbers" })
vim.api.nvim_create_user_command('SignColumn', function()
    if vim.wo.signcolumn == "yes" then
        vim.wo.signcolumn = "no"
    else
        vim.wo.signcolumn = "yes"
    end
end, { desc = "Toggle sign column" })
vim.api.nvim_create_user_command('ColorColumn', function(opts)
    if opts.args == "" then
        vim.o.colorcolumn = ""
    else
        vim.o.colorcolumn = opts.args
    end
end, {
    desc = "Set or  color column",
    nargs = "?"
})
vim.api.nvim_create_user_command('', function()
    vim.cmd([[%s/\s\+$//e]])
end, { desc = "Trim whitespace in current buffer" })
local ultrasight = require('ultrasight')
vim.api.nvim_create_user_command('UltrasightVirtualTextDiagnostics', function(opts)
    ultrasight.toggle_virtual_text_diagnostics(opts.args)
end, { nargs = "?" })
vim.api.nvim_create_user_command('UltrasightVirtualTextSignatureHelp', function(opts)
    ultrasight.toggle_virtual_text_signature_help(opts.args)
end, { nargs = "?" })
