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

# zinit light bobsoppe/zsh-ssh-agent
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

# FZF-TAB
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab

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

# Bun
if [ -d $HOME/.bun ]; then
  alias npm=pnpm
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

# Rust
[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

if [ -s "$HOME/.tmux/plugins/tmuxifier/bin" ]; then
        export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"
fi

# zoxide
eval "$(zoxide init zsh)"

# activate mise
eval "$(mise activate -s zsh)"

# direnv
eval "$(direnv hook zsh)"

export GOOS=linux
export GOARCH=amd64
export GOBIN=$GOROOT/bin

export ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

export EDITOR="nvim"
export VISUAL=$EDITOR
export PAGER="less"

# GPG
export GPG_TTY=$(tty)
export EDITOR=nvim

# Aliases
alias vimdiff="nvim -d "
alias dc="docker compose"
alias ls=eza
alias vim=nvim
alias vi=nvim
alias find=fd

# HELPFUL commands
alias yeet='git push'
alias yoink='git pull'

export DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}

autoload -Uz compinit
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
        compinit;
else
        compinit -C
fi

