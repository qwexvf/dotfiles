local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({
                default = true,
            })
        end,
    },
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    "tpope/vim-commentary",
    "tpope/vim-surround",

    -- Extra languages
    { "rust-lang/rust.vim", ft = { "rust" } },
    {
        "elixir-tools/elixir-tools.nvim",
        version = "*",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
    },
    "earthly/earthly.vim",
    "jparise/vim-graphql",
    {
        "akinsho/flutter-tools.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim", -- optional for vim.ui.select
        },
    },

    -- Focus
    "beauwilliams/focus.nvim",
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("bufferline").setup({})
        end,
    },

    -- Go
    {
        "qwexvf/go.nvim",
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
        },
        build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.3",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- lsp icons
    {
        "onsails/lspkind-nvim",
    },

    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",

    -- Highlight, edit, and navigate code using a fast incremental parsing library
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
        },
    },

    {
        "SmiteshP/nvim-navic",
        dependencies = "neovim/nvim-lspconfig",
    },

    "neovim/nvim-lspconfig",
    {
        "folke/trouble.nvim",
        setup = function()
            -- Cool trobleshooting
            require("trouble").setup({})
        end,
    },
    "folke/neodev.nvim",
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "mcchrish/zenbones.nvim",
        lazy = false,
        priority = 1000,
        dependencies = { "rktjmp/lush.nvim" },
    },

    -- auto complete
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",

    {
        "petertriho/cmp-git",
        dependencies = "nvim-lua/plenary.nvim",
    },

    { "L3MON4D3/LuaSnip", dependencies = "rafamadriz/friendly-snippets" },
    "saadparwaiz1/cmp_luasnip",

    -- Utilities
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            -- Colorizer
            require("colorizer").setup({})
        end,
    },
    {
        "nvimdev/lspsaga.nvim",
        config = function()
            require("lspsaga").setup({})
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter", -- optional
            "nvim-tree/nvim-web-devicons", -- optional
        },
    },
    "stevearc/aerial.nvim",
    "nvim-lualine/lualine.nvim",

    -- Window & Animations
    "camspiers/animate.vim",
    { "camspiers/lens.vim", dependencies = "nvim-lua/plenary.nvim" },
    {
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("hlslens").setup({})
        end,
    },
    "windwp/windline.nvim",
    "svban/YankAssassin.vim",
    "sunjon/shade.nvim",
    "andweeb/presence.nvim",
    "RRethy/vim-illuminate",
    "simrat39/symbols-outline.nvim",
    {
        "Shatur/neovim-session-manager",
        event = "BufWritePost",
        cmd = "SessionManager",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            local Path = require("plenary.path")
            local session_manager = require("session_manager")
            local config = require("session_manager.config")
            session_manager.setup({
                sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"),
                path_replacer = "__",
                colon_replacer = "++",
                autoload_mode = config.AutoloadMode.CurrentDir,
                autosave_last_session = true,
                autosave_ignore_not_normal = true,
                autosave_ignore_dirs = {},
                autosave_ignore_filetypes = {
                    "gitcommit",
                },
                autosave_ignore_buftypes = {},
                autosave_only_in_session = true,
                max_path_length = 80,
            })
        end,
    },
})
