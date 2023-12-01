local config = function()
	require("nvim-treesitter.configs").setup {
		build = ":TSUpdate",
		indent = {
			enable = true,
		},
		autotag = {
			enable = true,
		},
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		ensure_installed = {
			"json",
			"javascript",
			"typescript",
			"html",
			"css",
			"bash",
			"lua",
			"dockerfile",
			"gitignore",
			"python",
			"vue",
		},
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-s>",
				node_incremental = "<C-s>",
				scope_incremental = false,
				node_decremental = "<BS>",
			},
		},
	}

	require("treesitter-context").setup {
		enable = true,
		throttle = true,
		max_lines = 0,
		patterns = {
			default = {
				"class",
				"function",
				"method",
				"for",
				"while",
				"if",
				"switch",
				"case",
			},
		},
	}
end

return {
	"nvim-treesitter/nvim-treesitter",
	config = config,
	lazy = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
	},
}
