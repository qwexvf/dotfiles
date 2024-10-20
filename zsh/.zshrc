# Initialize Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)" && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# History Settings
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000
setopt extended_history hist_expire_dups_first hist_ignore_all_dups hist_ignore_space \
        hist_verify inc_append_history share_history always_to_end hash_list_all \
        completealiases nocorrect list_ambiguous nolisttypes listpacked automenu \
        AUTO_CD AUTO_PARAM_KEYS

# Zinit Plugins
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit light bobsoppe/zsh-ssh-agent
zinit load robobenklein/zdharma-history-search-multi-word
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

zinit load zsh-users/zsh-history-substring-search
zinit ice wait atload'_history_substring_search_config'

zinit ice wait'!0'
zinit light zsh-users/zsh-completions

zinit light Aloxaf/fzf-tab
zinit ice depth=1; zinit light jeffreytse/zsh-vi-mode
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Completion System
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' menu select=1

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Fzf Configuration
export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# Rust Environment
[ -s "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Tmuxifier Plugin
[ -s "$HOME/.tmux/plugins/tmuxifier/bin" ] && export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"

# Editor Settings
export EDITOR="nvim"
export VISUAL=$EDITOR
export PAGER="less"

# GPG Configuration
export GPG_TTY=$(tty)

# Aliases
alias vimdiff="nvim -d" \
        dc="docker compose" \
        ls=eza \
        vim=nvim \
        vi=nvim \
        find=fd \
        yeet='git push' \
        yoink='git pull'

# Docker and Android SDK Paths
export DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
export ANDROID_HOME=$HOME/Android/Sdk
export PATH="$HOME/.bun/bin:$PATH"

# Zoxide Initialization
eval "$(zoxide init zsh)"

# Direnv Hook
eval "$(direnv hook zsh)"

# Mise Activation
eval "$(mise activate zsh)"

# Completion Initialization
autoload -Uz compinit _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit;
else
  compinit -C
fi
