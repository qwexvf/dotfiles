return {
  "stevearc/oil.nvim",
  opts = {},
  cmd = "Oil",
  keys = {
    -- i wanna use "space" + "-" as a key to open the parent directory
    {
      "<leader>-",
      function()
        require("oil").open()
      end,
      desc = "Open parent directory",
    },
  },
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
}
