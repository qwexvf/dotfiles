local nvim_lsp = require("lspconfig")

local elixir_format = {
    lintCommand = "MIX_ENV=test mix credo suggest --format=flycheck --read-from-stdin ${INPUT}",
    lintStdin = true,
    lintFormats = { "%f:%l:%c: %m", "%f:%l %t: %m" },
    lintIgnoreExitCode = true,
    formatCommand = "mix format -",
    formatStdin = true,
}

local stylua = {
    formatCommand = "stylua --color Never -",
    formatStdin = true,
    rootMarkers = { "stylua.toml", ".stylua.toml" },
}

nvim_lsp.efm.setup({
    init_options = { documentFormatting = true },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            elixir = { elixir_format },
            lua = { stylua },
        },
    },
    filetypes = {
        "go",
        "lua",
        "elixir",
    },
})
