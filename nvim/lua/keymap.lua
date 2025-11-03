vim.keymap.set('n', '<C-b>n', ':bnext<CR>', { desc = "Move to next buffer" })
vim.keymap.set('n', '<C-b>p', ':bprev<CR>', { desc = "Move to previous buffer" })
vim.keymap.set('n', '<C-b>d', ':bd<CR>', { desc = "Delete current buffer" })

vim.keymap.set('n', '<C-w><C-c>', ':close<CR>', {})
vim.keymap.set('n', '<C-w>v', ':vnew<CR>', {})
vim.keymap.set('n', '<C-w><C-v>', ':vnew<CR>', {})

vim.keymap.set('n', 'grd', vim.lsp.buf.definition, {})
vim.keymap.set("n", "grf", function()
    vim.lsp.buf.format { async = true }
end, { desc = "Format current buffer" })
vim.keymap.set('n', 'grhc', function()
    vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor" })
end)
vim.keymap.set('n', 'grhl', function()
    vim.diagnostic.open_float(nil, { focusable = false, scope = "line" })
end)
vim.keymap.set('n', 'grhb', function()
    vim.diagnostic.open_float(nil, { focusable = false, scope = "buffer" })
end)

vim.keymap.set('n', '<leader>!', function()
    local last_cmd = vim.fn.getreg(':')
    if last_cmd ~= '' then
        vim.api.nvim_feedkeys(":" .. last_cmd .. "!\n", 'n', false)
    else
        vim.notify("no previous Ex command", vim.log.levels.INFO, {})
    end
end, { desc = "Repeat last Ex command with ! (force) behavior" })
vim.keymap.set('n', '<leader>e', function()
    if vim.bo.filetype == 'netrw' then
        vim.cmd('bd')
    else
        vim.cmd('Explore')
    end
end, { desc = "Toggle netrw" })
vim.keymap.set('n', '<leader>c', function()
    vim.o.cursorline = not vim.o.cursorline
    vim.notify("cursorline " .. (vim.o.cursorline and "on" or "off"), vim.log.levels.INFO, {})
end, { desc = "Toggle cursorline" })
vim.keymap.set('n', '<leader>s', ':up<CR>', { desc = "Write buffer (if modified)" })
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { desc = "Yank to system clipboard with \"+y" })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = "Yank to system clipboard with \"+Y" })
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p', { desc = "Paste from system clipboard with \"+p" })
vim.keymap.set('n', '<leader>P', '"+P', { desc = "Paste from system clipboard with \"+P" })
vim.keymap.set('n', '<leader>/', ':nohlsearch<CR>')
vim.keymap.set('n', '<leader>f', ':Pick files<Cr>')
local ultrasight = require('ultrasight')
vim.keymap.set('n', '<leader>u', function()
    ultrasight.toggle()
end, { noremap = true })
