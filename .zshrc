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
export PATH=$PATH:$GOBIN
export GOPATH=$HOME/.go

# Yarn
export PATH=$(yarn global bin):$PATH
export PATH=$(npm config get prefix)/bin:$PATH

# GPG
export GPG_TTY=$(tty)
export EDITOR=nvim

alias vimdiff='nvim -d '
alias dc="docker compose"
alias ls=exa
export PATH="/usr/local/opt/libpq/bin:$PATH"

# Rust
source $HOME/.cargo/env

alias dc="docker compose"

#export QT_QPA_PLATFORM=wayland
#export MOZ_ENABLE_WAYLAND=1
#export MOZ_WEBRENDER=1
#export XDG_SESSION_TYPE=wayland
#export XDG_CURRENT_DESKTOP=sway
alias k='kubectl --kubeconfig ~/Downloads/admin.conf --namespace=development-discourse'

autoload -Uz compinit && compinit

