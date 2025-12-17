vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.netrw_keepdir = 0

vim.o.clipboard = ''
vim.o.timeoutlen = 1000
vim.o.backspace = '2'
vim.o.showcmd = true
vim.o.laststatus = 2
vim.o.autowrite = false
vim.o.wrap = false
vim.o.swapfile = false
vim.o.cursorline = false
vim.o.nu = false
vim.o.autoread = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.shiftround = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.completeopt = "menuone,noselect,noinsert" -- popup
-- Not implemented in Neovim.
-- https://neovim.io/doc/user/vim_diff.html#nvim-missing
-- vim.o.completepopup = "align:menu,height:50,width:50"
vim.o.pumheight = 10
vim.o.pumwidth = 15

vim.opt.showmode = false
vim.opt.signcolumn = "no"
vim.opt.shortmess:append({ I = true })
vim.o.switchbuf = "uselast"

require("command")
require("statusline")
require("_lsp")
require("colorscheme")
require("netrw")
require("treesitter")
require("keymap")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        vim.cmd("compiler cargo")
    end
})
