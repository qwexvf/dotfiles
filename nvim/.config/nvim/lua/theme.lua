require("nightfox").setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false, -- Disable setting background
    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = true, -- Non focused panes set to alternative background
    styles = { -- Style to be applied to different syntax groups
      comments = "italic,bold", -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "bold",
      functions = "bold",
      keywords = "NONE",
      numbers = "italic",
      operators = "bold",
      strings = "bold",
      types = "NONE",
      variables = "italic",
    },
    inverse = { -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = { -- List of various plugins and additional options
      -- ...
      gitgutter = true,
      gitsigns = true,
      lsp_saga = true,
      lsp_trouble = true,
      telescope = true,
      treesitter = true,
      tsrainbow = true,
      fidget = true,
      cmp = true,
      diagnostic = true
    },
  },
})

-- setup must be called before loading
vim.cmd("colorscheme carbonfox")
