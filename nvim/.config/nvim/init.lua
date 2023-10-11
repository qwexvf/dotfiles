if vim.loader then
    vim.loader.enable()
end

require("settings")

require("plugins")
require("mappings")
require("autocmds")
require("theme")
require("treesitter_config")
require("telescope_config")
require("lsp")
require("efm")
require("saga")
require("utils")
