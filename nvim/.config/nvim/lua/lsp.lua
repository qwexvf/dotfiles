require("neodev").setup {}

local nvim_lsp = require "lspconfig"
local cmp = require "cmp"
local lspkind = require "lspkind"
local log = require "vim.lsp.log"

local noremap = { noremap = true, silent = true }

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, noremap)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, noremap)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, noremap)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, noremap)

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

vim.diagnostic.config {
	virtual_text = false,
	signs = true,
	float = {
		border = "single",
		focus = false,
		scope = "cursor",
		source = "always",
	},
}

-- small for to go to definition on new window or split tabs
local function goto_definition(split_cmd)
	local util = vim.lsp.util
	local api = vim.api

	-- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
	local handler = function(_, result, ctx)
		if result == nil or vim.tbl_isempty(result) then
			local _ = log.info() and log.info(ctx.method, "No location found")
			return nil
		end

		if split_cmd then
			vim.cmd(split_cmd)
		end

		if vim.tbl_islist(result) then
			util.jump_to_location(result[1])

			if #result > 1 then
				util.set_qflist(util.locations_to_items(result))
				api.nvim_command "copen"
				api.nvim_command "wincmd p"
			end
		else
			util.jump_to_location(result)
		end
	end

	return handler
end

lspkind.init {
	mode = "symbol_text",
	preset = "codicons",
	symbol_map = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "ﰠ",
		Variable = "",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "塞",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "פּ",
		Event = "",
		Operator = "",
		TypeParameter = "",
	},
}

cmp.setup {
	snippet = {
		expand = function(args)
			require("luasnip.loaders.from_vscode").load()
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
		["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
		["<Down>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
		["<Up>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
	},
	sources = cmp.config.sources {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "treesitter" },
		{ name = "cmp_git" },
		{ name = "buffer" },
		{ name = "path" },
	},
	formatting = {
		format = lspkind.cmp_format { mode = "symbol", with_text = true, maxwidth = 100 },
	},
}

-- Use buffer source for `/`.
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

require("cmp_git").setup {
	-- defaults
	filetypes = { "gitcommit" },
	remotes = { "upstream", "origin" }, -- in order of most to least prioritized
	git = {
		commits = {
			limit = 100,
		},
	},
	github = {
		issues = {
			filter = "all", -- assigned, created, mentioned, subscribed, all, repos
			limit = 100,
			state = "open", -- open, closed, all
		},
		mentions = {
			limit = 100,
		},
		pull_requests = {
			limit = 100,
			state = "open", -- open, closed, merged, all
		},
	},
}

local function create_capabilities()
	local _capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

	-- modify capabilities here
	_capabilities.textDocument.completion.completionItem.snippetSupport = true

	return _capabilities
end

local capabilities = create_capabilities()

-- Setup lspconfig.
local on_attach = function(client, bufnr)
	-- We'll use efm for formatting
	client.server_capabilities.documentFormattingProvider = false

	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	local bufopts = { noremap = true, silent = true }

	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", bufopts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", bufopts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", bufopts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", bufopts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", bufopts)
	buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", bufopts)
	buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", bufopts)
	buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", bufopts)
	buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", bufopts)
	buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", bufopts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", bufopts)
	buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", bufopts)

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		underline = true,
		signs = true,
		update_in_insert = true,
	})

	vim.lsp.handlers["textDocument/definition"] = goto_definition "split"
end

nvim_lsp.vuels.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "vls" },
	filetypes = { "vue" },
	init_options = {
		config = {
			css = {},
			emmet = {},
			html = {
				suggest = {},
			},
			javascript = {
				format = { "prettier" },
			},
			stylusSupremacy = {},
			typescript = {
				format = { "prettier" },
			},
			vetur = {
				completion = {
					autoImport = true,
					tagCasing = "kebab",
					useScaffoldSnippets = false,
				},
				format = {
					enable = true,
					defaultFormatter = {
						js = "prettier",
						ts = "prettier",
					},
					defaultFormatterOptions = {},
					scriptInitialIndent = false,
					styleInitialIndent = false,
				},
				useWorkspaceDependencies = false,
				validation = {
					script = true,
					style = true,
					template = true,
				},
			},
		},
	},
	root_dir = nvim_lsp.util.root_pattern("package.json", "vue.config.js"),
}

nvim_lsp.sumneko_lua.setup {
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = runtime_path,
			},
			diagnostics = {
				enable = true,
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}

nvim_lsp.tsserver.setup {
	cmd = { "bun", "run", "typescript-language-server", "--stdio" },
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp.gopls.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

-- Svelte
nvim_lsp.svelte.setup {
	on_attach = on_attach,
	capabilities = capabilities,
}

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup {
	cmd = { "rustup", "run", "nightly", "rust-analyzer" },
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		-- to enable rust-analyzer settings visit:
		-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
		["rust-analyzer"] = {
			-- enable clippy diagnostics on save
			checkOnSave = {
				command = "clippy",
			},
		},
	},
}

