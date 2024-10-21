local config = function()
    -- apply lazydev.nvim sources config
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    local lspkind = require "lspkind"

    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup {
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert {
            ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
            ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
            ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
            ["<CR>"] = cmp.mapping.confirm { select = false },
        },
        -- sources for autocompletion
        sources = cmp.config.sources {
            { name = "luasnip" },  -- snippets
            { name = "nvim_lsp" }, -- lsp
            { name = "buffer" },   -- text within current buffer
            { name = "path" },     -- file system paths
        },
        -- configure lspkind for vs-code like icons
        formatting = {
            format = lspkind.cmp_format {
                maxwidth = 50,
                ellipsis_char = "...",
            },
        },
    }
end

return {
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp",
    version = false,
    lazy = false,
    config = config,
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "onsails/lspkind.nvim",
        {
            "L3MON4D3/LuaSnip",
            lazy = false,
            version = "2.*",
            build = "make install_jsregexp",
        },
        {
            "rafamadriz/friendly-snippets",
            lazy = false,
        },
    },
}
