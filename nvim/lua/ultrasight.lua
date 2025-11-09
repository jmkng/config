local M = {}

local GROUP_NAME = 'ultrasight'

function M.dispatch_contextual()
  vim.lsp.buf.signature_help()
end

function M.setup()
  local id = vim.api.nvim_create_augroup(GROUP_NAME, { clear = true })

  -- Trigger immediately on entering insert mode, on idle, or when moving cursor in insert mode
  vim.api.nvim_create_autocmd({ "InsertEnter", "CursorHoldI", "CursorMovedI" }, {
    group = id,
    callback = M.dispatch_contextual,
  })

  -- Optional: auto-close signature window on leaving insert mode or buffer
  vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave" }, {
    group = id,
    callback = function()
      -- the built-in signature_help window closes automatically on CursorMoved,
      -- but you could also force close here if needed
    end,
  })
end

--local function write_text_to_clients(text)
--    for _, client in ipairs(clients) do
--        if not client:is_closing() then
--            client:write(text)
--        else
--            vim.notify("[ultrasight] skipped a closing client", vim.log.levels.DEBUG)
--        end
--    end
--end
--
--local last_hover = ""
--
--local function trigger_contextual()
--    local mode = vim.api.nvim_get_mode().mode
--    local params = vim.lsp.util.make_position_params(0, 'utf-8')
--    if mode == 'i' then
--        vim.lsp.buf_request(0, "textDocument/signatureHelp", params, function(err1, result_sig, _, _)
--            if err1 or not result_sig or not result_sig.signatures or #result_sig.signatures == 0 then return end
--
--            local lines2 = {}
--            for _, s in ipairs(result_sig.signatures) do
--                table.insert(lines2, s.label)
--                if s.documentation then
--                    local doc_lines = vim.lsp.util.convert_input_to_markdown_lines(s.documentation)
--                    vim.list_extend(lines2, vim.lsp.util.trim_empty_lines(doc_lines))
--                end
--            end
--
--            if #lines2 == 0 then return end
--            local text = table.concat(lines2, "\n")
--            if text == last_hover then return end
--            last_hover = text
--            write_text_to_clients(text)
--        end)
--        return
--    end
--    vim.lsp.buf_request(0, "textDocument/hover", params, function(err, result_hover, _, _)
--        if err or not (result_hover and result_hover.contents) then return end
--
--        local contents = result_hover.contents
--        local lines = vim.lsp.util.convert_input_to_markdown_lines(contents)
--        lines = vim.lsp.util.trim_empty_lines(lines)
--
--        if #lines == 0 then return end
--
--        local text = table.concat(lines, "\n")
--        if text == last_hover then return end
--        last_hover = text
--        write_text_to_clients(text)
--    end)
--end
--
--
--local function trigger_contextual_delay()
--    if not hover_timer then
--        hover_timer = vim.loop.new_timer()
--    else
--        hover_timer:stop()
--    end
--
--    hover_timer:start(M.config.delay, 0, vim.schedule_wrap(function()
--        trigger_contextual()
--    end))
--end
--
--local function notify_change()
--    vim.api.nvim_exec_autocmds("User", { pattern = "UltrasightMode" })
--end
--
--local GROUP_NAME = "ultrasight"
--
--function M.enable()
--    if M.enabled then return end
--
--    if not M.config.socket_path then
--        vim.notify("[ultrasight] no socket path configured", vim.log.levels.ERROR)
--        return
--    end
--
--    server = vim.uv.new_pipe(false)
--    server:bind(M.config.socket_path)
--    server:listen(5, function(err)
--        if err then return end
--        local client = vim.uv.new_pipe(false)
--        server:accept(client)
--        table.insert(clients, client)
--    end)
--
--    --pipe:connect(M.config.socket_path, function(err)
--    --    if err then
--    --        vim.schedule(function()
--    --            vim.notify("[ultrasight] failed to connect to socket: " .. err, vim.log.levels.ERROR)
--    --        end)
--    --        return
--    --    end
--    --    vim.schedule(function()
--    --        vim.notify("[ultrasight] socket connected to: " .. M.config.socket_path, vim.log.levels.INFO)
--    --    end)
--    --end)
--
--    M.enabled = true
--
--    local id = vim.api.nvim_create_augroup(GROUP_NAME, { clear = true })
--    vim.api.nvim_create_autocmd({ "CursorMovedI", "CursorHoldI", "CursorMoved", "CursorHold" }, {
--        group = id,
--        callback = trigger_contextual_delay,
--    })
--    vim.api.nvim_create_autocmd({ "InsertEnter", "ModeChanged" }, {
--        group = id,
--        callback = trigger_contextual,
--    })
--
--    vim.notify("[ultrasight] connected to: " .. M.config.socket_path, vim.log.levels.INFO)
--    notify_change()
--end
--
--function M.disable()
--    if not M.enabled then return end
--
--    if hover_timer then
--        hover_timer:stop()
--        hover_timer:close()
--        hover_timer = nil
--    end
--
--    for _, client in ipairs(clients) do
--        if not client:is_closing() then
--            client:shutdown(); client:close()
--        end
--    end
--    clients = {}
--
--    if server and not server:is_closing() then
--        server:close()
--        server = nil
--    end
--
--    if M.config.socket_path then
--        os.remove(M.config.socket_path)
--    end
--
--    M.enabled = false
--
--    vim.api.nvim_del_augroup_by_name(GROUP_NAME)
--    vim.notify("[ultrasight] disconnected from: " .. M.config.socket_path, vim.log.levels.INFO)
--    notify_change()
--end
--
--function M.listen()
--    local bufname = "Ultrasight"
--    local buf = vim.api.nvim_get_current_buf()
--    local win = vim.api.nvim_get_current_win()
--
--    local line_count = vim.api.nvim_buf_line_count(buf)
--    local is_empty = (line_count == 1 and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == "")
--
--    if not is_empty then
--        vim.notify("[ultrasight] listen requires an empty buffer", vim.log.levels.ERROR)
--        return
--    end
--
--    vim.api.nvim_buf_set_name(buf, bufname)
--    vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf })
--    vim.treesitter.start(buf, nil)
--
--    local pipe = vim.uv.new_pipe(false)
--    pipe:connect(M.config.socket_path, function(err)
--        if err then
--            vim.schedule(function()
--                vim.notify("[ultrasight] failed to connect: " .. err, vim.log.levels.ERROR)
--            end)
--            return
--        end
--    end)
--
--    pipe:read_start(function(err, data)
--        if err or not data then return end
--        vim.schedule(function()
--            if not vim.api.nvim_buf_is_valid(buf) then
--                if not pipe:is_closing() then
--                    pipe:shutdown()
--                    pipe:close()
--                    vim.notify("[ultrasight] listener closed", vim.log.levels.DEBUG)
--                end
--                return
--            end
--
--            local lines = vim.split(data, "\n", { plain = true })
--            local md = vim.lsp.util.stylize_markdown(buf, lines)
--            vim.api.nvim_buf_set_lines(buf, 0, -1, false, md)
--
--            if vim.api.nvim_win_is_valid(win) then
--                vim.api.nvim_win_set_cursor(win, { 1, 0 })
--            end
--        end)
--    end)
--
--    vim.notify("[ultrasight] listening")
--end
--
--function M.toggle()
--    if M.enabled then M.disable() else M.enable() end
--end

return M
