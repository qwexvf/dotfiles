local opt = vim.opt

opt.smartindent = true
opt.expandtab = true
opt.autoindent = true
opt.cursorline = true
opt.relativenumber = true
opt.pumheight = 5
opt.termguicolors = true

-- Set highlight on search
opt.hlsearch = true

-- Make line numbers default
vim.wo.number = true
opt.matchtime = 1

-- Enable break indent
opt.breakindent = false

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

-- autocomplete
opt.completeopt = "menuone,noselect"
opt.shortmess = opt.shortmess + { c = true }

opt.clipboard = "unnamed,unnamedplus"

-- Adjust window size of preview and help.
opt.previewheight = 8
opt.helpheight = 12
