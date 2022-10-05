require("nvim-web-devicons").setup {
	default = true,
}

-- The time to wait before displaying newly produced diagnostics.
require("dd").setup {
	timeout = 100,
}

-- Cool Tabs
require("bufferline").setup { highlights = require("catppuccin.groups.integrations.bufferline").get() }

-- Add git signs
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

-- Motion
require("hop").setup { keys = "etovxqpdygfblzhckisuran", term_seq_bias = 0.5 }

-- Colorizer
require("colorizer").setup {}

require("indent_blankline").setup {
	-- for example, context is off by default, use this to turn it on
	show_current_context = true,
	show_current_context_start = true,
	buftype_exclude = { "terminal" },
}

-- Don't run these plugisn on macos
if not vim.g.os == "Darwin" then
	-- Discord
	require("presence"):setup {
		-- General options
		auto_update = true,
		neovim_image_text = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
		main_image = "neovim", -- Main image display (either "neovim" or "file")
		-- client_id = '150256181439496192', -- Use your own Discord application client id (not recommended)
		log_level = "info", -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
		debounce_timeout = 10,
		enable_line_number = true,
		blacklist = {},
		buttons = true,
		file_assets = {},

		-- Rich Presence text options
		editing_text = "Editing %s",
		file_explorer_text = "Browsing %s",
		git_commit_text = "Committing changes",
		plugin_manager_text = "Managing plugins",
		reading_text = "Reading %s",
		workspace_text = "Working on %s",
		line_number_text = "Line %s out of %s",
	}
end

-- indicator
require("fidget").setup {}

-- In init.lua or filetype.nvim's config file
require("filetype").setup {}

require("focus").setup()

require("lualine").setup {
	options = {
		theme = "catppuccin",
	},
}

