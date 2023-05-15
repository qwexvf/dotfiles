require("neodev").setup({})

local nvim_lsp = require("lspconfig")
local cmp = require("cmp")
local lspkind = require("lspkind")

local noremap = { noremap = true, silent = true }

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, noremap)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, noremap)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, noremap)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, noremap)

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    float = {
        border = "none",
        focus = false,
        scope = "cursor",
        source = "always",
    },
})

local border_opts = {
    border = "single",
    winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
}

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    preselect = cmp.PreselectMode.None,
    duplicates = {
        nvim_lsp = 1,
        luasnip = 1,
        -- copilot = 1,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
    }),
    window = {
        completion = cmp.config.window.bordered(border_opts),
        documentation = cmp.config.window.bordered(border_opts),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        -- { name = "copilot", priority = 600, group_index = 5 },
    }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
            mode = "symbol",
            symbol_map = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "",
                -- Copilot = "",
            },
        }),
    },
})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

require("cmp_git").setup({
    -- defaults
    filetypes = { "gitcommit" },
    remotes = { "upstream", "origin" },
    git = {
        commits = {
            limit = 100,
        },
    },
    github = {
        issues = {
            filter = "all",
            limit = 100,
            state = "open",
        },
        mentions = {
            limit = 100,
        },
        pull_requests = {
            limit = 100,
            state = "open",
        },
    },
})

local on_attach = function(client, bufnr)
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

    -- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    --     virtual_text = false,
    --     underline = true,
    --     signs = true,
    --     update_in_insert = true,
    -- })
end

local function create_capabilities()
    local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    return capabilities
end

local capabilities = create_capabilities()

nvim_lsp.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = runtime_path,
            },
            diagnostics = {
                enable = true,
                globals = { "vim" },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
            completion = {
                callSnippet = "Replace",
            },
        },
    },
})
local function organize_imports()
    local params = { command = "_typescript.organizeImports", arguments = { vim.api.nvim_buf_get_name(0) }, title = "" }
    vim.lsp.buf.execute_command(params)
end

nvim_lsp.tsserver.setup({
    cmd = { "typescript-language-server", "--stdio" },
    on_attach = on_attach,
    capabilities = capabilities,
    commands = {
        OrganizeImports = {
            organize_imports,
            description = "Organize Imports",
        },
    },
})

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({
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
})

local elixir = require("elixir")
local elixirls = require("elixir.elixirls")

elixir.setup({
    credo = {
        enabled = true,
    },
    elixirls = {
        settings = elixirls.settings({
            fetchDeps = true,
            dialyzerEnabled = true,
            enableTestLenses = false,
            suggestSpecs = true,
        }),
        on_attach = function(client, bufnr)
            local map_opts = { buffer = true, noremap = true }

            -- run the codelens under the cursor
            vim.keymap.set("n", "<space>r", vim.lsp.codelens.run, map_opts)
            -- remove the pipe operator
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", map_opts)
            -- add the pipe operator
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", map_opts)
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", map_opts)

            -- bindings for standard LSP functions.
            return on_attach(client, bufnr)
        end,
    },
})

require("symbols-outline").setup({
    highlight_hovered_item = true,
    show_guides = true,
    auto_preview = true,
    position = "right",
    relative_width = true,
    width = 10,
    auto_close = false,
    show_numbers = true,
    show_relative_numbers = true,
    show_symbol_details = true,
    preview_bg_highlight = "Pmenu",
    autofold_depth = nil,
    auto_unfold_hover = true,
    fold_markers = { "", "" },
    wrap = false,
    keymaps = {
        -- These keymaps can be a string or a table for multiple keys
        close = { "<Esc>", "q" },
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
        fold = "h",
        unfold = "l",
        fold_all = "W",
        unfold_all = "E",
        fold_reset = "R",
    },
    lsp_blacklist = {},
    symbol_blacklist = {},
})

require("lspconfig").svelte.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

-- astro
require("lspconfig").astro.setup({
    cmd = { "npm", "run", "astro-ls", "--stdio" },
})
