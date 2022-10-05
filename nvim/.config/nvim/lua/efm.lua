local nvim_lsp = require "lspconfig"

local prettierd = {
	formatCommand = "prettierd \"${INPUT}\"",
	formatStdin = true,
}

local stylua = {
	formatCommand = "stylua -s -",
	formatStdin = true,
}

local elixir_format = {
	lintCommand = "MIX_ENV=test mix credo suggest --format=flycheck --read-from-stdin ${INPUT}",
	lintStdin = true,
	lintFormats = { "%f:%l:%c: %m", "%f:%l %t: %m" },
	lintIgnoreExitCode = true,
	formatCommand = "mix format -",
	formatStdin = true,
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
			lua = { stylua },
		},
	},
	filetypes = {
		"vue",
		"elixir",
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescript.tsx",
		"typescriptreact",
		"lua",
	},
}
