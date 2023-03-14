local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
	"kyazdani42/nvim-web-devicons",
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-commentary",
	"tpope/vim-surround",

	-- Extra languages
	"rust-lang/rust.vim",
	{ "mhanberg/elixir.nvim", dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" } },
	"earthly/earthly.vim",
	"jparise/vim-graphql",

	-- Focus
	"beauwilliams/focus.nvim",
	"akinsho/bufferline.nvim",

	-- Go
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup()
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ":lua require(\"go.install\").update_all_sync()", -- if you need to install/update all binaries
	},
	-- UI to select things (files, grep results, open buffers...)
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	{ "projekt0n/github-nvim-theme", lazy = false, priority = 1000 },
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- lsp icons
	"onsails/lspkind-nvim",

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
	"folke/trouble.nvim",
	"folke/neodev.nvim",

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
	"windwp/nvim-autopairs",
	"norcalli/nvim-colorizer.lua",
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		config = function()
			require("lspsaga").setup {}
		end,
	},
	"stevearc/aerial.nvim",
	"nvim-lualine/lualine.nvim",

	-- Window & Animations
	"camspiers/animate.vim",
	{ "camspiers/lens.vim", dependencies = "nvim-lua/plenary.nvim" },

	-- faster filetype
	"nathom/filetype.nvim",

	"kevinhwang91/nvim-hlslens",
	"lewis6991/impatient.nvim",
	"windwp/windline.nvim",
	"svban/YankAssassin.vim",
	"sunjon/shade.nvim",
	"andweeb/presence.nvim",
	"RRethy/vim-illuminate",
	"simrat39/symbols-outline.nvim",
}
