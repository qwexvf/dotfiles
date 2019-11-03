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

alias vim=nvim
alias vi=nvim

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

export GPG_TTY=$(tty)
export PATH=$(yarn global bin):$PATH

eval $(thefuck --alias)
# You can use whatever you want as an alias, like for Mondays:
eval $(thefuck --alias fuck)
