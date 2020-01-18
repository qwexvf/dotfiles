#!/usr/bin/env bash

# neovim
if [ ! -d ${HOME}/.config/nvim ];then
  mkdir -p ${HOME}/.config/nvim
fi

# link every configurations files
ln -snfv ${HOME}/.dotfiles/vimrc ${HOME}/.vimrc
ln -snfv ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
ln -snfv ${HOME}/.dotfiles/tmux.conf ${HOME}/.tmux.conf


ln -snfv ${HOME}/.dotfiles/nvim/dein.toml ${HOME}/.config/nvim/
ln -snfv ${HOME}/.dotfiles/nvim/dein_lazy.toml ${HOME}/.config/nvim/
