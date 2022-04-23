local cmd = vim.cmd

-- Default options
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false,    -- Disable setting background
    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,   -- Non focused panes set to alternative background
    styles = {              -- Style to be applied to different syntax groups
      comments = "italic",    -- Value is any valid attr-list value `:help attr-list`
      conditionals = "bold",
      constants = "bold",
      functions = "italic",
      keywords = "bold",
      numbers = "NONE",
      operators = "NONE",
      strings = "bold",
      types = "bold",
      variables = "bold",
    },
    inverse = {
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {
       barbar = true,
       cmp = true,
       dashboard = true,
       diagnostic = true,
       fern = true,
       fidget = true,
       gitsigns = true,
       glyph_palette = true,
       hop = true,
       illuminate = true,
       lightspeed = true,
       lsp_saga = true,
       lsp_trouble = true,
       modes = true,
       native_lsp = true,
       neogit = true,
       neotree = true,
       notify = true,
       nvimtree = true,
       pounce = true,
       sneak = true,
       symbol_outline = true,
       telescope = true,
       treesitter = true,
       tsrainbow = true,
       whichkey = true
    },
  }
})

-- setup must be called before loading
cmd [[colorscheme nightfox]]
