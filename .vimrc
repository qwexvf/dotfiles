syntax on
colorscheme hybrid
set background=dark
set number
set laststatus=2
let g:python3_host_prog = '/usr/local/var/pyenv/versions/venv351/bin/python'

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=/Users/xyz/.vim/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('/Users/xyz/.vim'))
" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')
" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/deoplete.nvim')
call dein#add('zchee/deoplete-jedi')
call dein#add('flazz/vim-colorschemes')
call dein#add('itchyny/lightline.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('ervandew/supertab')

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
let g:deoplete#enable_at_startup = 1
let g:SuperTabDefaultCompletionType = "<c-n>"
