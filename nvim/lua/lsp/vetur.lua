local nvim_lsp = require 'lspconfig'
require 'global'

nvim_lsp.vuels.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { 'vls' },
  filetypes = { 'vue' },
  root_dir = nvim_lsp.util.root_pattern('package.json', 'vue.config.js', 'vetur.config.js'),
  init_options = {
    config = {
      css = {},
      emmet = {},
      html = { suggest = {} },
      javascript = { format = {} },
      stylusSupremacy = {},
      typescript = { format = {} },
      vetur = {
        completion = {
          autoImport = true,
          tagCasing = 'kebab',
          useScaffoldSnippets = false,
        },
        format = {
          defaultFormatter = { js = 'eslint', ts = 'eslint', html = 'eslint' },
          defaultFormatterOptions = {},
          scriptInitialIndent = false,
          styleInitialIndent = false,
        },
        useWorkspaceDependencies = false,
        validation = { script = true, style = true, template = true },
      },
    },
  },
}
