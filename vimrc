if &compatible
  set nocompatible
endif
set termguicolors
set encoding=utf8
set fileencodings=utf8
set fileformats=unix,dos,mac
set title
set number
set showmatch
set matchtime=1
set ignorecase
set nohlsearch
set hidden
set nowrap
set smartcase
set incsearch
set wrapscan
set hlsearch
set tabstop=2
set softtabstop=2
set shiftwidth=2
set showtabline=2
set smartindent
set expandtab
set autoindent
set cursorline
set laststatus=2
set noswapfile
set relativenumber
set scrolloff=8
set colorcolumn=80

set updatetime=100
set cmdheight=2
set shortmess+=c
set signcolumn=yes

set clipboard=unnamed,unnamedplus

augroup MyAutoCmd
  autocmd!
augroup END


" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME

let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
let s:toml_lazy_file = fnamemodify(expand('<sfile>'), ':h').'/dein_lazy.toml'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file, {'lazy': 0})
  call dein#load_toml(s:toml_lazy_file, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

let mapleader = ","

lua <<EOF
-- require'nvim-treesitter.configs'.setup {
-- ensure_installed = {'javascript', 'vue', 'typescript', 'elixir'},
--   highlight = {
--     enable = true,
--     additional_vim_regex_highlighting = true,
--   },
--   indent = {
--     enable = true
--   },
--   throttle = true, -- Throttles plugin updates (may improve performance)
--   rainbow = {
--     enable = true,
--     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
--     max_file_lines = nil, -- Do not enable for files with more than n lines, int
--   },
-- }

require('lualine').setup {
  options = {
    theme = 'catppuccino',
    section_separators = {'', ''},
    component_separators = {'', ''},
    icons_enabled = true,
  },
  sections = {
    lualine_a = {
      {'mode', upper = true}
    },
    lualine_b = {
      {'branch', icon = ''}
    },
    lualine_c = {
      {'filename', file_status = true }
    },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  extensions = {'fzf'}
}

require'lightspeed'.setup {
  jump_to_first_match = true,
  jump_on_partial_input_safety_timeout = 400,
  -- This can get _really_ slow if the window has a lot of content,
  -- turn it on only if your machine can always cope with it.
  highlight_unique_chars = false,
  grey_out_search_area = true,
  match_only_the_start_of_same_char_seqs = true,
  limit_ft_matches = 5,
  x_mode_prefix_key = '<c-x>',
  substitute_chars = { ['\r'] = '¬' },
  instant_repeat_fwd_key = nil,
  instant_repeat_bwd_key = nil,
  -- If no values are given, these will be set at runtime,
  -- based on `jump_to_first_match`.
  labels = nil,
  cycle_group_fwd_key = nil,
  cycle_group_bwd_key = nil,
}

-- require('treesitter-context').setup{
--   enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
--   throttle = true, -- Throttles plugin updates (may improve performance)
-- }

require("bufferline").setup{
  custom_areas = {
    right = function()
      local result = {}
      local error = vim.lsp.diagnostic.get_count(0, [[Error]])
      local warning = vim.lsp.diagnostic.get_count(0, [[Warning]])
      local info = vim.lsp.diagnostic.get_count(0, [[Information]])
      local hint = vim.lsp.diagnostic.get_count(0, [[Hint]])

      if error ~= 0 then
        table.insert(result, {text = "  " .. error, guifg = "#EC5241"})
      end

      if warning ~= 0 then
        table.insert(result, {text = "  " .. warning, guifg = "#EFB839"})
      end

      if hint ~= 0 then
        table.insert(result, {text = "  " .. hint, guifg = "#A3BA5E"})
      end

      if info ~= 0 then
        table.insert(result, {text = "  " .. info, guifg = "#7EA9A7"})
      end
      return result
    end,
  }
}

local catppuccino = require("catppuccino")

-- configure it
catppuccino.setup(
    {
		colorscheme = "neon_latte",
		transparency = true,
		term_colors = true,
		styles = {
			comments = "italic",
			functions = "italic",
			keywords = "italic",
			strings = "bold",
			variables = "bold",
		},
		integrations = {
			-- treesitter = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = "italic",
					hints = "italic",
					warnings = "italic",
					information = "italic",
				},
				underlines = {
					errors = "underline",
					hints = "underline",
					warnings = "underline",
					information = "underline",
				}
			},
			lsp_trouble = false,
			lsp_saga = false,
			gitgutter = false,
			gitsigns = true,
			telescope = true,
			nvimtree = {
				enabled = false,
				show_root = false,
			},
			which_key = true,
			indent_blankline = {
				enabled = true,
				colored_indent_levels = true,
			},
			dashboard = false,
			neogit = false,
			vim_sneak = false,
			fern = false,
			barbar = false,
			bufferline = false,
			markdown = false,
			lightspeed = true,
			ts_rainbow = true,
			hop = false,
		}
	}
)

