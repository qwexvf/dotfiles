local nvim_lsp = require 'lspconfig'
local cmp = require 'cmp'
local lspkind = require 'lspkind'
local log = require 'vim.lsp.log'

require('luasnip.loaders.from_vscode').load()

vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  float = {
    border = 'single',
    focus = false,
    scope = 'cursor',
    source = 'always',
  },
}

-- small for to go to definition on new window or split tabs
local function goto_definition(split_cmd)
  local util = vim.lsp.util
  local api = vim.api

  -- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, 'No location found')
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    if vim.tbl_islist(result) then
      util.jump_to_location(result[1])

      if #result > 1 then
        util.set_qflist(util.locations_to_items(result))
        api.nvim_command 'copen'
        api.nvim_command 'wincmd p'
      end
    else
      util.jump_to_location(result)
    end
  end

  return handler
end

vim.lsp.handlers['textDocument/definition'] = goto_definition 'split'

cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ['<Down>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
    ['<Up>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'treesitter' },
    { name = 'cmp_git' },
    { name = 'buffer' },
  },
  formatting = {
    format = lspkind.cmp_format { with_text = true, maxwidth = 100 },
  },
}

-- Use buffer source for `/`.
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' },
  },
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
})

require('cmp_git').setup {
  -- defaults
  filetypes = { 'gitcommit' },
  remotes = { 'upstream', 'origin' }, -- in order of most to least prioritized
  git = {
    commits = {
      limit = 100,
    },
  },
  github = {
    issues = {
      filter = 'all', -- assigned, created, mentioned, subscribed, all, repos
      limit = 100,
      state = 'open', -- open, closed, all
    },
    mentions = {
      limit = 100,
    },
    pull_requests = {
      limit = 100,
      state = 'open', -- open, closed, merged, all
    },
  },
}

local function create_capabilities()
  local _capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- modify capabilities here
  _capabilities.textDocument.completion.completionItem.snippetSupport = true

  return _capabilities
end

local capabilities = create_capabilities()

-- Setup lspconfig.
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = true,
    signs = true,
    update_in_insert = true,
  })
end

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

nvim_lsp.sumneko_lua.setup {
  --on_attach = function(client, bufnr)
  --  client.resolved_capabilities.document_formatting = false
  --  return on_attach(client, bufnr)
  --end,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

nvim_lsp.elixirls.setup {
  cmd = { vim.fn.expand '~/Documents/elixir-ls/releases/language_server.sh' },
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    return on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  settings = {
    elixirLS = {
      dialyzerEnabled = false,
      fetchDeps = false,
    },
  },
}

nvim_lsp.vuels.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    return on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  cmd = { 'vls' },
  filetypes = { 'vue' },
  init_options = {
    config = {
      css = {},
      emmet = {},
      html = {
        suggest = {},
      },
      javascript = {
        format = { 'prettier' },
      },
      stylusSupremacy = {},
      typescript = {
        format = { 'prettier' },
      },
      vetur = {
        completion = {
          autoImport = true,
          tagCasing = 'kebab',
          useScaffoldSnippets = false,
        },
        format = {
          enable = false,
          defaultFormatter = {
            js = 'prettier',
            ts = 'prettier',
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
  root_dir = nvim_lsp.util.root_pattern('package.json', 'vue.config.js'),
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
    client.resolved_capabilities.document_formatting = false
    return on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

nvim_lsp.gopls.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = true
    return on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

-- elm
nvim_lsp.elmls.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = true
    return on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

-- Svelte
nvim_lsp.svelte.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = true
    return on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

nvim_lsp.eslint.setup {}

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup {
  cmd = { 'rustup', 'run', 'nightly', 'rust-analyzer' },
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = true
    return on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  settings = {
    -- to enable rust-analyzer settings visit:
    -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
    ['rust-analyzer'] = {
      -- enable clippy diagnostics on save
      checkOnSave = {
        command = 'clippy',
      },
    },
  },
}
