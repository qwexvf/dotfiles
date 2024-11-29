return {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    ft = "elixir",
    config = function()
        local elixir = require "elixir"
        local elixirls = require "elixir.elixirls"

        elixir.setup {
            nextls = {
                enable = true,
            },
            credo = {},
            elixirls = {
                enable = true,
                settings = elixirls.settings {
                    dialyzerEnabled = false,
                    enableTestLenses = false,
                },
            },
        }
    end,
}
