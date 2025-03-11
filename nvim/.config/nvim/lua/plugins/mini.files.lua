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
        require("mini.files").open()
      end,
      desc = "Open file tree",
    },
  },
}
