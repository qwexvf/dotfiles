vim.g.catppuccin_flavour = "mocha"

require("catppuccin").setup {
	transparent_background = true,
	term_colors = true,
	compile = {
		enabled = false,
		path = vim.fn.stdpath "cache" .. "/catppuccin",
	},
	dim_inactive = {
		enabled = true,
		shade = "dark",
		percentage = 0.15,
	},
	styles = {
		comments = { "italic" },
		conditionals = { "italic" },
		loops = {},
		functions = {},
		keywords = {},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
	integrations = {
		treesitter = true,
		treesitter_context = true,
		ts_rainbow = true,
		lsp_trouble = true,
		gitgutter = true,
		cmp = true,
		gitsigns = true,
		telescope = true,
		nvimtree = true,
		aerial = true,
		illuminate = true,
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
	color_overrides = {},
	highlight_overrides = {},
}

-- setup must be called before loading
vim.cmd "colorscheme catppuccin"

