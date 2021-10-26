-- local fn = vim.fn
-- local execute = vim.api.nvim_command

-- Auto install packer.nvim if not exists
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

vim.cmd[[packadd packer.nvim]]

return require('packer').startup(function()
  use('wbthomason/packer.nvim') -- Package manager
  use('tpope/vim-fugitive') -- Git commands in nvim
  use('tpope/vim-rhubarb') -- Fugitive-companion to interact with github
  use('tpope/vim-commentary') -- "gc" to comment visual regions/lines
  use('tpope/vim-surround')

  -- UI to select things (files, grep results, open buffers...)
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    }
  })

  use('Pocco81/Catppuccino.nvim')
  use({
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  })
  use {
    'akinsho/bufferline.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'}
    -- tag = 'release' -- To use the latest release
  }

  -- Add indentation guides even on blank lines
  use('lukas-reineke/indent-blankline.nvim')

  -- Highlight
  use('sheerun/vim-polyglot')
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use('nvim-treesitter/nvim-treesitter')

  use('neovim/nvim-lspconfig') -- Collection of configurations for built-in LSP client
  use('williamboman/nvim-lsp-installer')

  use({'ms-jpq/coq_nvim', branch = 'coq'})
  use({'ms-jpq/coq.artifacts', branch = 'artifacts'}) -- Autocompletion plugin

  -- Utilities
  use('https://gitlab.com/yorickpeterse/nvim-dd.git')

  if packer_bootstrap then require('packer').sync() end
end)
