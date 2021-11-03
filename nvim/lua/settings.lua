-- local map = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd -- execute Vim commands
-- local exec = vim.api.nvim_exec -- execute Vimscript
-- local fn = vim.fn -- call Vim functions
-- local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options

vim.o.smartindent = true
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.cursorline = true
vim.o.laststatus = 2
vim.o.relativenumber = true
vim.o.shiftwidth = 2
vim.o.showtabline = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.pumheight = 5
vim.o.termguicolors = true

-- Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

vim.o.matchtime = 1

-- Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

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
opt.signcolumn = 'yes'

opt.hidden = true -- enable background buffers
opt.history = 100 -- remember n lines in history
opt.lazyredraw = true -- faster scrolling
opt.synmaxcol = 240 -- max column for syntax highlight

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
-- autocomplete
opt.completeopt = 'menuone,noselect'
opt.shortmess = opt.shortmess + { c = true }

-- perfomance
opt.updatetime = 100
opt.timeoutlen = 400
opt.redrawtime = 1500
opt.ttimeoutlen = 10
opt.clipboard = 'unnamed,unnamedplus'

-- Adjust window size of preview and help.
opt.previewheight = 8
opt.helpheight = 12

-- Set colorscheme (order is important here)
opt.termguicolors = true
cmd [[colorscheme catppuccino]]

-- Remap space as leader key
vim.api.nvim_set_keymap('', '<,>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false
