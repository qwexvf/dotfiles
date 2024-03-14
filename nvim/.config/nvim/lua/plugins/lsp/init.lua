local config = function()
    local nvim_lsp = require "lspconfig"
    local utils = require "utils"

    local on_attach = utils.on_attach
    local capabilities = utils.capabilities

    nvim_lsp.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    enable = true,
                    globals = { "vim" },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                completion = {
                    callSnippet = "Replace",
                },
            },
        },
    }

    nvim_lsp.graphql.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "bun", "run", "graphql-lsp", "server", "-m", "stream" },
    }

    nvim_lsp.biome.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        -- get config file from current project root directory
        cmd = { "bun", "run", "biome", "lsp-proxy", "--config-path", vim.fn.getcwd() .. "/biome.json" },
        root_dir = nvim_lsp.util.root_pattern("biome.json", "rome.json"),
    }

    -- Enable rust_analyzer
    nvim_lsp.rust_analyzer.setup {
        cmd = { "rustup", "run", "stable", "rust-analyzer" },
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy diagnostics on save
                checkOnSave = {
                    command = "clippy",
                },
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                procMacro = {
                    enable = true,
                },
            },
        },
    }

    nvim_lsp.svelte.setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }

    nvim_lsp.tailwindcss.setup {
        root_dir = nvim_lsp.util.root_pattern "tailwind.config.ts",
    }

    nvim_lsp.denols.setup({
        root_dir = nvim_lsp.util.root_pattern("deno.json", "import_maps.json"),
        init_options = {
            lint = true,
            unstable = true,
            suggest = {
                imports = {
                    hosts = {
                        ["https://deno.land"] = true,
                        ["https://cdn.nest.land"] = true,
                        ["https://crux.land"] = true,
                    },
                },
            },
        },
        on_attach = on_attach,
        capabilities = capabilities,
    })

    nvim_lsp.prismals.setup {}
end

return {
    "neovim/nvim-lspconfig",
    config = config,
    lazy = false,
}
