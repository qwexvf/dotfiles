local nvim_lsp = require "lspconfig"

local eslint = {
    lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
    lintStdin = true,
    lintFormats = {
        "%f(%l,%c): %tarning %m",
        "%f(%l,%c): %rror %m",
    },
    lintIgnoreExitCode = true,
    formatCommand = "eslint_d --stdin --fix-to-stdout --stdin-filename=${INPUT}",
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

local stylua = {
    formatCommand = "stylua --color Never -",
    formatStdin = true,
    rootMarkers = { "stylua.toml", ".stylua.toml" },
}

nvim_lsp.efm.setup {
    init_options = { documentFormatting = true },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            vue = { eslint },
            javascript = { eslint },
            javascriptreact = { eslint },
            typescript = { eslint },
            ["javascript.jsx"] = { eslint },
            typescriptreact = { eslint },
            ["typescript.tsx"] = { eslint },
            elixir = { elixir_format },
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
