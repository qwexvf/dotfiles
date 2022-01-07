require('dd').setup {
  -- The time to wait before displaying newly produced diagnostics.
  timeout = 300,
}

-- Cool Statusline bc why not?
require('lualine').setup { options = { theme = 'catppuccin' } }

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

-- Native extension
require('telescope').load_extension 'fzf'

-- for {} stuff
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
require'colorizer'.setup()

-- Fold & Preview
require('pretty-fold').setup {
  fill_char = '•',
  sections = {
    left = {
      'content',
    },
    right = {
      ' ',
      'number_of_folded_lines',
      ': ',
      'percentage',
      ' ',
      function(config)
        return config.fill_char:rep(3)
      end,
    },
  },

  remove_fold_markers = true,

  -- Keep the indentation of the content of the fold string.
  keep_indentation = true,

  -- Possible values:
  -- "delete" : Delete all comment signs from the fold string.
  -- "spaces" : Replace all comment signs with equal number of spaces.
  -- false    : Do nothing with comment signs.
  comment_signs = 'spaces',

  -- List of patterns that will be removed from content foldtext section.
  stop_words = {
    '@brief%s*', -- (for cpp) Remove '@brief' and all spaces after.
  },

  add_close_pattern = true,
  matchup_patterns = {
    { '{', '}' },
    { '%(', ')' }, -- % to escape lua pattern char
    { '%[', ']' }, -- % to escape lua pattern char
    { 'if%s', 'end' },
    { 'do%s', 'end' },
    { 'for%s', 'end' },
  },
}
require('pretty-fold.preview').setup_keybinding()
