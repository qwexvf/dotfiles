local config = function()
    local nvim_lsp = require "lspconfig"

    local on_attach = function(_, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        local bufopts = { noremap = true, silent = true }

        buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", bufopts)
        buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
        buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
        buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
        buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
        buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", bufopts)
        buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", bufopts)
        buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", bufopts)
        buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
        buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)
        buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", bufopts)
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", bufopts)
    end

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

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

    require("go").setup {
        lsp_cfg = {
            capabilities = capabilities,
        },
    }

    nvim_lsp.tailwindcss.setup{}

    require("typescript-tools").setup {}
end

return {
    "neovim/nvim-lspconfig",
    config = config,
    lazy = false,
    dependencies = {
        "windwp/nvim-autopairs",
        "creativenull/efmls-configs-nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        {
            "ray-x/go.nvim",
            build = ":lua require(\"go.install\").update_all_sync()", -- if you need to install/update all binaries
            ft = "go",
        },
        {
            "pmizio/typescript-tools.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
        },
    },
}
