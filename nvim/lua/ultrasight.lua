local M = {}

--- Ultrasight state.
M.state = {
    --- Virtual text functionality state.
    virtual_text = {
        signature_help = {
            --- State for the previously inserted signature help.
            --- Needed to clear it properly.
            previous_insert = {
                bufnr = 0,
                extid = 0,
            },
            --- True when virtual text signature help is enabled.
            enabled = false,
        },
        --- True when virtual text diagnostics are enabled.
        --- This will only accurately track when the functionality is managed via Ultrasight.
        diagnostics = false,
    },
}

local us_namespace_id =
    vim.api.nvim_create_namespace("ultrasight_virtual_text")

local us_inlay_signature_augroup =
    vim.api.nvim_create_augroup("ultrasight_inlay_signature_augroup", { clear = true })

local clear_augroup = function()
    vim.api.nvim_clear_autocmds({ group = us_inlay_signature_augroup })
end

--- Toggle virtual text signature help.
--- When the cursor is inside of function parameters, signature help is automatically displayed
--- as virtual text at the end of the line.
function M.toggle_virtual_text_signature_help(setting)
    ---@type boolean
    local after
    if setting == nil or setting == "" then
        after = not M.state.virtual_text.signature_help.enabled
    elseif setting ~= "boolean" then
        error("InlaySignatureHelpToggle expects [true|false|nil]")
    else
        after = setting
    end

    if after then
        -- Register autocommands.
        -- Clearing happens when this functionality is disabled,
        -- but clear here too, just in case.
        clear_augroup()

        -- Callback for inserting signature help virtual text.
        local a = function()
            local bufnr = vim.api.nvim_get_current_buf()
            local params = vim.lsp.util.make_position_params(0, 'utf-8')
            vim.lsp.buf_request(bufnr, "textDocument/signatureHelp", params, function(err, result, _, _)
                if err or not result or not result.signatures or #result.signatures == 0 then
                    return
                end
                local sig = result.signatures[1]
                local label = sig.label
                local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                row = row - 1
                vim.api.nvim_buf_clear_namespace(bufnr, us_namespace_id, row, row + 1)         -- Clear line
                local extid = vim.api.nvim_buf_set_extmark(bufnr, us_namespace_id, row, col, { -- Set extmark
                    virt_text = { { label, "DiagnosticHint" } },
                    virt_text_pos = "eol",
                })

                M.state.virtual_text.signature_help.previous_insert.bufnr = bufnr
                M.state.virtual_text.signature_help.previous_insert.extid = extid
            end)
        end
        vim.api.nvim_create_autocmd({ "InsertEnter", "CursorHoldI", "CursorMovedI" },
            { group = us_inlay_signature_augroup, callback = a })

        -- Callback for removing previously inserted signature help virtual text.
        local b = function()
            vim.api.nvim_buf_del_extmark(M.state.virtual_text.signature_help.previous_insert.bufnr, us_namespace_id,
                M.state.virtual_text.signature_help.previous_insert.extid)
            M.state.virtual_text.signature_help.previous_insert.bufnr = 0
            M.state.virtual_text.signature_help.previous_insert.extid = 0
        end

        vim.api.nvim_create_autocmd({ "InsertLeave" }, { group = us_inlay_signature_augroup, callback = b })
        M.state.virtual_text.signature_help.enabled = true
    else
        -- Clear autocommands group.
        clear_augroup()
        M.state.virtual_text.signature_help.enabled = false
    end

    local text = after and "on" or "off"
    vim.notify("virtual text signature help " .. text, vim.log.levels.INFO, {})
end

--- Toggle built-in virtual text diagnostics.
--- This is not Ultrasight specific functionality, just a shortcut for toggling the Neovim
--- feature on/off.
function M.toggle_virtual_text_diagnostics(setting)
    local after
    if setting == nil or setting == "" then
        after = not M.state.virtual_text_diagnostics
    elseif setting ~= "boolean" then
        error("toggle_virtual_text_diagnostics expects [true|false|nil]")
    else
        after = setting
    end

    local text
    if after then
        text = "on"
    else
        text = "off"
    end
    vim.notify("virtual text diagnostics " .. text, vim.log.levels.INFO, {})
    M.state.virtual_text_diagnostics = after
    vim.diagnostic.config({ virtual_text = after })
end

return M
