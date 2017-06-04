#!/bin/bash

# install zsh
if ! type zsh > /dev/null; then
  echo "Installing zsh"
  sudo apt-get install zsh
  chsh -s $(which zsh)
fi

# install tmux

echo "Installing Tmux..."
sh build_tmux.sh

# install neovim
echo "Installing Neovim..."
sh build_neovim.sh

# create a folder for vim plugins
if [ ! -d ${HOME}/.vim ];then
  mkdir -p ${HOME}/.vim
fi

# and for neovim
if [ ! -d ${HOME}/.config/nvim ];then
  mkdir -p ${HOME}/.config/nvim
fi

# install pyenv & pyenv-virtualenv
if [ ! -d ${HOME}/.pyenv ];then
  apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
  source ~/.zshrc
fi

# link every configurations files
ln -snfv ${HOME}/.dotfiles/vimrc ${HOME}/.vimrc
ln -snfv ${HOME}/.dotfiles/tmux.conf ${HOME}/.tmux.conf
ln -snfv ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim

if [ ! $SHELL == $(which zsh) ];then
  echo "Switching to zsh"
  exec zsh
fi
