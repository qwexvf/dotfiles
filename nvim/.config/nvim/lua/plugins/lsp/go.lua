return {
    "ray-x/go.nvim",
    build = ":lua require(\"go.install\").update_all_sync()", -- if you need to install/update all binaries
    ft = { 'go', 'gomod' },
    config = function()
        local utils = require "utils"
        local on_attach = utils.on_attach
        local capabilities = utils.capabilities

        require("go").setup {
            lsp_cfg = {
                capabilities = capabilities,
                on_attach = on_attach,
            },
        }
    end,
}
