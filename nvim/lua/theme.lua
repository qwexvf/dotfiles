local catppuccino = require 'catppuccino'

catppuccino.setup {
  colorscheme = 'dark_catppuccino',
  transparency = false,
  term_colors = true,
  styles = {
    comments = 'italic',
    functions = 'italic',
    keywords = 'italic',
    strings = 'bold',
    variables = 'bold',
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
    lsp_saga = false,
    gitsigns = true,
    telescope = true,
    which_key = true,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    bufferline = true,
    hop = true,
  },
}
