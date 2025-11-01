vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.wo.number = true
vim.o.clipboard = ''
vim.o.timeoutlen = 750
vim.o.backspace = '2'
vim.o.showcmd = true
vim.o.laststatus = 2
vim.o.autowrite = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.cursorline = true
vim.o.nu = false
vim.o.autoread = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.shiftround = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.cursorline = false
--vim.o.winborder = "rounded"
--vim.o.completeopt = "menu,menuone,noselect"
vim.opt.signcolumn = "no"

require("vendor.mini.pick").setup()
require("vendor.mini.completion").setup({
    delay = { completion = 0, info = 0, signature = 0 },
})
require("colorscheme")
require("_lsp")
require("statusline")
require("keymap")
require("command")
require("netrw")
require("ultrasight").setup({
   socket_path = "/tmp/ultrasight.sock",
})
require("treesitter")
