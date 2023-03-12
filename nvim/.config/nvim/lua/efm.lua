local nvim_lsp = require "lspconfig"
local prettierd = { formatCommand = "bun run prettierd \"${INPUT}\"", formatStdin = true }

local elixir_format = {
	lintCommand = "MIX_ENV=test mix credo suggest --format=flycheck --read-from-stdin ${INPUT}",
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %m", "%f:%l %t: %m" },
	lintIgnoreExitCode = true,
	formatCommand = "mix format -",
	formatStdin = true,
}

local go = {
	formatCommand = "goimports",
	formatStdin = true,
}

local formatter = "stylua"
local command = string.format("%s --color Never -", formatter)

local stylua = {
	formatCommand = command,
	formatStdin = true,
	rootMarkers = { "stylua.toml", ".stylua.toml" },
}

nvim_lsp.efm.setup {
	init_options = { documentFormatting = true },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			vue = { prettierd },
			javascript = { prettierd },
			javascriptreact = { prettierd },
			typescript = { prettierd },
			["javascript.jsx"] = { prettierd },
			typescriptreact = { prettierd },
			["typescript.tsx"] = { prettierd },
			elixir = { elixir_format },
			go = { go },
			lua = { stylua },
		},
	},
	filetypes = {
		"go",
		"lua",
		"vue",
		"elixir",
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescript.tsx",
		"typescriptreact",
	},
}
