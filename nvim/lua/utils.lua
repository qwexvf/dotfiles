-- The time to wait before displaying newly produced diagnostics.
require('dd').setup {
  timeout = 100,
}

-- Cool Statusline bc why not?
require('lualine').setup {
  options = { theme = 'catppuccin' },
  sections = {
    lualine_c = { require('auto-session-library').current_session_name },
  },
}

-- Cool Tabs
require('bufferline').setup { options = { diagnostics = 'nvim_lsp' } }

-- Add git signs
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  keymaps = {
    -- Default keymap options
    noremap = true,

    ['n ]c'] = { expr = true, '&diff ? \']c\' : \'<cmd>Gitsigns next_hunk<CR>\'' },
    ['n [c'] = { expr = true, '&diff ? \'[c\' : \'<cmd>Gitsigns prev_hunk<CR>\'' },

    ['n <leader>hs'] = '<cmd>Gitsigns stage_hunk<CR>',
    ['v <leader>hs'] = ':Gitsigns stage_hunk<CR>',
    ['n <leader>hu'] = '<cmd>Gitsigns undo_stage_hunk<CR>',
    ['n <leader>hr'] = '<cmd>Gitsigns reset_hunk<CR>',
    ['v <leader>hr'] = ':Gitsigns reset_hunk<CR>',
    ['n <leader>hR'] = '<cmd>Gitsigns reset_buffer<CR>',
    ['n <leader>hp'] = '<cmd>Gitsigns preview_hunk<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
    ['n <leader>hS'] = '<cmd>Gitsigns stage_buffer<CR>',
    ['n <leader>hU'] = '<cmd>Gitsigns reset_buffer_index<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>Gitsigns select_hunk<CR>',
    ['x ih'] = ':<C-U>Gitsigns select_hunk<CR>',
  },
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 300,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 5,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
}

require('nvim-autopairs').setup {}

-- Cool trobleshooting
require('trouble').setup {}

-- Motion
require('hop').setup { keys = 'etovxqpdygfblzhckisuran', term_seq_bias = 0.5 }

-- Colorizer
require('colorizer').setup {}

-- require('lsp_lines').register_lsp_virtual_lines()

require('indent_blankline').setup {
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
}

-- session manager
require('auto-session').setup {
  log_level = 'info',
  auto_session_suppress_dirs = { '~/' },
}

require 'wlsample.bubble'

-- Dim brightness when splitting window
-- require'shade'.setup({
--   overlay_opacity = 50,
--   opacity_step = 1,
--   keys = {
--     brightness_up    = '<C-Up>',
--     brightness_down  = '<C-Down>',
--     toggle           = '<Leader>s',
--   }
-- })

-- Don't run these plugisn on macos
if not vim.g.os == 'Darwin' then
  -- Discord
  require('presence'):setup {
    -- General options
    auto_update = true,
    neovim_image_text = 'The One True Text Editor', -- Text displayed when hovered over the Neovim image
    main_image = 'neovim', -- Main image display (either "neovim" or "file")
    -- client_id = '150256181439496192', -- Use your own Discord application client id (not recommended)
    log_level = 'info', -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout = 10,
    enable_line_number = true,
    blacklist = {},
    buttons = true,
    file_assets = {},

    -- Rich Presence text options
    editing_text = 'Editing %s',
    file_explorer_text = 'Browsing %s',
    git_commit_text = 'Committing changes',
    plugin_manager_text = 'Managing plugins',
    reading_text = 'Reading %s',
    workspace_text = 'Working on %s',
    line_number_text = 'Line %s out of %s',
  }
end

local telescope = require 'telescope'

-- Best fzf finder
telescope.setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    },
    frecency = {
      show_scores = true,
      show_unindexed = true,
      ignore_patterns = { '*.git/*', '*/tmp/*' },
      disable_devicons = false,
    },
  },
}

-- Native extension
telescope.load_extension 'fzf'
telescope.load_extension 'frecency'
telescope.load_extension 'gh'

require('fidget').setup {}
require('startup').setup { theme = 'dashboard' }