local elixir = require "elixir"
elixir.setup {
	settings = elixir.settings {
		dialyzerEnabled = true,
		fetchDeps = false,
		enableTestLenses = false,
		suggestSpecs = false,
	},
	cmd = { "/Users/qwexvf/Documents/elixir-ls/language_server.sh" },
	on_attach = function(client, bufnr)
		local map_opts = { buffer = true, noremap = true }

		-- run the codelens under the cursor
		vim.keymap.set("n", "<space>r", vim.lsp.codelens.run, map_opts)
		-- remove the pipe operator
		vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", map_opts)
		-- add the pipe operator
		vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", map_opts)
		vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", map_opts)

		-- standard lsp keybinds
		vim.keymap.set("n", "df", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", map_opts)
		vim.keymap.set("n", "gd", "<cmd>lua vim.diagnostic.open_float()<cr>", map_opts)
		vim.keymap.set("n", "dt", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>", map_opts)
		vim.keymap.set("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)
		-- keybinds for fzf-lsp.nvim: https://github.com/gfanto/fzf-lsp.nvim
		-- you could also use telescope.nvim: https://github.com/nvim-telescope/telescope.nvim
		-- there are also core vim.lsp functions that put the same data in the loclist
		vim.keymap.set("n", "gr", ":References<cr>", map_opts)
		vim.keymap.set("n", "g0", ":DocumentSymbols<cr>", map_opts)
		vim.keymap.set("n", "gW", ":WorkspaceSymbols<cr>", map_opts)
		vim.keymap.set("n", "<leader>d", ":Diagnostics<cr>", map_opts)

		-- keybinds for vim-vsnip: https://github.com/hrsh7th/vim-vsnip
		vim.cmd [[imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]
		vim.cmd [[smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']]

		-- update capabilities for nvim-cmp: https://github.com/hrsh7th/nvim-cmp
		require("cmp_nvim_lsp").default_capabilities(capabilities)

		return on_attach(client, bufnr)
	end,
}

require("symbols-outline").setup {
	highlight_hovered_item = true,
	show_guides = true,
	auto_preview = true,
	position = "right",
	relative_width = true,
	width = 10,
	auto_close = false,
	show_numbers = true,
	show_relative_numbers = true,
	show_symbol_details = true,
	preview_bg_highlight = "Pmenu",
	autofold_depth = nil,
	auto_unfold_hover = true,
	fold_markers = { "", "" },
	wrap = false,
	keymaps = { -- These keymaps can be a string or a table for multiple keys
		close = { "<Esc>", "q" },
		goto_location = "<Cr>",
		focus_location = "o",
		hover_symbol = "<C-space>",
		toggle_preview = "K",
		rename_symbol = "r",
		code_actions = "a",
		fold = "h",
		unfold = "l",
		fold_all = "W",
		unfold_all = "E",
		fold_reset = "R",
	},
	lsp_blacklist = {},
	symbol_blacklist = {},
	symbols = {
		File = { icon = "", hl = "TSURI" },
		Module = { icon = "", hl = "TSNamespace" },
		Namespace = { icon = "", hl = "TSNamespace" },
		Package = { icon = "", hl = "TSNamespace" },
		Class = { icon = "𝓒", hl = "TSType" },
		Method = { icon = "ƒ", hl = "TSMethod" },
		Property = { icon = "", hl = "TSMethod" },
		Field = { icon = "", hl = "TSField" },
		Constructor = { icon = "", hl = "TSConstructor" },
		Enum = { icon = "ℰ", hl = "TSType" },
		Interface = { icon = "ﰮ", hl = "TSType" },
		Function = { icon = "", hl = "TSFunction" },
		Variable = { icon = "", hl = "TSConstant" },
		Constant = { icon = "", hl = "TSConstant" },
		String = { icon = "𝓐", hl = "TSString" },
		Number = { icon = "#", hl = "TSNumber" },
		Boolean = { icon = "⊨", hl = "TSBoolean" },
		Array = { icon = "", hl = "TSConstant" },
		Object = { icon = "⦿", hl = "TSType" },
		Key = { icon = "🔐", hl = "TSType" },
		Null = { icon = "NULL", hl = "TSType" },
		EnumMember = { icon = "", hl = "TSField" },
		Struct = { icon = "𝓢", hl = "TSType" },
		Event = { icon = "🗲", hl = "TSType" },
		Operator = { icon = "+", hl = "TSOperator" },
		TypeParameter = { icon = "𝙏", hl = "TSParameter" },
	},
}

require("lspconfig").astro.setup {
	cmd = { "bun", "run", "astro-ls", "--stdio" },
}

require("go").setup()
