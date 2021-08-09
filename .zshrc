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

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
export PKG_CONFIG_PATH="/opt/homebrew/zlib/lib/pkgconfig"

alias vim='arch -arm64 nvim'
alias vi='arch -arm64 nvim'
alias vf='nvim $(fzf)'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# 数字で表現
alias ..2='cd ../..'
alias ..3='cd ../../..'

alias vimdiff='nvim -d '
alias dc="docker compose"
# alias ls=exa

. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

# Golang
export GOROOT=/usr/local/src/go
export GOOS=$OS
export GOARCH=amd64
export GOBIN=$GOROOT/bin
export PATH=$PATH:$GOBIN
export GOPATH=$HOME/go

# Yarn
export PATH=$(npm config get prefix)/bin:$PATH
export PATH=$(yarn global bin):$PATH

# GPG
export GPG_TTY=$(tty)
export EDITOR='arch -arm64 nvim'

autoload -Uz compinit && compinit
