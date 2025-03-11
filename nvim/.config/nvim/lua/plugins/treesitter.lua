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
        init_selection = "gnn", -- set to `false` to disable one of the mappings
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        },
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
