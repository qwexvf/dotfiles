local config = function()
    local utils = require "utils"
    local on_attach = utils.on_attach
    local capabilities = utils.capabilities

    local stylua = require "efmls-configs.formatters.stylua"

    local biome_formatter = {
        formatCommand = "bun biome format --write --stdin-file-path ${INPUT}",
        formatStdin = true,
        rootMarkers = { "rome.json", "biome.json" },
    }

    local languages = {
        typescript = { biome_formatter },
        typescriptreact = { biome_formatter },
        -- lua = { stylua },
    }

    local efmls_config = {
        filetypes = vim.tbl_keys(languages),
        settings = {
            rootMarkers = { ".git/" },
            languages = languages,
        },
        init_options = {
            documentFormatting = true,
            documentRangeFormatting = true,
        },
    }

    require("lspconfig").efm.setup(vim.tbl_extend("force", efmls_config, {
        cmd = { "efm-langserver" },
        on_attach = on_attach,
        capabilities = capabilities,
    }))
end

return {
    "creativenull/efmls-configs-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = config,
    lazy = false,
}
