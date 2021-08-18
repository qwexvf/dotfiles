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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

alias vim=nvim
alias vi=nvim
alias vf='nvim $(fzf)'

. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

# Golang
alias go-reshim='asdf reshim golang && export GOROOT="$(asdf where golang)/go/"'
export GOROOT="$(asdf where golang)/go/"
export GOOS=$OS
export GOARCH=amd64
export GOBIN=$GOROOT/bin
export GOPATH=$HOME/.go
export PATH=$PATH:$GOBIN

# Yarn
export PATH=$(yarn global bin):$PATH

# GPG
export GPG_TTY=$(tty)
export EDITOR=nvim

alias vimdiff='nvim -d '
alias dc="docker compose"
alias ls=exa
export PATH="/usr/local/opt/libpq/bin:$PATH"


autoload -Uz compinit && compinit
