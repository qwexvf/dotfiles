require('dd').setup({
  -- The time to wait before displaying newly produced diagnostics.
  timeout = 300
})

-- Cool Statusline bc why not?
require('lualine').setup({options = {theme = 'catppuccino'}})

-- Cool Tabs
require('bufferline').setup({options = {diagnostics = 'nvim_lsp'}})

-- add git signs
require('gitsigns').setup()

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

require('nvim-autopairs').setup{}

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require("nvim-treesitter.configs").setup({
	ensure_installed = { "javascript", "typescript", "lua" },
	highlight = {
		enable = true,
	},
	indent = {
		enable = false,
	},
	additional_vim_regex_highlighting = true,
})
