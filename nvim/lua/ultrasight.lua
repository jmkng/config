local M = {}

M.enabled = false
M.config = {
    socket_path = nil,
    delay = 500,
}

local server
local clients = {}
local hover_timer

function M.setup(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})
end

local function broadcast(text)
    for _, client in ipairs(clients) do
        if not client:is_closing() then
            client:write(text)
        end
    end
end

local last_hover = ""
local function show_hover_or_signature()
    local params = vim.lsp.util.make_position_params(0, 'utf-8')
    local bufnr = 0

    local sent_message = false
    vim.lsp.buf_request(0, "textDocument/hover", params, function(err, result)
        if err or not (result and result.contents) then return end

        local lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
        lines = vim.lsp.util.trim_empty_lines(lines)
        if vim.tbl_isempty(lines) then return end
        local text = table.concat(lines, "\n")

        if text ~= last_hover then
            sent_message = true
            last_hover = text
            broadcast(text)
        end
    end)

    if sent_message then
        return

            vim.lsp.buf_request(bufnr, "textDocument/signatureHelp", params, function(err, result)
                if err or not result or not result.signatures or #result.signatures == 0 then
                    return
                end

                local lines = {}
                for _, sig in ipairs(result.signatures) do
                    table.insert(lines, sig.label)
                    if sig.documentation then
                        local doc_lines = vim.lsp.util.convert_input_to_markdown_lines(sig.documentation)
                        vim.list_extend(lines, vim.lsp.util.trim_empty_lines(doc_lines))
                    end
                end

                if #lines == 0 then return end

                local text = table.concat(lines, "\n")
                if text == last_hover then return end
                last_hover = text

                sent_message = true
                broadcast(text)

                -- Update buffer immediately?

                -- local buf = your_viewer_buf
                -- vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
                -- vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                -- vim.lsp.util.stylize_markdown(buf, lines)
                -- vim.api.nvim_win_set_cursor(0, { 1, 0 })
            end)
    end
end

local function show_hover_debounced()
    if not hover_timer then
        hover_timer = vim.loop.new_timer()
    else
        hover_timer:stop() -- reset timer
    end

    hover_timer:start(M.config.delay, 0, vim.schedule_wrap(function()
        show_hover_or_signature()
    end))
end

local function notify_change()
    vim.api.nvim_exec_autocmds("User", { pattern = "UltrasightMode" })
end

local GROUP_NAME = "ultrasight"

function M.enable()
    if M.enabled then return end

    if not M.config.socket_path then
        vim.notify("[ultrasight] no socket path configured", vim.log.levels.ERROR)
        return
    end

    server = vim.uv.new_pipe(false)
    server:bind(M.config.socket_path)
    server:listen(5, function(err)
        if err then return end
        local client = vim.uv.new_pipe(false)
        server:accept(client)
        table.insert(clients, client)
    end)

    --pipe:connect(M.config.socket_path, function(err)
    --    if err then
    --        vim.schedule(function()
    --            vim.notify("[ultrasight] failed to connect to socket: " .. err, vim.log.levels.ERROR)
    --        end)
    --        return
    --    end
    --    vim.schedule(function()
    --        vim.notify("[ultrasight] socket connected to: " .. M.config.socket_path, vim.log.levels.INFO)
    --    end)
    --end)

    M.enabled = true

    id = vim.api.nvim_create_augroup(GROUP_NAME, { clear = true })
    -- Normal mode events
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorHold" }, {
        group = id,
        callback = show_hover_debounced,
    })
    -- Insert mode events
    vim.api.nvim_create_autocmd({ "CursorMovedI", "CursorHoldI" }, {
        group = id,
        callback = show_hover_debounced,
    })

    vim.notify("[ultrasight] connected to: " .. M.config.socket_path, vim.log.levels.INFO)
    notify_change()
end

function M.disable()
    if not M.enabled then return end

    if hover_timer then
        hover_timer:stop()
        hover_timer:close()
        hover_timer = nil
    end

    for _, client in ipairs(clients) do
        if not client:is_closing() then
            client:shutdown(); client:close()
        end
    end
    clients = {}

    if server and not server:is_closing() then
        server:close()
        server = nil
    end

    if M.config.socket_path then
        os.remove(M.config.socket_path)
    end

    M.enabled = false

    vim.api.nvim_del_augroup_by_name(GROUP_NAME)
    vim.notify("[ultrasight] disconnected from: " .. M.config.socket_path, vim.log.levels.INFO)
    notify_change()
end

function M.listen()
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_name(buf, "[ULTRA IN]")
    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
    vim.api.nvim_win_set_buf(0, buf)

    local pipe = vim.uv.new_pipe(false)
    pipe:connect(M.config.socket_path, function(err)
        if err then
            vim.schedule(function()
                vim.notify("[ultrasight] failed to connect: " .. err, vim.log.levels.ERROR)
            end)
            return
        end
    end)

    pipe:read_start(function(err, data)
        if err or not data then return end
        vim.schedule(function()
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
            local lines = vim.split(data, "\n")
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
            vim.lsp.util.stylize_markdown(buf, lines)
            vim.api.nvim_win_set_cursor(0, { 1, 0 })
        end)
    end)

    vim.notify("[ultrasight] listening")
end

function M.toggle()
    if M.enabled then M.disable() else M.enable() end
end

return M
