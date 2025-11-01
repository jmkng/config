-- Move to symbol definition. No builtin in 0.11 for this?
-- This *was* grd. It not overwrites the built-in "gd" which seems
-- to do the same thing, but worse.
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
-- LSP hover.
-- Does not change default bind, but adds additional close events,
-- otherwise it won't go away when switching buffers. (0.11.3)
-- vim.keymap.set('n', 'K', function()
--     vim.lsp.buf.hover({
--         border = 'rounded',
--         --close_events = { 'CursorMoved', 'BufLeave', 'WinLeave' },
--         focusable = true,
--     })
-- end)
-- Remap diagnostic float.
-- vim.keymap.set('n', 'grh', function()
--     -- Currently diag.lua runs the same command after a timeout.
--     -- If these two commands differ you may start to see a jitter as the window changes.
--     -- Maybe just create a function for this somewhere of the automatic diag window sticks around.
--     vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor" })
-- end)


-- Diagnostic next/prev + float.
-- Doesn't change the default keybindings, but allows for n/shift-n to continue.
-- vim.keymap.set('n', ']d', function()
--     vim.diagnostic.jump({ count = 1, float = true })
-- end)
-- vim.keymap.set('n', '[d', function()
--     vim.diagnostic.jump({ count = -1, float = true })
-- end)
vim.keymap.set('n', '<S-tab>', ':Explore<CR>')
vim.keymap.set('n', '@@', '@:')            -- Repeat last ex command.
vim.keymap.set('n', '`', '<C-w>w')         -- Forward/backward window toggle.
vim.keymap.set('n', '~', '<C-w>W')
vim.keymap.set('n', '<S-h>', ':bprev<CR>') -- Forward/backward buffer toggle.
vim.keymap.set('n', '<S-l>', ':bnext<CR>')
vim.keymap.set('n', '<leader>s', ':up<CR>')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')
local window_opts = { noremap = true }
vim.keymap.set('n', '<C-S-h>', ':vertical resize -2<CR>', window_opts)
vim.keymap.set('n', '<C-+>', ':vertical resize +2<CR>', window_opts)
vim.keymap.set('n', '<C-S-k>', ':resize -2<CR>', window_opts)
vim.keymap.set('n', '<C-S-j>', ':resize +2<CR>', window_opts)
vim.keymap.set('n', '<C-S-=>', '<C-w>=', window_opts)
vim.keymap.set('n', '<leader>x', ':nohlsearch<CR>')
-- vim.keymap.set('v', '<leader>y', '"+y')
-- vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '!', ':!', { noremap = true })
vim.keymap.set('n', '<leader>f', ':Pick files<Cr>')
vim.keymap.set("n", "<leader>gf", function()
    vim.lsp.buf.format { async = true }
end, { desc = "Format current buffer" })
vim.keymap.set('n', '<leader>r', function()
    vim.cmd("ConfigReload")
end, { noremap = true })
vim.keymap.set('n', '<leader>l', function()
    vim.o.cursorline = not vim.o.cursorline
    vim.notify("cursorline: " .. (vim.o.cursorline and "on" or "off"), vim.log.levels.INFO, {})
end)
vim.keymap.set('t', '<C-space>', function()
    local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true)
    vim.api.nvim_feedkeys(keys, "n", true)
    vim.cmd('bd!')
end, { noremap = true })
vim.keymap.set('n', '<C-space>', function()
    vim.cmd('terminal')
    vim.api.nvim_feedkeys("i", "n", false)
end, { noremap = true })
local ultrasight = require('ultrasight')
vim.keymap.set('n', '<leader>u', function()
    ultrasight.toggle()
end, { noremap = true })
