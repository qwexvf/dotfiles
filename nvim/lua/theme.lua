local catppuccino = require("catppuccino")

-- configure it
catppuccino.setup ({
  colorscheme = "neon_latte",
  transparency = true,
  term_colors = true,
  styles = {
    comments = "italic",
    functions = "bold",
    keywords = "italic",
    strings = "bold",
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
    gitsigns = false,
    telescope = true,
    which_key = true,
    bufferline = true,
  }
})
