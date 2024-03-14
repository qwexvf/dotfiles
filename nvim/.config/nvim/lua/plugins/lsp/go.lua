return {
    "ray-x/go.nvim",
    build = ":lua require(\"go.install\").update_all_sync()", -- if you need to install/update all binaries
    ft = "go",
    config = function()
        local utils = require "utils"
        local capabilities = utils.capabilities

        require("go").setup {
            lsp_cfg = true, -- false: use your own lspconfig
            lsp_on_attach = true, -- use on_attach from go.nvim
            capabilities = capabilities,
        }
    end,
}