require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  keymaps = {
    -- Default keymap options
    noremap = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
    ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
    ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
  },
  current_line_blame_formatter_opts = {
    relative_time = false
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}

require('wlsample.airline')

-- default config
require('wlfloatline').setup({
    interval = 300,
    ui = {
        active_char = '▁',
        active_color = 'blue',
        active_hl = nil,
    },
    skip_filetypes = {
        'NvimTree',
        'lir',
    },
})

require('telescope').load_extension('fzy_native')

local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.eslint,
  null_ls.builtins.diagnostics.write_good,
  null_ls.builtins.code_actions.gitsigns,
}

null_ls.config({ sources = sources })

local nvim_lsp = require "lspconfig"
local coq = require "coq"

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

require("lspconfig")["null-ls"].setup({
    on_attach = on_attach
})


-- Setup nvim-cmp.
-- local cmp = require'cmp'
local lspkind = require('lspkind')

-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       -- For `vsnip` user.
--       vim.fn["vsnip#anonymous"](args.body)
-- 
--       -- For `luasnip` user.
--       -- require('luasnip').lsp_expand(args.body)
-- 
--       -- For `ultisnips` user.
--       -- vim.fn["UltiSnips#Anon"](args.body)
--     end,
--   },
--   mapping = {
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.close(),
--     ['<CR>'] = cmp.mapping.confirm({ select = true }),
--     ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })
--   },
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' },
--     { name = 'buffer' },
--     { name = 'treesitter' },
--   },
--   formatting = {
--     format = lspkind.cmp_format({with_text = false, maxwidth = 50})
--   }
-- })

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

nvim_lsp.vuels.setup {
  -- capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "vls" },
  filetypes = { "vue" },
  root_dir = nvim_lsp.util.root_pattern("package.json", "vue.config.js"),
  init_options = {
    config = {
      css = {},
      emmet = {},
      html = {
        suggest = {}
      },
      javascript = {
        format = {}
      },
      stylusSupremacy = {},
      typescript = {
        format = {}
      },
      vetur = {
        completion = {
          autoImport = true,
          tagCasing = "kebab",
          useScaffoldSnippets = false
        },
        format = {
          defaultFormatter = {
            js = "prettier",
            ts = "prettier"
          },
          defaultFormatterOptions = {},
          scriptInitialIndent = false,
          styleInitialIndent = false
        },
        useWorkspaceDependencies = false,
        validation = {
          script = true,
          style = true,
          template = true
        }
      }
    }
  },
}

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    print(server.name)
    local opts = {}
    -- opts.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    opts.capabilities = capabilities
    opts.on_attach = on_attach
    opts.flags = {
      debounce_text_changes = 150,
    }
    if server.name == "elixirls" then
        opts.settings = {
          elixirLS = {
            -- I choose to disable dialyzer for personal reasons, but
            -- I would suggest you also disable it unless you are well
            -- aquainted with dialzyer and know how to use it.
            dialyzerEnabled = true,
            -- I also choose to turn off the auto dep fetching feature.
            -- It often get's into a weird state that requires deleting
            -- the .elixir_ls directory and restarting your editor.
            fetchDeps = true
          }
        }
    end

    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    -- server:setup(opts)
    server:setup(coq.lsp_ensure_capabilities(opts))
    vim.cmd [[ do User LspAttachBuffers ]]
end)

-- local saga = require 'lspsaga'
-- saga.init_lsp_saga()

EOF

set completeopt=menu,menuone,noselect

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

au MyAutoCmd VimEnter * nested colorscheme neon_latte

nmap <Esc><Esc> :nohlsearch<CR><Esc>
inoremap <silent> jj <ESC>

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" for elixir
imap >> \|><Space>

" Go settings
augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end
autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal tabstop=4
autocmd FileType go setlocal shiftwidth=4

" Y? the true copy keymap
nnoremap Y y$
