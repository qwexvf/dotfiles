return {
  "elixir-tools/elixir-tools.nvim",
  version = "*",
  ft = "elixir",
  config = function()
    local elixir = require "elixir"
    local elixirls = require "elixir.elixirls"
    local utils = require "utils"

    local on_attach = utils.on_attach
    local capabilities = utils.capabilities

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
        on_attach = function(client, bufnr)
          vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
          vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
          vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })

          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
      },
    }
  end,
}
