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
        ft = { "elixir" },
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    "earthly/earthly.vim",
    "jparise/vim-graphql",

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
        config = function()
            -- golang
            require("go").setup({
                lsp_cfg = false,
            })

            local cfg = require("go.lsp").config() -- config() return the go.nvim gopls setup
            require("lspconfig").gopls.setup(cfg)
        end,
    },

    -- UI to select things (files, grep results, open buffers...)
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                enabled = vim.fn.executable("make") == 1,
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
            },
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                defaults = {
                    path_display = { "truncate" },
                    sorting_strategy = "ascending",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    mappings = {
                        i = {
                            ["<C-n>"] = actions.cycle_history_next,
                            ["<C-p>"] = actions.cycle_history_prev,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                        },
                        n = { ["q"] = actions.close },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                },
            })

            telescope.load_extension("fzf")
            telescope.load_extension("file_browser")
        end,
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
    "j-hui/fidget.nvim",
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
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require("lspsaga").setup({})
        end,
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            --Please make sure you install markdown and markdown_inline parser
            { "nvim-treesitter/nvim-treesitter" },
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
    {
        "jose-elias-alvarez/null-ls.nvim",
    },
})
