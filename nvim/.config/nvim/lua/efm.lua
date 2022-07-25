local nvim_lsp = require 'lspconfig'

local eslint = {
  formatCommand = 'eslint_d --stdin --fix-to-stdout --stdin-filename=${INPUT}',
  formatStdin = true,
}

local prettier = {
  formatCommand = 'prettierd "${INPUT}"',
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
local rust_format = { formatCommand = 'rustfmt -', formatStdin = true }

nvim_lsp.efm.setup {
  on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.definitionProvider = false

    -- Mappings.
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
  end,
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { '.git/' },
    languages = {
      vue = { eslint },
      javascript = { eslint },
      javascriptreact = { eslint },
      ['javascript.jsx'] = { eslint },
      typescript = { prettier },
      ['typescript.tsx'] = { eslint },
      typescriptreact = { eslint },
      elixir = { elixir_format },
      lua = { lua_format },
    },
  },
  filetypes = {
    'vue',
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
