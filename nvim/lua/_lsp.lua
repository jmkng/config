vim.lsp.enable({ "lua_ls", "zls", "clangd", "rust_analyzer", "gopls", "sourcekit", "html" })
vim.diagnostic.config({ virtual_text = true })

local group = vim.api.nvim_create_augroup("AutoLspCompleteDebounced", { clear = true })

local pending_timer = nil
local debounce_ms = 100

vim.api.nvim_create_autocmd("TextChangedI", {
    group = group,
    pattern = "*",
    callback = function()
        if pending_timer then
            pending_timer:stop()
            pending_timer = nil
        end
        pending_timer = vim.defer_fn(function()
            local col = vim.fn.col('.') - 1
            if col <= 0 then return end

            local line = vim.fn.getline('.')
            local char = line:sub(col, col)
            if char:match("[%w_:.&*]") then
                vim.lsp.omnifunc(0, 0)
            end
        end, debounce_ms)
    end,
})
