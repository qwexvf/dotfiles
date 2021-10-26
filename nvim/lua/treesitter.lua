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
	additional_vim_regex_highlighting = false,
})
