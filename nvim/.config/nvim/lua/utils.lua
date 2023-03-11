require("nvim-web-devicons").setup {
	default = true,
}

require("gitsigns").setup {
	signs = {
		add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
		change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
		delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
		changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	keymaps = {
		-- Default keymap options
		noremap = true,

		["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'" },
		["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'" },

		["n <leader>hs"] = "<cmd>Gitsigns stage_hunk<CR>",
		["v <leader>hs"] = ":Gitsigns stage_hunk<CR>",
		["n <leader>hu"] = "<cmd>Gitsigns undo_stage_hunk<CR>",
		["n <leader>hr"] = "<cmd>Gitsigns reset_hunk<CR>",
		["v <leader>hr"] = ":Gitsigns reset_hunk<CR>",
		["n <leader>hR"] = "<cmd>Gitsigns reset_buffer<CR>",
		["n <leader>hp"] = "<cmd>Gitsigns preview_hunk<CR>",
		["n <leader>hb"] = "<cmd>lua require\"gitsigns\".blame_line{full=true}<CR>",
		["n <leader>hS"] = "<cmd>Gitsigns stage_buffer<CR>",
		["n <leader>hU"] = "<cmd>Gitsigns reset_buffer_index<CR>",

		-- Text objects
		["o ih"] = ":<C-U>Gitsigns select_hunk<CR>",
		["x ih"] = ":<C-U>Gitsigns select_hunk<CR>",
	},
	watch_gitdir = {
		interval = 1000,
		follow_files = true,
	},
	attach_to_untracked = true,
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 300,
		ignore_whitespace = false,
	},
	current_line_blame_formatter_opts = {
		relative_time = false,
	},
	sign_priority = 6,
	update_debounce = 5,
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	yadm = {
		enable = false,
	},
}

require("nvim-autopairs").setup {}

-- Cool trobleshooting
require("trouble").setup {}

-- Colorizer
require("colorizer").setup {}

require("fidget").setup {
	window = {
		blend = 0,
	},
}
require("filetype").setup {}
require("focus").setup()

require("aerial").setup {
	backends = { "treesitter", "lsp", "markdown" },
	layout = {
		max_width = { 40, 0.2 },
		width = nil,
		min_width = 10,
		default_direction = "prefer_right",
		placement = "window",
	},
	attach_mode = "window",
	close_automatic_events = {},
	default_bindings = true,
	disable_max_lines = 10000,
	disable_max_size = 2000000, -- Default 2MB
	filter_kind = {
		"Class",
		"Constructor",
		"Enum",
		"Function",
		"Interface",
		"Module",
		"Method",
		"Struct",
		"Variable",
	},
	highlight_mode = "split_width",
	highlight_closest = true,
	highlight_on_hover = false,
	highlight_on_jump = 300,
	icons = {},
	ignore = {
		unlisted_buffers = true,
		filetypes = {},
		buftypes = "special",
		wintypes = "special",
	},
	link_folds_to_tree = false,
	link_tree_to_folds = true,
	manage_folds = false,
	nerd_font = "auto",
	on_first_symbols = nil,
	open_automatic = false,
	post_jump_cmd = "normal! zz",
	close_on_select = false,
	show_guides = false,
	update_events = "TextChanged,InsertLeave",
	guides = {
		mid_item = "├─",
		last_item = "└─",
		nested_top = "│ ",
		whitespace = "  ",
	},
	float = {
		border = "rounded",
		relative = "cursor",
		max_height = 0.9,
		height = nil,
		min_height = { 8, 0.1 },
		override = function(conf)
			return conf
		end,
	},
	lsp = {
		diagnostics_trigger_update = true,
		update_when_errors = true,
		update_delay = 300,
	},
	treesitter = {
		update_delay = 300,
	},
	markdown = {
		update_delay = 300,
	},
}

-- default configuration
require("illuminate").configure {
	providers = {
		"lsp",
		"treesitter",
		"regex",
	},
	delay = 100,
	filetype_overrides = {},
	filetypes_denylist = {
		"dirvish",
		"fugitive",
	},
	filetypes_allowlist = {},
	modes_denylist = {},
	modes_allowlist = {},
	providers_regex_syntax_denylist = {},
	providers_regex_syntax_allowlist = {},
	under_cursor = true,
	large_file_cutoff = nil,
	large_file_overrides = nil,
}

require("hlslens").setup {}

require("bufferline").setup {}

require("telescope").load_extension "file_browser"
