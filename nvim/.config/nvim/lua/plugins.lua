local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    "git", "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
end

vim.cmd [[packadd packer.nvim]]

return require("packer").startup {
  function(use)
    use "kyazdani42/nvim-web-devicons"
    use "wbthomason/packer.nvim"
    use "tpope/vim-fugitive"
    use "tpope/vim-rhubarb"
    use "tpope/vim-commentary"
    use "tpope/vim-surround"

    -- Extra languages
    use "rust-lang/rust.vim"
    use({ "mhanberg/elixir.nvim", requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" } })
    use "earthly/earthly.vim"
    use "jparise/vim-graphql"

    -- Focus
    use "beauwilliams/focus.nvim"

    -- UI to select things (files, grep results, open buffers...)
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
      },
    }
    use { "EdenEast/nightfox.nvim" } -- Packer
    use { "Everblush/everblush.nvim", as = "everblush" }
    use {
      "nvim-lualine/lualine.nvim",
    }
    use {
      "akinsho/bufferline.nvim",
    }

    use {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
    }

    -- lsp icons
    use "onsails/lspkind-nvim"

    -- Add indentation guides even on blank lines
    use "lukas-reineke/indent-blankline.nvim"

    -- Highlight, edit, and navigate code using a fast incremental parsing library
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "nvim-treesitter/nvim-treesitter-context"
    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig"
    }

    use "neovim/nvim-lspconfig"
    use "j-hui/fidget.nvim"

    use {
      "folke/trouble.nvim",
    }

    -- auto complete
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"

    use {
      "petertriho/cmp-git",
      requires = "nvim-lua/plenary.nvim",
    }

    use { "L3MON4D3/LuaSnip", requires = "rafamadriz/friendly-snippets" }
    use "saadparwaiz1/cmp_luasnip"

    -- Utilities
    use "https://gitlab.com/yorickpeterse/nvim-dd.git"
    use "windwp/nvim-autopairs"
    use "norcalli/nvim-colorizer.lua"
    use({
      "glepnir/lspsaga.nvim",
      branch = "main",
    })

    -- Window & Animations
    use "camspiers/animate.vim"
    use { "camspiers/lens.vim", requires = "nvim-lua/plenary.nvim" }

    -- Motions
    use {
      "phaazon/hop.nvim",
      branch = "master", -- optional but strongly recommended
    }

    -- faster filetype
    use "nathom/filetype.nvim"
    use "kevinhwang91/nvim-hlslens"
    use "lewis6991/impatient.nvim"
    use "windwp/windline.nvim"
    use "svban/YankAssassin.vim"
    use "sunjon/shade.nvim"
    use "andweeb/presence.nvim"
    use "editorconfig/editorconfig-vim"

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    compile_path = fn.stdpath "config" .. "/lua/packer_compiled.lua",
  },
}
