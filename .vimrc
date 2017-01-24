if &compatible
  set nocompatible
endif

set encoding=utf8

set background=dark
colorscheme hybrid

set title
set number
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
set smartindent
set expandtab
set autoindent
set cursorline

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
Plug 'othree/yajs.vim', {'for': 'javascript'}
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()
filetype plugin indent on

nnoremap <silent><C-b> :NERDTreeToggle<CR>

let g:deoplete#enable_at_startup = 1

autocmd BufRead,BufNewFile *.py setfiletype python
autocmd BufRead,BufNewFile *.vue setfiletype vue
autocmd BufRead,BufNewFile *.js setfiletype javascript
