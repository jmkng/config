-- buffer.lua
--
-- This file implements a really tiny buffer switcher.
-- When opened, you may immediately press enter to switch to the previous buffer,
-- because the previous buffer will always be the item that the cursor starts on.
-- Move up/down and type enter to choose any buffer.
--
-- No "other window" stuff is supported. c:
local M = {}

function M.BufferPanel()
    -- This is the "origin" buffer represented by marker %.
    local origin_buf = vim.api.nvim_get_current_buf()
    local old_cursorline = vim.wo.cursorline

    -- Identify alternate file for window.
    -- If none, try picking from jumplist.
    local alt_buf = vim.fn.bufnr("#")
    if alt_buf == -1 or alt_buf == origin_buf then
        local jl = vim.fn.getjumplist()
        local jumplist, last_idx = jl[1], jl[2]
        for i = last_idx, 1, -1 do
            if jumplist[i] and jumplist[i].bufnr ~= origin_buf and vim.api.nvim_buf_is_valid(jumplist[i].bufnr) then
                print("found alt in jump list")
                alt_buf = jumplist[i].bufnr
                break
            end
        end
    end

    -- 2. Collect buffers
    local buffers = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
            local name = vim.api.nvim_buf_get_name(buf)
            table.insert(buffers, {
                bufnr = buf,
                name = (name ~= "" and vim.fn.fnamemodify(name, ":.") or "[No Name]")
            })
        end
    end
    table.sort(buffers, function(a, b) return a.name < b.name end)

    -- 3. Create Picker
    local picker_buf = vim.api.nvim_create_buf(false, true)
    -- Lines can be added to the front of this list
    -- to have them displayed at the top of the buffer.
    local lines = {}
    local buf_map = {}
    local cursor_line = 1

    for _, b in ipairs(buffers) do
        local line_nr = #lines + 1
        local mark = "  "
        if b.bufnr == origin_buf then mark = "% "
        elseif b.bufnr == alt_buf then mark = "# " end

        table.insert(lines, string.format("%s %s", mark, b.name))
        buf_map[line_nr] = b.bufnr
        if b.bufnr == alt_buf then cursor_line = line_nr end
    end

    vim.api.nvim_buf_set_lines(picker_buf, 0, -1, false, lines)

    -- 4. Setup Picker Buffer Options
    vim.bo[picker_buf].buftype = "nofile"
    vim.bo[picker_buf].bufhidden = "wipe"
    vim.bo[picker_buf].modifiable = false
    vim.b[picker_buf].buf_map = buf_map
    vim.b[picker_buf].origin_buf = origin_buf -- Store the origin to restore history later
    vim.api.nvim_buf_set_name(picker_buf, "Buffers")

    -- 5. Show Picker
    vim.api.nvim_set_current_buf(picker_buf)
    vim.wo.cursorline = true
    vim.api.nvim_win_set_cursor(0, { cursor_line, 3 })

    vim.api.nvim_create_autocmd({ "BufWinLeave", "BufWipeout" }, {
        buffer = picker_buf,
        once = true,
        callback = function()
            vim.wo.cursorline = old_cursorline
        end,
    })

    -- 6. The "Magic" Switch Logic
    vim.keymap.set("n", "<CR>", function()
        local line = vim.api.nvim_win_get_cursor(0)[1]
        local target = vim.b.buf_map[line]
        local prev = vim.b.origin_buf

        if target then
            -- We delete the picker first so it's not in the history
            vim.api.nvim_command("bwipeout")

            -- Set the target buffer
            vim.api.nvim_set_current_buf(target)

            -- MANUALLY SET ALTERNATE:
            -- This makes the 'origin_buf' the '#' for the new 'target'
            vim.fn.setreg('#', prev)
        end
    end, { buffer = picker_buf, silent = true })

    vim.keymap.set("n", "q", "<cmd>bwipeout<CR>", { buffer = picker_buf })
end

return M
