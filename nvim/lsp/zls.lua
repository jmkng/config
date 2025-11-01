---@brief
--- https://github.com/zigtools/zls
---
--- Zig LSP implementation + Zig Language Server

---@type vim.lsp.Config
return {
    cmd = { 'zls' },
    settings = {
        enable_build_on_save = true,
    },
    filetypes = { 'zig', 'zir' },
    root_markers = { 'zls.json', 'build.zig', '.git' },
    workspace_required = false,
}
