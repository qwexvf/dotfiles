ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh" 

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000

#####################
# SETOPT            #
#####################
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_all_dups   # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt always_to_end          # cursor moved to the end in full completion
setopt hash_list_all          # hash everything before completion
setopt completealiases        # complete alisases
setopt always_to_end          # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word       # allow completion from within a word/phrase
setopt nocorrect                # spelling correction for commands
setopt list_ambiguous         # complete as much of a completion until it gets ambiguous.
setopt nolisttypes
setopt listpacked
setopt automenu
unsetopt BEEP

setopt AUTO_CD
setopt AUTO_PARAM_KEYS

zinit light bobsoppe/zsh-ssh-agent
# AUTOSUGGESTIONS, TRIGGER PRECMD HOOK UPON LOAD
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

zinit load robobenklein/zdharma-history-search-multi-word
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

# History
zinit ice wait"0b" lucid atload'bindkey "$terminfo[kcuu1]" history-substring-search-up; bindkey "$terminfo[kcud1]" history-substring-search-down'
zinit light zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# FZF
zinit ice from"gh-r" as"command"
zinit light junegunn/fzf

# FZF BYNARY AND TMUX HELPER SCRIPT
#zinit ice lucid wait'0c' as"command" id-as"junegunn/fzf-tmux" pick"bin/fzf-tmux"
#zinit light junegunn/fzf

# BIND MULTIPLE WIDGETS USING FZF
zinit ice lucid wait'0c' multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null"
zinit light junegunn/fzf

# FZF-TAB
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab

# BAT
zinit ice from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat" atload"alias cat=bat"
zinit light sharkdp/bat

zinit ice as"completion"
zinit snippet https://github.com/jdx/rtx/blob/main/completions/_rtx

# BAT-EXTRAS
zinit ice wait"1" as"program" pick"src/batgrep.sh" lucid
zinit ice wait"1" as"program" pick"src/batdiff.sh" lucid
zinit light eth-p/bat-extras

# RIPGREP
zinit ice from"gh-r" as"program" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
zinit light BurntSushi/ripgrep

# FD
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

zinit ice wait'0'
zinit light zsh-users/zsh-completions

# because starship is beign slow
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1

# Fzf
[ -f ~/.fzf.zsh ] && . ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# Add amplify to path
[ -f ~/.amplify ] && export PATH="$HOME/.amplify/bin:$PATH"

# Bun
if [ -s "$HOME/.bun/_bun" ]; then
  # alias npm=pnpm
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
  source "$HOME/.bun/_bun"
fi

# Rust
[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

if [ -s "$HOME/.tmux/plugins/tmuxifier/bin" ]; then
  export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"
fi

# zoxide
eval "$(zoxide init zsh)"

if [[ "$OSTYPE" == "darwin"* ]]; then
  if [ -d "/opt/homebrew" ]; then
    # for macos only
    export GOOS=darwin
    export GOARCH=arm64

    # :thinking:
    export PATH="/usr/local/opt/libpq/bin:$PATH"

    if [ -d "/opt/homebrew" ]; then
      # for arm only
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    if type brew &> /dev/null; then
      # use gnubin
      export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    fi
  else
    export GOOS=linux
    export GOARCH=amd64
  fi
fi

export ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

# AWS
export AWS_SDK_LOAD_CONFIG=1

export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'

# GPG
export GPG_TTY=$(tty)
export EDITOR=nvim

# Aliases
alias vimdiff="nvim -d "
alias dc="docker compose"
alias ls=eza
alias vim=nvim
alias vi=nvim

alias rg=batgrep.sh
alias bd=batdiff.sh
alias man=batman.sh

# HELPFUL commands
alias yeet='git push'
alias yoink='git pull'
alias 'docker-compose'='docker compose'

export GOBIN=$GOROOT/bin
export PATH=/Users/qwexvf/.cache/rebar3/bin:$PATH

export GOBIN=$GOROOT/bin

autoload -Uz compinit
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit;
else
  compinit -C
fi
