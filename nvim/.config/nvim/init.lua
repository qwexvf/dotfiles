if vim.loader then
    vim.loader.enable()
end

vim.cmd "filetype plugin indent on"
require "config"
