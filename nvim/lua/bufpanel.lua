-- This file implements a really tiny buffer switcher.
-- When opened, you may immediately type enter to switch to the previous buffer,
-- because the previous buffer will always be the item that the cursor starts on.
-- Move up/down and type enter to choose any buffer.

local M = {}

local function find_alternate(origin_buf)
    local alt = vim.fn.bufnr("#")

    if alt ~= -1 and alt ~= origin_buf and vim.api.nvim_buf_is_valid(alt) then
        return alt
    end

    -- Fall back to jumplist.
    local jl = vim.fn.getjumplist()
    local jumplist, last_idx = jl[1], jl[2]

    for i = last_idx, 1, -1 do
        local entry = jumplist[i]
        if entry
            and entry.bufnr ~= origin_buf
            and vim.api.nvim_buf_is_valid(entry.bufnr)
        then
            return entry.bufnr
        end
    end

    return -1
end

local function collect_buffers()
    local buffers = {}

    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
            local name = vim.api.nvim_buf_get_name(buf)

            table.insert(buffers, {
                bufnr = buf,
                name = name ~= "" and vim.fn.fnamemodify(name, ":.") or "[No Name]",
            })
        end
    end

    table.sort(buffers, function(a, b)
        return a.name < b.name
    end)

    return buffers
end

local function render_picker(buf)
    vim.notify("Close with q", vim.log.levels.INFO)

    local origin = vim.b[buf].origin_buf
    local alt = vim.b[buf].alt_buf

    local buffers = collect_buffers()

    local lines = {}
    local map = {}
    local cursor_line = 1

    for _, b in ipairs(buffers) do
        local mark = "  "

        if b.bufnr == origin then
            mark = "% "
        elseif b.bufnr == alt then
            mark = "# "
            cursor_line = #lines + 1
        end

        table.insert(lines, string.format("%s %s", mark, b.name))
        map[#lines] = b.bufnr
    end

    -- table.insert(lines, "")
    -- table.insert(lines, "<CR> open   d delete   D force delete   r Refresh   q close")

    local win = vim.fn.bufwinid(buf)
    local old_line = 1

    if win ~= -1 then
        old_line = vim.api.nvim_win_get_cursor(win)[1]
    end

    vim.bo[buf].modifiable = true
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].modifiable = false

    vim.b[buf].buf_map = map

    if win ~= -1 then
        local line

        if old_line <= #lines then
            line = old_line
        else
            line = math.max(1, #lines)
        end

        if vim.b[buf].first_render then
            line = cursor_line
            vim.b[buf].first_render = false
        end

        vim.api.nvim_win_set_cursor(win, { line, 3 })
    end
end

local function replacement_buffer(picker, current)
    -- Prefer the alternate buffer that was recorded when the picker opened.
    local alt = vim.b[picker].alt_buf

    if alt
        and alt > 0
        and alt ~= current
        and vim.api.nvim_buf_is_valid(alt)
        and vim.api.nvim_buf_is_loaded(alt)
        and vim.bo[alt].buflisted
    then
        return alt
    end

    -- Otherwise pick any other listed one.
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if buf ~= current
            and vim.api.nvim_buf_is_loaded(buf)
            and vim.bo[buf].buflisted
        then
            return buf
        end
    end

    return nil
end

local function confirm_delete(buf)
    if not vim.bo[buf].modified then
        return true
    end

    local name = vim.api.nvim_buf_get_name(buf)

    if name == "" then
        name = "[No Name]"
    else
        name = vim.fn.fnamemodify(name, ":.")
    end

    local choice = vim.fn.confirm(
        "Buffer has unsaved changes:\n" .. name .. "\n\nDelete anyway?",
        "&Yes\n&No",
        2
    )

    return choice == 1
end

local function delete_selected(force)
    local picker = vim.api.nvim_get_current_buf()
    local state = vim.b[picker]

    local line = vim.api.nvim_win_get_cursor(0)[1]
    local target = state.buf_map[line]

    -- Try it.
    if (not target) or (not force and not confirm_delete(target)) then
        return
    end

    if vim.bo[target].modified then
        force = true
    end

    -- Deleting the current buffer.
    --
    if target == state.origin_buf then
        local replacement = replacement_buffer(picker, target)

        if replacement then
            vim.api.nvim_win_set_buf(state.origin_win, replacement)
        else
            vim.api.nvim_win_call(state.origin_win, function()
                vim.cmd("enew")
            end)
        end

        local ok, err = pcall(vim.api.nvim_buf_delete, target, {
            force = force,
        })

        if not ok then
            vim.notify(err or "Failed to delete buffer.", vim.log.levels.ERROR)
            return
        end

        state.origin_buf = vim.api.nvim_win_get_buf(state.origin_win)
        state.alt_buf = find_alternate(state.origin_buf)

        render_picker(picker)
        return
    end

    -- Deleting non-current buffer.
    local ok, err = pcall(vim.api.nvim_buf_delete, target, {
        force = force,
    })

    if not ok then
        vim.notify(err or "Failed to delete buffer.", vim.log.levels.ERROR)
        return
    end

    render_picker(picker)
end

function M.BufferPanel()
    local origin_win = vim.api.nvim_get_current_win()
    local origin_buf = vim.api.nvim_win_get_buf(origin_win)
    local alt_buf = find_alternate(origin_buf)

    local picker = vim.api.nvim_create_buf(false, true)

    vim.bo[picker].buftype = "nofile"
    vim.bo[picker].bufhidden = "wipe"
    vim.bo[picker].swapfile = false
    vim.bo[picker].modifiable = false

    vim.api.nvim_buf_set_name(picker, "Buffers")

    vim.b[picker].origin_win = origin_win
    vim.b[picker].origin_buf = origin_buf
    vim.b[picker].alt_buf = alt_buf
    vim.b[picker].first_render = true

    local width = math.floor(vim.o.columns * 0.5)
    local height = math.floor(vim.o.lines * 0.5)

    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local win = vim.api.nvim_open_win(picker, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    vim.b[picker].picker_win = win
    vim.wo[win].cursorline = true

    render_picker(picker)

    vim.api.nvim_create_autocmd({
        "BufAdd",
        "BufDelete",
        "BufWipeout",
    }, {
        buffer = picker,
        callback = function()
            if vim.api.nvim_buf_is_valid(picker) then
                render_picker(picker)
            end
        end,
    })

    vim.keymap.set("n", "<CR>", function()
        local line = vim.api.nvim_win_get_cursor(0)[1]
        local target = vim.b[picker].buf_map[line]

        if not target then
            return
        end

        if vim.api.nvim_win_is_valid(origin_win) then
            vim.api.nvim_win_set_buf(origin_win, target)
        end

        vim.api.nvim_win_close(win, true)
    end, {
        buffer = picker,
        silent = true,
    })

    vim.keymap.set("n", "d", function()
        delete_selected(false)
    end, {
        buffer = picker,
        silent = true,
    })

    vim.keymap.set("n", "D", function()
        delete_selected(true)
    end, {
        buffer = picker,
        silent = true,
    })

    vim.keymap.set("n", "r", function()
        render_picker(picker)
    end, {
        buffer = picker,
        silent = true,
    })

    vim.keymap.set("n", "q", function()
        vim.api.nvim_win_close(win, true)
    end, {
        buffer = picker,
        silent = true,
    })
end

return M
