local catppuccin = require 'catppuccin'

-- configure it
catppuccin.setup {
  styles = {
    comments = 'italic',
    functions = 'italic',
    keywords = 'italic',
    strings = 'NONE',
    variables = 'NONE',
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
    gitsigns = true,
    telescope = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    bufferline = true,
    hop = true,
  },
}
