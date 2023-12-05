return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    lazy = false,
    config = function()
        require("ibl").setup()
    end,
}
