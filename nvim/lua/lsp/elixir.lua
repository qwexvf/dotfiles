local nvim_lsp = require 'lspconfig'
require 'global'

nvim_lsp.elixirls.setup {
  cmd = { vim.fn.expand '~/elixir-ls/language_server.sh' },
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    elixirLS = {
      dialyzerEnabled = true,
      fetchDeps = false,
    },
  },
}
