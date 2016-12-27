
if &compatible
  set nocompatible
endif

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif

set t_Co=256 
set encoding=utf8
set background=dark
colorscheme onedark

set nobackup
set noswapfile
set autoread
set hidden
set showcmd

set title
set number
set smartindent
set showmatch
set matchtime=1

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

set tabstop=2 
set softtabstop=2 
set shiftwidth=2
set laststatus=2
set showtabline=2
set expandtab
set autoindent

set laststatus=2
call plug#begin('~/.vim/plugged')
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/denite.nvim'
Plug 'mattn/emmet-vim'
Plug 'ervandew/supertab'
Plug 'Townk/vim-autoclose'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'klen/python-mode', {'for': 'python'}
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'posva/vim-vue', {'for': 'vue'}
Plug 'othree/yajs.vim', {'for': 'javascript'}
Plug 'NLKNguyen/papercolor-theme'
Plug 'joshdick/onedark.vim'
Plug 'nathanaelkane/vim-indent-guides'

call plug#end()
filetype plugin indent on

nnoremap <silent><C-b> :NERDTreeToggle<CR>

let g:deoplete#enable_at_startup = 1
let g:indent_guides_auto_colors = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

let g:lightline = {'colorscheme': 'solarized'}

hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

autocmd BufRead,BufNewFile *.py setfiletype python
autocmd BufRead,BufNewFile *.vue setfiletype vue
