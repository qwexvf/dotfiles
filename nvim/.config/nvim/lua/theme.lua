vim.g.catppuccin_flavour = "mocha"

local colors = require("catppuccin.palettes").get_palette()

colors.none = "NONE"

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
		strings = { "bold" },
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = { "bold" },
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
		fidget = true,
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
	},
	custom_highlights = {
		Comment = { fg = colors.flamingo },
		TSConstBuiltin = { fg = colors.peach, style = {} },
		TSConstant = { fg = colors.sky },
		TSComment = { fg = colors.surface2, style = { "italic" } },

		-- Comment = { fg = colors.overlay1 },
		LineNr = { fg = colors.overlay1 },
		CursorLine = { bg = colors.none },
		CursorLineNr = { fg = colors.lavender },
		DiagnosticVirtualTextError = { bg = colors.none },
		DiagnosticVirtualTextWarn = { bg = colors.none },
		DiagnosticVirtualTextInfo = { bg = colors.none },
		DiagnosticVirtualTextHint = { bg = colors.none },
	},
}

-- setup must be called before loading
vim.cmd "colorscheme catppuccin"

require("bufferline").setup {
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
}
