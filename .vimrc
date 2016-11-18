if &compatible
  set nocompatible               " Be iMproved
endif

syntax enable
set background=dark
colorscheme hybrid

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

let mapleader = "\<Space>"

" Required:
call plug#begin('~/.vim/plugged')

" Required:
Plug 'Shougo/dein.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'scrooloose/nerdtree'
Plug 'mattn/emmet-vim', {'for': 'html'}
Plug 'itchyny/lightline.vim'
Plug 'ervandew/supertab'
Plug 'Townk/vim-autoclose'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'nathanaelkane/vim-indent-guides'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'klen/python-mode', {'for': 'python'}
Plug 'flazz/vim-colorschemes'
" Required:
call plug#end()

" Required:
filetype plugin indent on

" Use deoplete
let g:deoplete#enable_at_startup = 1
setlocal omnifunc=jedi#completions

autocmd FileType python setlocal completeopt-=preview

let g:syntastic_python_checkers = ['pyflakes']

hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey


let g:indent_guides_auto_colors = 1
let g:indent_guides_enable_on_vim_startup = 1

let g:indent_guides_guide_size = 1


let python_highlight_all = 1


" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

let g:pymode_rope = 0
