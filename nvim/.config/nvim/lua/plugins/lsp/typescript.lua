return {
    "pmizio/typescript-tools.nvim",
    lazy = false,
    config = function()
        local nvim_lsp = require "lspconfig"

        require("typescript-tools").setup {
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
            root_dir = nvim_lsp.util.root_pattern("tsconfig.json", "package.json"),
        }
    end,
}
