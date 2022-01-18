-- local nightfox = require('nightfox')

-- This function set the configuration of nightfox. If a value is not passed in the setup function
-- it will be taken from the default configuration above
-- nightfox.setup({
--   fox = "nordfox", -- change the colorscheme to use nordfox
--   styles = {
--     comments = "italic", -- change style of comments to be italic
--     keywords = "bold", -- change style of keywords to be bold
--     functions = "italic,bold" -- styles can be a comma separated list
--   },
--   inverse = {
--     match_paren = true, -- inverse the highlighting of match_parens
--   },
--   colors = {
--     red = "#FF000", -- Override the red color for MAX POWER
--     bg_alt = "#000000",
--   },
--   hlgroups = {
--     TSPunctDelimiter = { fg = "${red}" }, -- Override a highlight group with the color red
--     LspCodeLens = { bg = "#000000", style = "italic" },
--   }
-- })

-- Load the configuration set above and apply the colorscheme
-- nightfox.load()
local catppuccin = require("catppuccin")

catppuccin.setup({
  transparent_background = true,
  term_colors = false,
  styles = {
    comments = "italic",
    functions = "italic",
    keywords = "italic",
    strings = "NONE",
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
      },
    },
    lsp_trouble = true,
    cmp = true,
    lsp_saga = false,
    gitgutter = false,
    gitsigns = true,
    telescope = true,
    nvimtree = {
      enabled = true,
      show_root = false,
    },
    which_key = false,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    dashboard = true,
    neogit = false,
    vim_sneak = false,
    fern = false,
    barbar = false,
    bufferline = true,
    markdown = true,
    lightspeed = false,
    ts_rainbow = false,
    hop = false,
    notify = true,
    telekasten = true,
  }
})
