vim.api.nvim_create_user_command("ConfigReload", function()
    vim.cmd("luafile $MYVIMRC")
    if vim.g.colors_name then
        vim.cmd("colorscheme " .. vim.g.colors_name)
    end
    -- Would be nice to have a way to reload treesitter queries,
    -- not sure how right now.
end, { desc = "Reload editor configuration" })
vim.api.nvim_create_user_command("ConfigEdit", function()
    -- Open a new tab or window in your config directory
    vim.cmd("edit " .. vim.fn.stdpath("config") .. "/")
end, { desc = "Edit editor configuration" })
