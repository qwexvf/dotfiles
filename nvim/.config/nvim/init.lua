if vim.loader then
    vim.loader.enable()
end

require("settings")
require("mappings")
require("autocmds")

-- plugin configs
require("plugins")
require("theme")
require("treesitter_config")
require("lsp")
-- require "efm"
require("saga")
require("utils")
require("null_ls")
