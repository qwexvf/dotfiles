local nvim_lsp = require 'lspconfig'
local cmp = require 'cmp'

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
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
    { name = 'cmp_git' },
    { name = 'vsnip' },
    { name = 'buffer' },
    { name = 'treesitter' },
  },
}

-- Use buffer source for `/`.
cmp.setup.cmdline('/', { sources = { { name = 'buffer' } } })

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

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

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

  client.resolved_capabilities.document_formatting = false

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { virtual_text = false, underline = true, signs = true }
  )
end

local path_to_elixirls = vim.fn.expand '~/elixir-ls/release/language_server.sh'

nvim_lsp.elixirls.setup {
  cmd = { path_to_elixirls },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = { elixirLS = { dialyzerEnabled = false, fetchDeps = false } },
}

nvim_lsp.vuels.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { 'vls' },
  filetypes = { 'vue' },
  root_dir = nvim_lsp.util.root_pattern('package.json', 'vue.config.js'),
}

local lsp_installer = require 'nvim-lsp-installer'
lsp_installer.on_server_ready(function(server)
  local opts = {}

  opts.on_attach = on_attach
  opts.capabilities = capabilities
  opts.flags = { debounce_text_changes = 150 }

  if server.name == 'sumneko_lua' then
    -- Make runtime files discoverable to the server
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')

    opts.settings = {
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
        telemetry = { enable = false },
      },
    }
  end

  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

local eslint = {
  lintCommand = 'eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}',
  lintIgnoreExitCode = true,
  lintFormats = { '%f(%l,%c): %tarning %m', '%f(%l,%c): %rror %m' },
  lintStdin = true,
  formatCommand = 'eslint_d --stdin --fix-to-stdout --stdin-filename=${INPUT}',
  formatStdin = true,
}

local elixir_format = {
  lintCommand = 'MIX_ENV=test mix credo suggest --format=flycheck --read-from-stdin ${INPUT}',
  lintStdin = true,
  lintFormats = { '%f:%l:%c: %m', '%f:%l %t: %m' },
  lintIgnoreExitCode = true,
  formatCommand = 'mix format -',
  formatStdin = true,
}

local lua_format = { formatCommand = 'stylua -', formatStdin = true }

nvim_lsp.efm.setup {
  on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.goto_definition = false

    -- Mappings.
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      { virtual_text = false, underline = true, signs = true }
    )
  end,
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { '.git/' },
    languages = {
      javascript = { eslint },
      javascriptreact = { eslint },
      ['javascript.jsx'] = { eslint },
      typescript = { eslint },
      ['typescript.tsx'] = { eslint },
      typescriptreact = { eslint },
      elixir = { elixir_format },
      lua = { lua_format },
    },
  },
  filetypes = {
    'elixir',
    'lua',
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescript.tsx',
    'typescriptreact',
  },
}

require('lspconfig').tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}
