vim.api.nvim_create_user_command("Config", function()
    vim.cmd("edit " .. vim.fn.stdpath("config") .. "/")
end, { desc = "Edit editor configuration" })
vim.api.nvim_create_user_command("Reload", function()
    vim.cmd("luafile $MYVIMRC")
    if vim.g.colors_name then
        vim.cmd("colorscheme " .. vim.g.colors_name)
    end
    -- Would be nice to have a way to reload treesitter queries,
    -- not sure how to make that work.
end, { desc = "Reload editor configuration" })
vim.api.nvim_create_user_command('Keymap', function()
    vim.cmd("edit " .. vim.fn.stdpath("config") .. "/" .. "lua" .. "/" .. "keymap.lua") 
end, { desc = "Edit editor user keymap" })
vim.api.nvim_create_user_command('Command', function()
    vim.cmd("edit " .. vim.fn.stdpath("config") .. "/" .. "lua" .. "/" .. "command.lua") 
end, { desc = "Edit editor user commands" })
local ultrasight = require('ultrasight')
vim.api.nvim_create_user_command('UltrasightServe', function()
    ultrasight.toggle()
end, { desc = "Start an Ultrasight server" })
vim.api.nvim_create_user_command('UltrasightListen', function()
    ultrasight.listen()
end, { desc = "Listen for Ultrasight messages" })
