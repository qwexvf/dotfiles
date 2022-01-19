-- The time to wait before displaying newly produced diagnostics.
require('dd').setup {
  timeout = 100,
}

-- Cool Statusline bc why not?
require('lualine').setup { options = { theme = 'catppuccin' } }

-- Cool Tabs
require('bufferline').setup { options = { diagnostics = 'nvim_lsp' } }

-- Add git signs
require('gitsigns').setup {}

-- Best fzf finder
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
  },
}

-- Native extension
require('telescope').load_extension 'fzf'

require('nvim-autopairs').setup {}

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'javascript', 'typescript', 'lua', 'elixir', 'vue', 'svelte' },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
  additional_vim_regex_highlighting = true,
}

-- Cool trobleshooting
require('trouble').setup {}

-- Motion
require('hop').setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }

-- Colorizer
require('colorizer').setup {}

-- require('lsp_lines').register_lsp_virtual_lines()
