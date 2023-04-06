require("neodev").setup {}

local nvim_lsp = require "lspconfig"
local cmp = require "cmp"
local lspkind = require "lspkind"

local noremap = { noremap = true, silent = true }

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, noremap)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, noremap)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, noremap)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, noremap)

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

vim.diagnostic.config {
    virtual_text = false,
    signs = true,
    float = {
        border = "single",
        focus = false,
        scope = "cursor",
        source = "always",
    },
}

local border_opts = {
    border = "single",
    winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
}

cmp.setup {
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
        ["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    duplicates = {
        nvim_lsp = 1,
        luasnip = 1,
        cmp_tabnine = 1,
        buffer = 1,
        path = 1,
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        completion = cmp.config.window.bordered(border_opts),
        documentation = cmp.config.window.bordered(border_opts),
    },
    sources = cmp.config.sources {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format {
            mode = "symbol",
            symbol_map = {
                Text = "",
                Method = "",
                Function = "",
                Constructor = "",
                Field = "ﰠ",
                Variable = "",
                Class = "ﴯ",
                Interface = "",
                Module = "",
                Property = "ﰠ",
                Unit = "塞",
                Value = "",
                Enum = "",
                Keyword = "",
                Snippet = "",
                Color = "",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "",
                Struct = "פּ",
                Event = "",
                Operator = "",
                TypeParameter = "",
            },
        },
        snippet = {
            expand = function(args)
                require("luasnip.loaders.from_vscode").load()
                require("luasnip").lsp_expand(args.body)
            end,
        },
    },
}

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

require("cmp_git").setup {
    -- defaults
    filetypes = { "gitcommit" },
    remotes = { "upstream", "origin" }, -- in order of most to least prioritized
    git = {
        commits = {
            limit = 100,
        },
    },
    github = {
        issues = {
            filter = "all", -- assigned, created, mentioned, subscribed, all, repos
            limit = 100,
            state = "open", -- open, closed, all
        },
        mentions = {
            limit = 100,
        },
        pull_requests = {
            limit = 100,
            state = "open", -- open, closed, merged, all
        },
    },
}

-- Setup lspconfig.
local on_attach = function(_client, bufnr)
    -- We'll use efm for formatting
    -- client.server_capabilities.documentFormattingProvider = false

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

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

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline = true,
        signs = true,
        update_in_insert = true,
    })
end

local function create_capabilities()
    local _capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- modify capabilities here
    _capabilities.textDocument.completion.completionItem.snippetSupport = true

    return _capabilities
end

local capabilities = create_capabilities()

nvim_lsp.lua_ls.setup {
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
            },
            telemetry = {
                enable = false,
            },
            completion = {
                callSnippet = "Replace",
            },
        },
    },
}
local function organize_imports()
    local params = { command = "_typescript.organizeImports", arguments = { vim.api.nvim_buf_get_name(0) }, title = "" }
    vim.lsp.buf.execute_command(params)
end

nvim_lsp.tsserver.setup {
    cmd = { "bunx", "typescript-language-server", "--stdio" },
    on_attach = on_attach,
    capabilities = capabilities,
    commands = {
        OrganizeImports = {
            organize_imports,
            description = "Organize Imports",
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
        },
    },
}

local elixir = require "elixir"
elixir.setup {
    settings = elixir.settings {
        dialyzerEnabled = true,
        fetchDeps = false,
        enableTestLenses = false,
        suggestSpecs = true,
    },
    on_attach = function(client, bufnr)
        local map_opts = { buffer = true, noremap = true }

        -- run the codelens under the cursor
        vim.keymap.set("n", "<space>r", vim.lsp.codelens.run, map_opts)
        -- remove the pipe operator
        vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", map_opts)
        -- add the pipe operator
        vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", map_opts)
        vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", map_opts)

        -- standard lsp keybinds
        vim.keymap.set("n", "df", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", map_opts)
        vim.keymap.set("n", "gd", "<cmd>lua vim.diagnostic.open_float()<cr>", map_opts)
        vim.keymap.set("n", "dt", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
        vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>", map_opts)
        vim.keymap.set("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)
        vim.keymap.set("n", "gr", ":References<cr>", map_opts)
        vim.keymap.set("n", "g0", ":DocumentSymbols<cr>", map_opts)
        vim.keymap.set("n", "gW", ":WorkspaceSymbols<cr>", map_opts)
        vim.keymap.set("n", "<leader>d", ":Diagnostics<cr>", map_opts)

        -- keybinds for vim-vsnip: https://github.com/hrsh7th/vim-vsnip
        vim.cmd [[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]
        vim.cmd [[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]

        -- update capabilities for nvim-cmp: https://github.com/hrsh7th/nvim-cmp
        require("cmp_nvim_lsp").default_capabilities(capabilities)

        return on_attach(client, bufnr)
    end,
}

require("symbols-outline").setup {
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
    symbols = {
        File = { icon = "", hl = "TSURI" },
        Module = { icon = "", hl = "TSNamespace" },
        Namespace = { icon = "", hl = "TSNamespace" },
        Package = { icon = "", hl = "TSNamespace" },
        Class = { icon = "𝓒", hl = "TSType" },
        Method = { icon = "ƒ", hl = "TSMethod" },
        Property = { icon = "", hl = "TSMethod" },
        Field = { icon = "", hl = "TSField" },
        Constructor = { icon = "", hl = "TSConstructor" },
        Enum = { icon = "ℰ", hl = "TSType" },
        Interface = { icon = "ﰮ", hl = "TSType" },
        Function = { icon = "", hl = "TSFunction" },
        Variable = { icon = "", hl = "TSConstant" },
        Constant = { icon = "", hl = "TSConstant" },
        String = { icon = "𝓐", hl = "TSString" },
        Number = { icon = "#", hl = "TSNumber" },
        Boolean = { icon = "⊨", hl = "TSBoolean" },
        Array = { icon = "", hl = "TSConstant" },
        Object = { icon = "⦿", hl = "TSType" },
        Key = { icon = "🔐", hl = "TSType" },
        Null = { icon = "NULL", hl = "TSType" },
        EnumMember = { icon = "", hl = "TSField" },
        Struct = { icon = "𝓢", hl = "TSType" },
        Event = { icon = "🗲", hl = "TSType" },
        Operator = { icon = "+", hl = "TSOperator" },
        TypeParameter = { icon = "𝙏", hl = "TSParameter" },
    },
}

require("lspconfig").astro.setup {
    cmd = { "npm", "run", "astro-ls", "--stdio" },
}

require("lspconfig").gleam.setup {}

require("go").setup {
    lsp_cfg = false,
}

local cfg = require("go.lsp").config() -- config() return the go.nvim gopls setup

require("lspconfig").gopls.setup(cfg)

local null_ls = require "null-ls"

null_ls.setup {
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.eslint_d,
        null_ls.builtins.formatting.prettierd.with {
            env = {
                PRETTIERD_LOCAL_PRETTIER_ONLY = 1,
            },
        },
    },
}
