-- A file finder for small projects.
-- When opened (with the FilePanel fn), you can immediately begin typing
-- to search.
--
-- Press q (as usual) to exit insert mode, and then use the usual bindings
-- to traverse the list. Press enter on a line to open the file.

local M = {}

local function should_skip(name, kind)
    if name:sub(1, 1) == "." then
        return true
    end

    if kind == "directory" then
        return
            name == ".git"
            or name == "target"
            or name == "build"
            or name == "dist"
    end

    return false
end

local function collect_files()
    local files = {}

    local function scan(dir)
        for name, kind in vim.fs.dir(dir) do
            if not should_skip(name, kind) then
                local path = dir .. "/" .. name

                if kind == "directory" then
                    scan(path)
                else
                    table.insert(
                        files,
                        vim.fn.fnamemodify(path, ":.")
                    )
                end
            end
        end
    end

    scan(vim.loop.cwd())

    table.sort(files)

    return files
end

local function fuzzy_match(pattern, text)
    pattern = pattern:lower()
    text = text:lower()

    local j = 1

    for i = 1, #text do
        if text:sub(i, i) == pattern:sub(j, j) then
            j = j + 1

            if j > #pattern then
                return true
            end
        end
    end

    return pattern == ""
end

local function render(buf)
    local state = vim.b[buf]

    local cursor = vim.api.nvim_win_get_cursor(0)

    local query = vim.api.nvim_buf_get_lines(
        buf,
        0,
        1,
        false
    )[1] or ""

    local lines = {
        query
    }

    local map = {}

    for _, file in ipairs(state.files) do
        if fuzzy_match(query, file) then
            table.insert(lines, file)
            map[#lines] = file
        end
    end

    vim.bo[buf].modifiable = true

    vim.api.nvim_buf_set_lines(
        buf,
        0,
        -1,
        false,
        lines
    )

    vim.bo[buf].modifiable = true

    vim.b[buf].file_map = map

    local win = vim.fn.bufwinid(buf)

    if win ~= -1 then
        local line = math.min(
            cursor[1],
            #lines
        )

        vim.api.nvim_win_set_cursor(win, {
            line,
            cursor[2],
        })
    end
end

function M.FilePanel()
    local origin_win = vim.api.nvim_get_current_win()

    local buf = vim.api.nvim_create_buf(false, true)

    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].swapfile = false
    vim.bo[buf].modifiable = true

    vim.b[buf].files = collect_files()

    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.6)

    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    vim.wo[win].cursorline = true

    render(buf)

    vim.api.nvim_create_autocmd("TextChangedI", {
        buffer = buf,
        callback = function()
            render(buf)
        end,
    })

    vim.api.nvim_create_autocmd("TextChanged", {
        buffer = buf,
        callback = function()
            render(buf)
        end,
    })

    vim.keymap.set({ "n", "i" }, "<CR>", function()
        local line = vim.api.nvim_win_get_cursor(win)[1]

        if line == 1 then
            return
        end

        local file = vim.b[buf].file_map[line]

        if file then
            vim.api.nvim_set_current_win(origin_win)
            vim.cmd.edit(vim.fn.fnameescape(file))
            vim.cmd.stopinsert()
        end

        vim.api.nvim_win_close(win, true)
    end, {
        buffer = buf,
        silent = true,
    })

    vim.keymap.set("n", "q", function()
        vim.api.nvim_win_close(win, true)
    end, {
        buffer = buf,
        silent = true,
    })

    vim.cmd.startinsert()
end

return M
