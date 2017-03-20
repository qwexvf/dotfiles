if &compatible
  set nocompatible
endif
syntax on
colorscheme hybrid
set background=dark
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

call plug#begin('~/.vim/plugged')
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/denite.nvim'
Plug 'mattn/emmet-vim'
Plug 'ervandew/supertab'
Plug 'Townk/vim-autoclose'
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'python-mode/python-mode', {'for': 'python'}
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'posva/vim-vue', {'for': 'vue'}
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'joshdick/onedark.vim'
Plug 'flazz/vim-colorschemes'
Plug 'KeitaNakamura/neodark.vim'
call plug#end()
filetype plugin indent on

nnoremap <silent><C-b> :NERDTreeToggle<CR>
nmap <Esc><Esc> :nohlsearch<CR><Esc>

let g:deoplete#enable_at_startup = 1

autocmd BufRead,BufNewFile *.py setfiletype python
autocmd BufRead,BufNewFile *.js setfiletype javascript
autocmd BufRead,BufNewFile *.vue setfiletype vue
