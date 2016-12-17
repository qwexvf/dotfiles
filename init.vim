if &compatible
    set nocompatible               " Be iMproved
endif

set encoding=utf8

if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
    set termguicolors
endif

set title
set ambiwidth=double
set tabstop=4
set expandtab
set shiftwidth=4
set smartindent

set number
set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set showtabline=2
set noshowmode
set clipboard+=unnamed
let mapleader = "\<Space>"

call plug#begin('~/.vim/plugged')

Plug 'Shougo/dein.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'mattn/emmet-vim'
Plug 'ervandew/supertab'
Plug 'Townk/vim-autoclose'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'nathanaelkane/vim-indent-guides'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'scrooloose/syntastic'
Plug 'klen/python-mode', {'for': 'python'}
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'terryma/vim-multiple-cursors'
Plug 'Shougo/denite.nvim'
"Plug 'pangloss/vim-javascript'
"Plug 'mxw/vim-jsx'
Plug 'rakr/vim-one'
"Plug 'withgod/vim-sourcepawn'
Plug 'posva/vim-vue'
"Plug 'isRuslan/vim-es6'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

call plug#end()

filetype plugin indent on

let g:deoplete#enable_at_startup = 1

let g:indent_guides_auto_colors = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

autocmd BufRead,BufNewFile *.py setfiletype python
autocmd BufRead,BufNewFile *.vue setfiletype vue

set background=dark
colorscheme one

