vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.clipboard = ''
vim.o.timeoutlen = 1000
vim.o.backspace = '2'
vim.o.showcmd = true
vim.o.laststatus = 2
vim.o.autowrite = false
vim.o.wrap = false
vim.o.swapfile = false
vim.o.cursorline = true
vim.o.nu = true
vim.o.autoread = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.shiftround = true
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.completeopt = "menuone,noselect,noinsert,popup"

vim.wo.number = true

vim.opt.showmode = true
vim.opt.signcolumn = "yes"
vim.opt.shortmess:append({ I = true })

require("colorscheme")
require("_lsp")
require("statusline")
require("keymap")
require("netrw")
require("command")
require("treesitter")
--local ultrasight = require("ultrasight")
--ultrasight.setup()
--/tmp/ultrasight.sock
require("vendor.mini.completion").setup({})
