#!/bin/bash

# install zsh

# install tmux

# install neovim

# install zplug
if [ ! -d ${HOME}/.zplug ];then
  curl -sL --proto-redir -all,https https://zplug.sh/installer | zsh
fi

# dotfiles

if [ ! -d ${HOME}/.dotfiles ];then
  git clone https://github.com/qwexvf/dotfiles ${HOME}/.dotfiles
fi

# create a folder for vim plugins
if [ ! -d ${HOME}/.vim ];then
  mkdir -p ${HOME}/.vim
fi

# and for neovim
if [ ! -d ${HOME}/.config/nvim ];then
  mkdir -p ${HOME}/.config/nvim
fi

# link every configurations files
ln -snfv ${HOME}/.dotfiles/zshrc ${HOME}/.zshrc
ln -snfv ${HOME}/.dotfiles/vimrc ${HOME}/.vimrc
ln -snfv ${HOME}/.dotfiles/tmux.conf ${HOME}/.tmux.conf
ln -snfv ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim

# install pyenv & pyenv-virtualenv
if [ ! -d ${HOME}/.pyenv ];then
  apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  source ~/.zshrc
  git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
  source ~/.zshrc
fi
