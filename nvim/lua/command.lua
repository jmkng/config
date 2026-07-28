vim.api.nvim_create_user_command("Config", function()
    vim.cmd.edit(vim.fs.joinpath(vim.fn.stdpath("config"), "init.lua"))
end, { desc = "Edit config" })

vim.api.nvim_create_user_command('Keymap', function()
    vim.cmd.edit(vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "keymap.lua"))
end, { desc = "Edit keymap" })

vim.api.nvim_create_user_command('Commands', function()
    vim.cmd.edit(vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "command.lua"))
end, { desc = "Edit commands" })

vim.api.nvim_create_user_command("Notes", function()
    local dir = vim.env.NOTES_DIR
    if not dir then
        vim.notify("NOTES_DIR is not set", vim.log.levels.ERROR)
        return
    end

    vim.cmd.edit(dir)
    vim.cmd.tcd(dir)
end, {})

vim.api.nvim_create_user_command('TrimWhitespace', function()
    vim.cmd([[%s/\s\+$//e]])
end, { desc = "Trim whitespace in current buffer" })
