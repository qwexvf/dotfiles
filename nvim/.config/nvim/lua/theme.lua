require("indent_blankline").setup {
	-- for example, context is off by default, use this to turn it on
	show_current_context = true,
	show_current_context_start = true,
}

require("github-theme").setup {
	theme_style = "dark",
	sidebars = { "qf", "vista_kind", "terminal", "packer" },
}

require("lualine").setup {
	options = {
		theme = "auto", -- or you can assign github_* themes individually.
		-- ... your lualine config
	},
}

-- setup must be called before loading
vim.cmd "colorscheme github_dark_default"
