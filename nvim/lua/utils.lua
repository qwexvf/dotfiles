require('dd').setup {
  -- The time to wait before displaying newly produced diagnostics.
  timeout = 300,
}

-- Cool Statusline bc why not?
require('lualine').setup { options = { theme = 'catppuccino' } }

-- Cool Tabs
require('bufferline').setup { options = { diagnostics = 'nvim_lsp' } }

-- add git signs
require('gitsigns').setup()

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
require('telescope').load_extension 'fzf'

require('nvim-autopairs').setup {}

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'javascript', 'typescript', 'lua', 'elixir' },
  highlight = {
    enable = true, -- false will disable the whole extension
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
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
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

require('trouble').setup {}

require('hop').setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }
