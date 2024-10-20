local config = function()
  require("nvim-treesitter.configs").setup {
    build = ":TSUpdate",
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    ensure_installed = {
      "json",
      "javascript",
      "typescript",
      "html",
      "css",
      "bash",
      "lua",
      "dockerfile",
      "gitignore",
      "python",
      "vue",
      "go",
      "elixir",
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-s>",
        node_incremental = "<C-s>",
        scope_incremental = false,
        node_decremental = "<BS>",
      },
    },
  }
end

return {
  "nvim-treesitter/nvim-treesitter",
  config = config,
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
}