-- Call the setup function to change the default behavior
require("aerial").setup {
	-- Priority list of preferred backends for aerial.
	-- This can be a filetype map (see :help aerial-filetype-map)
	backends = { "treesitter", "lsp", "markdown" },

	layout = {
		-- These control the width of the aerial window.
		-- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		-- min_width and max_width can be a list of mixed types.
		-- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
		max_width = { 40, 0.2 },
		width = nil,
		min_width = 10,

		-- Determines the default direction to open the aerial window. The 'prefer'
		-- options will open the window in the other direction *if* there is a
		-- different buffer in the way of the preferred direction
		-- Enum: prefer_right, prefer_left, right, left, float
		default_direction = "prefer_right",

		-- Determines where the aerial window will be opened
		--   edge   - open aerial at the far right/left of the editor
		--   window - open aerial to the right/left of the current window
		placement = "window",
	},

	-- Determines how the aerial window decides which buffer to display symbols for
	--   window - aerial window will display symbols for the buffer in the window from which it was opened
	--   global - aerial window will display symbols for the current window
	attach_mode = "window",

	-- List of enum values that configure when to auto-close the aerial window
	--   unfocus       - close aerial when you leave the original source window
	--   switch_buffer - close aerial when you change buffers in the source window
	--   unsupported   - close aerial when attaching to a buffer that has no symbol source
	close_automatic_events = {},

	-- Set to false to remove the default keybindings for the aerial buffer
	default_bindings = true,

	-- Disable aerial on files with this many lines
	disable_max_lines = 10000,

	-- Disable aerial on files this size or larger (in bytes)
	disable_max_size = 2000000, -- Default 2MB

	-- A list of all symbols to display. Set to false to display all symbols.
	-- This can be a filetype map (see :help aerial-filetype-map)
	-- To see all available values, see :help SymbolKind
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

	-- Determines line highlighting mode when multiple splits are visible.
	-- split_width   Each open window will have its cursor location marked in the
	--               aerial buffer. Each line will only be partially highlighted
	--               to indicate which window is at that location.
	-- full_width    Each open window will have its cursor location marked as a
	--               full-width highlight in the aerial buffer.
	-- last          Only the most-recently focused window will have its location
	--               marked in the aerial buffer.
	-- none          Do not show the cursor locations in the aerial window.
	highlight_mode = "split_width",

	-- Highlight the closest symbol if the cursor is not exactly on one.
	highlight_closest = true,

	-- Highlight the symbol in the source buffer when cursor is in the aerial win
	highlight_on_hover = false,

	-- When jumping to a symbol, highlight the line for this many ms.
	-- Set to false to disable
	highlight_on_jump = 300,

	-- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
	-- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
	-- default collapsed icon. The default icon set is determined by the
	-- "nerd_font" option below.
	-- If you have lspkind-nvim installed, it will be the default icon set.
	-- This can be a filetype map (see :help aerial-filetype-map)
	icons = {},

	-- Control which windows and buffers aerial should ignore.
	-- If attach_mode is "global", focusing an ignored window/buffer will
	-- not cause the aerial window to update.
	-- If open_automatic is true, focusing an ignored window/buffer will not
	-- cause an aerial window to open.
	-- If open_automatic is a function, ignore rules have no effect on aerial
	-- window opening behavior; it's entirely handled by the open_automatic
	-- function.
	ignore = {
		-- Ignore unlisted buffers. See :help buflisted
		unlisted_buffers = true,

		-- List of filetypes to ignore.
		filetypes = {},

		-- Ignored buftypes.
		-- Can be one of the following:
		-- false or nil - No buftypes are ignored.
		-- "special"    - All buffers other than normal buffers are ignored.
		-- table        - A list of buftypes to ignore. See :help buftype for the
		--                possible values.
		-- function     - A function that returns true if the buffer should be
		--                ignored or false if it should not be ignored.
		--                Takes two arguments, `bufnr` and `buftype`.
		buftypes = "special",

		-- Ignored wintypes.
		-- Can be one of the following:
		-- false or nil - No wintypes are ignored.
		-- "special"    - All windows other than normal windows are ignored.
		-- table        - A list of wintypes to ignore. See :help win_gettype() for the
		--                possible values.
		-- function     - A function that returns true if the window should be
		--                ignored or false if it should not be ignored.
		--                Takes two arguments, `winid` and `wintype`.
		wintypes = "special",
	},

	-- When you fold code with za, zo, or zc, update the aerial tree as well.
	-- Only works when manage_folds = true
	link_folds_to_tree = false,

	-- Fold code when you open/collapse symbols in the tree.
	-- Only works when manage_folds = true
	link_tree_to_folds = true,

	-- Use symbol tree for folding. Set to true or false to enable/disable
	-- 'auto' will manage folds if your previous foldmethod was 'manual'
	manage_folds = false,

	-- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
	-- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
	nerd_font = "auto",

	-- Call this function when aerial attaches to a buffer.
	-- Useful for setting keymaps. Takes a single `bufnr` argument.
	on_attach = nil,

	-- Call this function when aerial first sets symbols on a buffer.
	-- Takes a single `bufnr` argument.
	on_first_symbols = nil,

	-- Automatically open aerial when entering supported buffers.
	-- This can be a function (see :help aerial-open-automatic)
	open_automatic = false,

	-- Run this command after jumping to a symbol (false will disable)
	post_jump_cmd = "normal! zz",

	-- When true, aerial will automatically close after jumping to a symbol
	close_on_select = false,

	-- Show box drawing characters for the tree hierarchy
	show_guides = false,

	-- The autocmds that trigger symbols update (not used for LSP backend)
	update_events = "TextChanged,InsertLeave",

	-- Customize the characters used when show_guides = true
	guides = {
		-- When the child item has a sibling below it
		mid_item = "├─",
		-- When the child item is the last in the list
		last_item = "└─",
		-- When there are nested child guides to the right
		nested_top = "│ ",
		-- Raw indentation
		whitespace = "  ",
	},

	-- Options for opening aerial in a floating win
	float = {
		-- Controls border appearance. Passed to nvim_open_win
		border = "rounded",

		-- Determines location of floating window
		--   cursor - Opens float on top of the cursor
		--   editor - Opens float centered in the editor
		--   win    - Opens float centered in the window
		relative = "cursor",

		-- These control the height of the floating window.
		-- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		-- min_height and max_height can be a list of mixed types.
		-- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
		max_height = 0.9,
		height = nil,
		min_height = { 8, 0.1 },

		override = function(conf)
			-- This is the config that will be passed to nvim_open_win.
			-- Change values here to customize the layout
			return conf
		end,
	},

	lsp = {
		-- Fetch document symbols when LSP diagnostics update.
		-- If false, will update on buffer changes.
		diagnostics_trigger_update = true,

		-- Set to false to not update the symbols when there are LSP errors
		update_when_errors = true,

		-- How long to wait (in ms) after a buffer change before updating
		-- Only used when diagnostics_trigger_update = false
		update_delay = 300,
	},

	treesitter = {
		-- How long to wait (in ms) after a buffer change before updating
		update_delay = 300,
	},

	markdown = {
		-- How long to wait (in ms) after a buffer change before updating
		update_delay = 300,
	},
}

-- default configuration
require("illuminate").configure {
	-- providers: provider used to get references in the buffer, ordered by priority
	providers = {
		"lsp",
		"treesitter",
		"regex",
	},
	-- delay: delay in milliseconds
	delay = 100,
	-- filetype_overrides: filetype specific overrides.
	-- The keys are strings to represent the filetype while the values are tables that
	-- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
	filetype_overrides = {},
	-- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
	filetypes_denylist = {
		"dirvish",
		"fugitive",
	},
	-- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
	filetypes_allowlist = {},
	-- modes_denylist: modes to not illuminate, this overrides modes_allowlist
	modes_denylist = {},
	-- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
	modes_allowlist = {},
	-- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
	-- Only applies to the 'regex' provider
	-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
	providers_regex_syntax_denylist = {},
	-- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
	-- Only applies to the 'regex' provider
	-- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
	providers_regex_syntax_allowlist = {},
	-- under_cursor: whether or not to illuminate under the cursor
	under_cursor = true,
	-- large_file_cutoff: number of lines at which to use large_file_config
	-- The `under_cursor` option is disabled when this cutoff is hit
	large_file_cutoff = nil,
	-- large_file_config: config to use for large files (based on large_file_cutoff).
	-- Supports the same keys passed to .configure
	-- If nil, vim-illuminate will be disabled for large files.
	large_file_overrides = nil,
}

local telescope = require "telescope"

-- Best fzf finder
telescope.setup {}
