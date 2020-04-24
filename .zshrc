#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

alias vim=nvim
alias vi=nvim

eval $(thefuck --alias)
eval $(thefuck --alias fuck)

. $HOME/.asdf/asdf.sh
. $HOME/.dotfiles/asdf.sh

alias makeconfig="sudo nvim /etc/portage/make.conf"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export GPG_TTY=$(tty)
export XDG_DATA_HOME=$HOME/.local/share
