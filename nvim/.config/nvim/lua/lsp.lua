local nvim_lsp = require "lspconfig"
local cmp = require "cmp"
local lspkind = require "lspkind"
local log = require "vim.lsp.log"

require("luasnip.loaders.from_vscode").load()

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

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

-- small for to go to definition on new window or split tabs
local function goto_definition(split_cmd)
  local util = vim.lsp.util
  local api = vim.api

  -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
  local handler = function(_, result, ctx)
    print(result)
    print("asdf")
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, "No location found")
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])

      if #result > 1 then
        util.set_qflist(util.locations_to_items(result))
        api.nvim_command "copen"
        api.nvim_command "wincmd p"
      end
    else
      util.jump_to_location(result)
    end
  end

  return handler
end

vim.lsp.handlers["textDocument/definition"] = goto_definition "split"

cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
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
  sources = cmp.config.sources {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "treesitter" },
    { name = "cmp_git" },
    { name = "buffer" },
    { name = "path" },
  },
  formatting = {
    format = lspkind.cmp_format { with_text = true, maxwidth = 100 },
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

local function create_capabilities()
  local _capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- modify capabilities here
  _capabilities.textDocument.completion.completionItem.snippetSupport = true

  return _capabilities
end

local capabilities = create_capabilities()

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
    update_in_insert = true,
  })
end

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      format = {
        enable = true,
        -- Put format options here
        -- NOTE: the value should be STRING!!
        defaultConfig = {
          indent_style = "space",
          indent_size = "4",
          quote_style = "double"
        }
      },
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
    },
  },
}

nvim_lsp.vuels.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    return on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  cmd = { "vls" },
  filetypes = { "vue" },
  init_options = {
    config = {
      css = {},
      emmet = {},
      html = {
        suggest = {},
      },
      javascript = {
        format = { "prettier" },
      },
      stylusSupremacy = {},
      typescript = {
        format = { "prettier" },
      },
      vetur = {
        completion = {
          autoImport = true,
          tagCasing = "kebab",
          useScaffoldSnippets = false,
        },
        format = {
          enable = false,
          defaultFormatter = {
            js = "prettier",
            ts = "prettier",
          },
          defaultFormatterOptions = {},
          scriptInitialIndent = false,
          styleInitialIndent = false,
        },
        useWorkspaceDependencies = false,
        validation = {
          script = true,
          style = true,
          template = true,
        },
      },
    },
  },
  root_dir = nvim_lsp.util.root_pattern("package.json", "vue.config.js"),
}

-- nvim_lsp.volar.setup {
--   on_attach = function(client, bufnr)
--     client.resolved_capabilities.document_formatting = true
--     return on_attach(client, bufnr)
--   end,
--   capabilities = capabilities,
--   filetypes = {
--     'typescript',
--     'javascript',
--     'javascriptreact',
--     'typescriptreact',
--     'vue',
--     'json',
--   },
-- }

nvim_lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    return on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

nvim_lsp.gopls.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    return on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

-- Svelte
nvim_lsp.svelte.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    return on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup {
  cmd = { "rustup", "run", "nightly", "rust-analyzer" },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    return on_attach(client, bufnr)
  end,
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

local elixir = require("elixir")
elixir.setup({
  -- specify a repository and branch
  repo = "mhanberg/elixir-ls", -- defaults to elixir-lsp/elixir-ls
  branch = "mh/all-workspace-symbols", -- defaults to nil, just checkouts out the default branch, mutually exclusive with the `tag` option
  tag = "v0.9.0", -- defaults to nil, mutually exclusive with the `branch` option

  -- default settings, use the `settings` function to override settings
  settings = elixir.settings({
    dialyzerEnabled = true,
    fetchDeps = false,
    enableTestLenses = false,
    suggestSpecs = false,
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

    -- standard lsp keybinds
    vim.keymap.set("n", "df", "<cmd>lua vim.lsp.buf.format()<cr>", map_opts)
    vim.keymap.set("n", "gd", "<cmd>lua vim.diagnostic.open_float()<cr>", map_opts)
    vim.keymap.set("n", "dt", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>", map_opts)
    vim.keymap.set("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)
    -- keybinds for fzf-lsp.nvim: https://github.com/gfanto/fzf-lsp.nvim
    -- you could also use telescope.nvim: https://github.com/nvim-telescope/telescope.nvim
    -- there are also core vim.lsp functions that put the same data in the loclist
    vim.keymap.set("n", "gr", ":References<cr>", map_opts)
    vim.keymap.set("n", "g0", ":DocumentSymbols<cr>", map_opts)
    vim.keymap.set("n", "gW", ":WorkspaceSymbols<cr>", map_opts)
    vim.keymap.set("n", "<leader>d", ":Diagnostics<cr>", map_opts)


    -- keybinds for vim-vsnip: https://github.com/hrsh7th/vim-vsnip
    vim.cmd([[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])
    vim.cmd([[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']])

    -- update capabilities for nvim-cmp: https://github.com/hrsh7th/nvim-cmp
    require("cmp_nvim_lsp").update_capabilities(capabilities)
  end
})
