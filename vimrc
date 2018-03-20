if &compatible
  set nocompatible
endif
syntax on

set t_Co=256

set background=dark
colorscheme solarized
set encoding=utf8
set title
set number
set showmatch
set matchtime=1
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
set tabstop=2 
set softtabstop=2 
set shiftwidth=2
set laststatus=2
set showtabline=2
set smartindent
set expandtab
set autoindent
set cursorline
set mouse=a

let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'

call plug#begin('~/.vim/plugged')
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/denite.nvim'
Plug 'mattn/emmet-vim'
Plug 'ervandew/supertab'
Plug 'Townk/vim-autoclose'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
"Plug 'python-mode/python-mode', {'branch': 'develop'}
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'posva/vim-vue', {'for': 'vue'}
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'terryma/vim-multiple-cursors'
" Color
Plug 'joshdick/onedark.vim'
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'

Plug 'KeitaNakamura/neodark.vim'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
call plug#end()
filetype plugin indent on

nnoremap <silent><C-b> :NERDTreeToggle<CR>
nmap <Esc><Esc> :nohlsearch<CR><Esc>

let g:deoplete#enable_at_startup = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000

let g:pymode_rope_lookup_project = 0
