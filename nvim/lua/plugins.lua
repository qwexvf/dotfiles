local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup {
  function(use)
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'

    -- UI to select things (files, grep results, open buffers...)
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      },
    }

    use 'EdenEast/nightfox.nvim'
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }
    use {
      'akinsho/bufferline.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
    }

    use 'onsails/lspkind-nvim'

    -- Add indentation guides even on blank lines
    use 'lukas-reineke/indent-blankline.nvim'

    -- Highlight, edit, and navigate code using a fast incremental parsing library
    use 'nvim-treesitter/nvim-treesitter'

    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use {
      'folke/trouble.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    -- auto complete
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use {
      'petertriho/cmp-git',
      requires = 'nvim-lua/plenary.nvim',
    }
    use 'ray-x/cmp-treesitter'

    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- Utilities
    use 'https://gitlab.com/yorickpeterse/nvim-dd.git'
    use 'windwp/nvim-autopairs'
    use 'norcalli/nvim-colorizer.lua'

    -- Window & Animations
    use 'camspiers/animate.vim'
    use { 'camspiers/lens.vim', requires = 'nvim-lua/plenary.nvim' }

    -- Motions
    use {
      'phaazon/hop.nvim',
      branch = 'master', -- optional but strongly recommended
    }

    -- VOODOO
    use 'lewis6991/impatient.nvim'
    use 'nathom/filetype.nvim'

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath 'config' .. '/lua/packer_compiled.lua',
  },
}
