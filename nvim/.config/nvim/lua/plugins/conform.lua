return {
  "stevearc/conform.nvim",
  lazy = false,
  config = function()
    require("conform").setup {
      formatters_by_ft = {
        lua = { "stylua", args = { "--search-parent-directories" } },
        rust = { "rustfmt", lsp_format = "fallback" },
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    }
  end,
}
