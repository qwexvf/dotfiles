return {
    "ray-x/go.nvim",
    build = ":lua require(\"go.install\").update_all_sync()", -- if you need to install/update all binaries
    ft = { 'go', 'gomod' },
    config = function()
        require("go").setup {
        }
    end,
}
