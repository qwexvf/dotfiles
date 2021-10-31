if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

alias vim='nvim'
alias vi='nvim'
alias vf='vi $(fzf)'

# cd ... 
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# 数字で表現
alias ..2='cd ../..'
alias ..3='cd ../../..'

# shortcuts
alias vimdiff='nvim -d '
alias dc="docker compose"

# Golang
alias go-reshim='asdf reshim golang && export GOROOT="$(asdf where golang)/go/"'
export GOROOT="$(asdf where golang)/go/"
export GOOS=$OS
export GOARCH=amd64
export GOBIN=$GOROOT/bin
export PATH=$PATH:$GOBIN
export GOPATH=$HOME/.go

# Paths
export PATH=$(npm config get prefix)/bin:$PATH
export PATH=$(yarn global bin):$PATH
export PATH=$(npm config get prefix)/bin:$PATH
export PATH="/usr/local/opt/libpq/bin:$PATH"

# GPG
export GPG_TTY=$(tty)

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="-I/opt/homebrew/opt/zlib/include"
export PKG_CONFIG_PATH="/opt/homebrew/zlib/lib/pkgconfig"
# Rust
source $HOME/.cargo/env

export EDITOR='nvim'

autoload -Uz compinit && compinit
