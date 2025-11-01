--vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.format()' -- Format on save.
vim.lsp.enable({ "lua_ls", "zls", "clangd", "rust_analyzer", "gopls" })
vim.diagnostic.config({ virtual_text = true })
