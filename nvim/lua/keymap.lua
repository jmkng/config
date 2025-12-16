vim.keymap.set("n", '<C-b>n', ':bnext<CR>', { desc = "Move to next buffer" })
vim.keymap.set("n", '<C-b><C-n>', ':bnext<CR>', { desc = "Move to next buffer" })
vim.keymap.set("n", '<C-b>p', ':bprev<CR>', { desc = "Move to previous buffer" })
vim.keymap.set("n", '<C-b><C-p>', ':bprev<CR>', { desc = "Move to previous buffer" })
vim.keymap.set("n", '<C-b>d', ":bd<CR>", { desc = "Delete current buffer" })
vim.keymap.set("n", '<C-b><C-d>', ':bd<CR>', { desc = "Delete current buffer" })
vim.keymap.set("n", '<C-w>c', ':close<CR>', { desc = "Close window" })
vim.keymap.set("n", '<C-w><C-c>', ':close<CR>', { desc = "Close window" })
vim.keymap.set("n", '<C-h>', '<C-w>h', { desc = "Move window left" })
vim.keymap.set("n", '<C-j>', '<C-w>j', { desc = "Move window down" })
vim.keymap.set("n", '<C-k>', '<C-w>k', { desc = "Move window up" })
vim.keymap.set("n", '<C-l>', '<C-w>l', { desc = "Move window right" })
vim.keymap.set("n", 'grd', vim.lsp.buf.definition, {})
vim.keymap.set("n", "grf", function()
    vim.lsp.buf.format { async = true }
end, { desc = "Format current buffer" })
vim.keymap.set('n', 'grhc', function()
    vim.diagnostic.open_float(nil, { focusable = false, scope = "cursor", border = 'rounded' })
end)
vim.keymap.set('n', 'grhl', function()
    vim.diagnostic.open_float(nil, { focusable = false, scope = "line", border = 'rounded' })
end)
vim.keymap.set('n', 'grhb', function()
    vim.diagnostic.open_float(nil, { focusable = false, scope = "buffer", border = 'rounded' })
end)
vim.keymap.set('n', 'K', function()
    vim.lsp.buf.hover({ border = 'rounded', focusable = true })
end)
vim.keymap.set('n', 's', function()
    vim.cmd("update")
end)
vim.keymap.set('n', '<C-;>', ':<C-f>', { desc = "Jump to command history window" })
vim.keymap.set("i", "<Tab>", function()
    local col = vim.fn.col('.')
    if col <= 1 then
        return "\t"
    end

    local prev_char = vim.fn.getline("."):sub(col - 1, col - 1)
    if prev_char:match("%s") then
        return "\t"
    end

    vim.lsp.omnifunc(0, 0)
end, { expr = true })
vim.keymap.set('i', '<C-s>', function()
    vim.lsp.buf.signature_help({ scope = "buffer", border = 'rounded' })
end)
vim.keymap.set('i', '<C-h>', '<Left>', { desc = "Move left" })
vim.keymap.set('i', '<C-j>', '<C-o>j', { desc = "Move down" })
vim.keymap.set('i', '<C-k>', '<C-o>k', { desc = "Move Up" })
vim.keymap.set('i', '<C-l>', "<Right>", { desc = "Move right" })
vim.keymap.set('i', '<C-w>', function()
    vim.cmd("normal! w")
end, { desc = "Move forward to beginning of word" })
-- vim.keymap.set('i', '<C-e>', "<C-o>e<C-o>a", { desc = "Move forward to end of word" })
vim.keymap.set('i', '<C-b>', function()
    vim.cmd("normal! b")
end, { desc = "Move backward to beginning of word" })
-- vim.keymap.set('i', '<C-v>', '<Esc>gea', { desc = "Move backward to end of word" })
vim.keymap.set('i', '<C-BS>', '<C-G>u<C-W>', { desc = "Delete previous word" })
-- vim.keymap.set('i', '<C-;>', '<C-o>;', { desc = "Repeat last action" })
-- vim.keymap.set('i', '<C-,>', '<C-o>,', { desc = "Repeat last action" })
vim.keymap.set('i', '<C-a>', '<C-o>^', { desc = "Move to beginning of line" })
vim.keymap.set('i', '<C-e>', '<C-o>$', { desc = "Move to end of line" })
vim.keymap.set('i', '<C-d>', '<C-o>x', { desc = "Delete one character ahead" })
-- vim.keymap.set('i', '<C-2>', '<C-o>@:', { desc = "Repeat last macro" })
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
end, { desc = "Toggle netrw (:Ex)" })
vim.keymap.set('n', '<leader>i', ':Inspect<CR>', { desc = "Inspect under cursor" })
vim.keymap.set('n', '<leader>r', ":Reload<CR>", { desc = "Reload configuration" })
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { desc = "Yank to system clipboard with \"+y" })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = "Yank to system clipboard with \"+Y" })
vim.keymap.set({ 'n', 'x' }, '<leader>x', '"+x', { desc = "Delete to system clipboard with \"+x" })
vim.keymap.set('n', '<leader>X', '"+X', { desc = "Delete to system clipboard with \"+X" })
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p', { desc = "Paste from system clipboard with \"+p" })
vim.keymap.set('n', '<leader>P', '"+P', { desc = "Paste from system clipboard with \"+P" })
vim.keymap.set('n', '<leader>/', ':nohlsearch<CR>')
local function SwitchBufferByNumber()
    local buffers = {}
    local current_buf = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local name = vim.api.nvim_buf_get_name(buf)
        if vim.bo[buf].buflisted and name ~= "" then
            local display_name = vim.fn.fnamemodify(name, ":.")
            table.insert(buffers, {
                bufnr = buf,
                name = display_name,
                is_current = buf == current_buf,
                list_idx = vim.fn.bufnr(buf),
            })
        end
    end

    table.sort(buffers, function(a, b)
        return a.bufnr < b.bufnr
    end)

    local list_str = "Buffers:\n"
    local choice_map = {}

    for i, buf_info in ipairs(buffers) do
        local display_idx = string.format("%2d", i) -- Format index to 2 characters, right aligned.
        local current_mark = buf_info.is_current and "A" or " "
        local bufnr_ref = string.format("(%d)", buf_info.list_idx)
        local line = string.format("%s%s: %s %s\n", current_mark, display_idx, buf_info.name, bufnr_ref)
        list_str = list_str .. line
        choice_map[i] = buf_info.bufnr
    end

    local choice = vim.fn.input(list_str .. "\nPress enter without typing to cancel.\nEnter buffer number to switch: ")
    local num = tonumber(choice)

    if num and choice_map[num] then
        vim.api.nvim_set_current_buf(choice_map[num])
    else
        if choice ~= nil and choice ~= "" then
            vim.notify("Canceled buffer switch: " .. choice, vim.log.levels.WARN, { title = "Buffer Switcher" })
        end
    end
end
vim.keymap.set('n', '<leader>b', SwitchBufferByNumber, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>m', function()
    vim.cmd('messages')
end, { noremap = true })
vim.keymap.set('n', '<leader>c', function()
    vim.cmd("close")
end, { desc = "Close window" })
-- vim.keymap.set('n', '<leader>o', function()
--     vim.cmd("only")
-- end, { desc = "Make current window the only window" })
-- vim.keymap.set('n', '<leader>s', function()
--     vim.cmd("split")
-- end, { desc = "Split window" })
-- vim.keymap.set('n', '<leader>ns', function()
--     vim.cmd("new")
-- end, { desc = "Split blank window" })
-- vim.keymap.set('n', '<leader>v', function()
--     vim.cmd("vsplit")
-- end, { desc = "Split window vertically" })
-- vim.keymap.set('n', '<leader>nv', function()
--     vim.cmd("vnew")
-- end, { desc = "Split blank window vertically" })
-- Vim.keymap.set('n', '<leader>w', '<C-w>', { desc = "Shortcut for <C-w>" })
-- vim.keymap.set('n', '<leader>t', function()
--     vim.cmd("b#")
-- end, { desc = "Move to previous buffer" })
