if &compatible
  set nocompatible
endif
syntax on
set background=dark
set termguicolors
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
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
set clipboard+=unnamedplus

call plug#begin('~/.vim/plugged')
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/denite.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'morhetz/gruvbox'
Plug 'mattn/emmet-vim'
Plug 'ervandew/supertab'
Plug 'Townk/vim-autoclose'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'python-mode/python-mode', {'branch': 'develop'}
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'posva/vim-vue', {'for': 'vue'}
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'terryma/vim-multiple-cursors'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
" Plug 'neomake/neomake'
Plug 'wavded/vim-stylus'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'thaerkh/vim-indentguides'
Plug 'carlitux/deoplete-ternjs', { 'do': 'yarn globall add tern' }
Plug 'joshdick/onedark.vim'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'leafgarland/typescript-vim'
call plug#end()
filetype plugin indent on

" colorscheme hybrid

nnoremap <silent><C-b> :NERDTreeToggle<CR>
nmap <Esc><Esc> :nohlsearch<CR><Esc>

let g:alchemist#elixir_erlang_src = "~/Documents/erlang"

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

let g:airline#extensions#tabline#enabled = 1
" let g:gruvbox_contrast_dark = "hard"

let g:deoplete#sources#ternjs#filetypes = ["vue"]

" autocmd! BufWritePost * Neomake
"
let g:vue_disable_pre_processors=1
