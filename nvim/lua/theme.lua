local catppuccin = require 'catppuccin'
local cmd = vim.cmd

catppuccin.setup {
  transparent_background = false,
  term_colors = true,
  styles = {
    comments = 'bold',
    functions = 'bold',
    keywords = 'bold',
    strings = 'bold',
    variables = 'italic',
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = 'italic',
        hints = 'italic',
        warnings = 'italic',
        information = 'italic',
      },
      underlines = {
        errors = 'underline',
        hints = 'underline',
        warnings = 'underline',
        information = 'underline',
      },
    },
    lsp_trouble = true,
    cmp = true,
    gitsigns = true,
    telescope = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    dashboard = true,
    bufferline = true,
    markdown = true,
    ts_rainbow = true,
    hop = true,
    notify = true,
    telekasten = true,
  },
}

cmd [[colorscheme catppuccin]]
