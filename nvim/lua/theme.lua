local catppuccino = require("catppuccino")

-- configure it
catppuccino.setup ({
  colorscheme = "neon_latte",
  transparency = false,
  term_colors = false,
  styles = {
    comments = "italic",
    functions = "italic",
    keywords = "italic",
    strings = "italic",
    variables = "italic",
  },
  integrations = {
    treesitter = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = "italic",
        hints = "italic",
        warnings = "italic",
        information = "italic",
      },
      underlines = {
        errors = "underline",
        hints = "underline",
        warnings = "underline",
        information = "underline",
      }
    },
    gitsigns = true,
    telescope = true,
    which_key = true,
    bufferline = true,
  }
})
