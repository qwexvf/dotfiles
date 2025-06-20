# ------------------------------------------------------------------------------
# ZINIT - Plugin Manager
# ------------------------------------------------------------------------------
# Download Zinit if it doesn't exist
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# ------------------------------------------------------------------------------
# HISTORY
# ------------------------------------------------------------------------------
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=100000
SAVEHIST=1000000
setopt APPEND_HISTORY           # Append to history
setopt EXTENDED_HISTORY         # Add timestamps
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicates first
setopt HIST_IGNORE_ALL_DUPS     # Don't record duplicate commands
setopt HIST_IGNORE_SPACE        # Don't record commands starting with a space
setopt HIST_VERIFY              # Show command before running from history
setopt INC_APPEND_HISTORY       # Add commands to history immediately
setopt SHARE_HISTORY            # Share history between all sessions

# ------------------------------------------------------------------------------
# SHELL OPTIONS
# ------------------------------------------------------------------------------
setopt AUTO_CD              # cd by typing directory name
setopt AUTO_MENU            # Show completion menu on successive tabs
setopt AUTO_PARAM_KEYS      # Automatically handle (), [], {}
setopt COMPLETE_ALIASES     # Complete aliases
setopt HASH_LIST_ALL        # Check for commands in all path entries
setopt LIST_PACKED          # Compact completion lists
setopt NO_CORRECT           # Disable auto-correction

# ------------------------------------------------------------------------------
# COMPLETION SYSTEM
# ------------------------------------------------------------------------------
# Initialize the completion system
autoload -Uz compinit
# Cache completions to speed up shell startup
if [[ -n "${HOME}/.zcompdump"(#qN.mh+24) ]]; then
  compinit
else
  # Generate a new cache
  compinit -C
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ------------------------------------------------------------------------------
# ZINIT PLUGINS
# ------------------------------------------------------------------------------
# Note: zsh-syntax-highlighting should be loaded last.

# Git integration
zinit snippet OMZ::plugins/git/git.plugin.zsh

# SSH Agent management
zinit light bobsoppe/zsh-ssh-agent

# Additional completions (load before other plugins that need them)
zinit ice wait'!0' # Defer loading until after prompt is ready
zinit light zsh-users/zsh-completions


# Vi mode in the shell
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# Pure prompt (with async optimization)
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

# History substring search
zinit load zsh-users/zsh-history-substring-search
# Bind arrow keys for history search (portable method)
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down

# Autosuggestions (must be loaded before syntax-highlighting)
zinit ice wait'!0'
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# ------------------------------------------------------------------------------
export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less"

# GPG
export GPG_TTY=$(tty)

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --no-ignore'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# Docker
export DOCKER_CONFIG="${DOCKER_CONFIG:-$HOME/.docker}"

# Android SDK
export ANDROID_HOME="${HOME}/Android/Sdk"

# Rust
[ -s "${HOME}/.cargo/env" ] && source "${HOME}/.cargo/env"

# Tmuxifier
TMUXIFIER_BIN_PATH="${HOME}/.tmux/plugins/tmuxifier/bin"
[ -d "$TMUXIFIER_BIN_PATH" ] && export PATH="$TMUXIFIER_BIN_PATH:$PATH"

# ------------------------------------------------------------------------------
# ALIASES
# ------------------------------------------------------------------------------
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'
alias ls='eza'
alias cat='bat'
alias find='fd'
alias dc='docker compose'
alias yeet='git push'
alias yoink='git pull'

# ------------------------------------------------------------------------------
# TOOL INITIALIZATIONS
# ------------------------------------------------------------------------------
# mise (replaces direnv, nvm, etc.)
eval "$(/home/qwexvf/.local/bin/mise activate zsh)"

# zoxide (smarter cd)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# bun completions
[ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"
