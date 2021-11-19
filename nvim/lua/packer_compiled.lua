-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
local package_path_str = "/home/qwexvf/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/qwexvf/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/qwexvf/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/qwexvf/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/qwexvf/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
=======
local package_path_str = "/Users/qwexvf/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/qwexvf/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/qwexvf/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/qwexvf/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/qwexvf/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Catppuccino.nvim"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/Catppuccino.nvim",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/Catppuccino.nvim",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/Pocco81/Catppuccino.nvim"
  },
  ["animate.vim"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/animate.vim",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/animate.vim",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/camspiers/animate.vim"
  },
  ["bufferline.nvim"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/cmp-buffer",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/cmp-buffer",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-git"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/cmp-git",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/cmp-git",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/petertriho/cmp-git"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/cmp-path",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/cmp-path",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-treesitter"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/cmp-treesitter",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/cmp-treesitter",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/ray-x/cmp-treesitter"
  },
  ["cmp-vsnip"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/cmp-vsnip",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["filetype.nvim"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
  },
  ["gitsigns.nvim"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/go.nvim",
    url = "https://github.com/ray-x/go.nvim"
  },
  ["hop.nvim"] = {
    loaded = true,
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/hop.nvim",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hop.nvim"] = {
    loaded = true,
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/hop.nvim",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lens.vim"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/lens.vim",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/lens.vim",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/camspiers/lens.vim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/lualine.nvim",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/lualine.nvim",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/nvim-cmp",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/nvim-cmp",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dd.git"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/nvim-dd.git",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/nvim-dd.git",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://gitlab.com/yorickpeterse/nvim-dd"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/packer.nvim",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/packer.nvim",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/plenary.nvim",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/plenary.nvim",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/telescope.nvim",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/telescope.nvim",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/trouble.nvim",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/trouble.nvim",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-commentary"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/vim-commentary",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/vim-commentary",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-fugitive"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/vim-fugitive",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/vim-fugitive",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-rhubarb"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-surround"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/vim-surround",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/vim-surround",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-vsnip"] = {
    loaded = true,
<<<<<<< HEAD:nvim/plugin/packer_compiled.lua
    path = "/home/qwexvf/.local/share/nvim/site/pack/packer/start/vim-vsnip",
=======
    path = "/Users/qwexvf/.local/share/nvim/site/pack/packer/start/vim-vsnip",
>>>>>>> 537f3ca (minor):nvim/lua/packer_compiled.lua
    url = "https://github.com/hrsh7th/vim-vsnip"
  }
}

time([[Defining packer_plugins]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
