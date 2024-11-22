return {
  "echasnovski/mini.files",
  version = false,
  config = function()
    require("mini.files").setup()
  end,
  keys = {
    {
      "<leader>ff",
      function()
        require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
      end,
      desc = "Open file tree",
    },
  },
}
