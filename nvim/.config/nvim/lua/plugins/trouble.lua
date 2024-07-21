return {
    "folke/trouble.nvim",
    lazy = false,
    cmd = "Trouble",
    config = function()
        require("trouble").setup()
    end,
}
