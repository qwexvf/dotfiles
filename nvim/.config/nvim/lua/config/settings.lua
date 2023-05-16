local opt = vim.opt

vim.o.smartindent = true
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.cursorline = true
vim.o.laststatus = 3
vim.o.relativenumber = true
vim.o.pumheight = 5
vim.o.termguicolors = true

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true
vim.o.matchtime = 1

-- Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

-- Enable break indent
vim.o.breakindent = false

-- Save undo history
opt.undofile = true
opt.swapfile = false
opt.showmatch = true
opt.scrolloff = 15
opt.cursorline = true
opt.splitright = true -- vertical split to the right
opt.splitbelow = true -- orizontal split to the bottom
opt.ignorecase = true -- ignore case letters when search
opt.smartcase = true -- ignore lowercase for the whole pattern
opt.linebreak = true -- wrap on word boundary
opt.signcolumn = "yes"

opt.hidden = true -- enable background buffers
opt.history = 5 -- remember n lines in history
opt.lazyredraw = true -- faster scrolling
opt.synmaxcol = 240 -- max column for syntax highlight

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- autocomplete
opt.completeopt = "menuone,noselect"
opt.shortmess = opt.shortmess + { c = true }

-- perfomance
vim.updatetime = 100
opt.timeoutlen = 400
opt.redrawtime = 1500
opt.ttimeoutlen = 10
opt.clipboard = "unnamed,unnamedplus"

-- Adjust window size of preview and help.
opt.previewheight = 8
opt.helpheight = 12

-- Remap space as leader key
vim.api.nvim_set_keymap("", "<,>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = ","
vim.g.maplocalleader = ","