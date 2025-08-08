return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({
        winopts = {
          height = 0.80,
          width = 0.87,
          preview = {
            horizontal = "right:55%",
          },
        },
        keymap = {
          fzf = {
            ["ctrl-j"] = "down",
            ["ctrl-k"] = "up",
          },
        },
      })
    end,
  },
}
