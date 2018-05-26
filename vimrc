if &compatible
  set nocompatible               " Be iMproved
endif
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
set clipboard+=unnamedplus

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" Required:
set runtimepath+=/home/qwexvf/.cache/dein/repos/github.com/Shougo/dein.vim
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
" if dein#check_install()
"  call dein#install()
" endif

nmap <Esc><Esc> :nohlsearch<CR><Esc>

hi Normal guibg=NONE ctermbg=NONE
