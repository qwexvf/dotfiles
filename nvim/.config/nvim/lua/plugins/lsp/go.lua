return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup {
      lsp_cfg = true,
    }
  end,
  ft = { "go", "gomod" },
  build = ":lua require(\"go.install\").update_all_sync()",
  lazy = false,
}
