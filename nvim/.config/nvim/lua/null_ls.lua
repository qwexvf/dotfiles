local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- formatting
        null_ls.builtins.formatting.stylua.with({
            condition = function(utils)
                return utils.root_has_file({ 'stylua.toml', '.stylua.toml' })
            end,
        }),
        null_ls.builtins.formatting.rustfmt,
        null_ls.builtins.formatting.jq,
        null_ls.builtins.formatting.mdformat,
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.formatting.rome.with({
            condition = function(utils)
                return utils.root_has_file({ 'rome.json' })
            end,
        }),
        null_ls.builtins.formatting.prettier.with({
            condition = function(utils)
                return utils.root_has_file({ '.prettierrc' })
            end,
        }),

        -- diagnostics
        null_ls.builtins.diagnostics.eslint.with({
            condition = function(utils)
                return utils.root_has_file({ '.eslintrc.*' })
            end,
        }),
        null_ls.builtins.diagnostics.credo,
        null_ls.builtins.diagnostics.zsh,

        -- completion
        null_ls.builtins.completion.spell,
    },
})
