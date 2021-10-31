local nvim_lsp = require('lspconfig')
require('global')

local efm_on_attach = function(client, bufnr)
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
end

nvim_lsp.efm.setup {
  on_attach = efm_on_attach,
  init_options = { documentFormatting = true },
  filetypes = { 'elixir', 'lua' },
}
