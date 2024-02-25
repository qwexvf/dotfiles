return {
    "ray-x/go.nvim",
    build = ":lua require(\"go.install\").update_all_sync()", -- if you need to install/update all binaries
    ft = "go",
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("go").setup {
            lsp_cfg = {
                capabilities = capabilities,
            },
        }
    end
}
