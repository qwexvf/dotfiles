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
	"wbthomason/packer.nvim",
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	"tpope/vim-commentary",
	"tpope/vim-surround",

	-- Extra languages
	"rust-lang/rust.vim",
	{ "mhanberg/elixir.nvim", dependencies = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" } },
	"earthly/earthly.vim",
	"jparise/vim-graphql",
	"ray-x/go.nvim",
	"ray-x/guihua.lua", -- recommanded if need floating window support

	-- Focus
	"beauwilliams/focus.nvim",

	-- UI to select things (files, grep results, open buffers...)
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{ "catppuccin/nvim", as = "catppuccin" },
	"EdenEast/nightfox.nvim",
	{ "Everblush/everblush.nvim", as = "everblush" },
    { "sainnhe/everforest" },
    {"rebelot/kanagawa.nvim"},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons", opt = true },
	},
	"akinsho/bufferline.nvim",

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
