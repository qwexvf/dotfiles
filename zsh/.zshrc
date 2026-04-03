ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

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
export FZF_CTRL_R_OPTS='--scheme=history --bind=ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'

# FZF key bindings (Ctrl+R for history, Ctrl+T for files, Alt+C for cd)
source <(fzf --zsh 2>/dev/null) || eval "$(fzf --zsh)"

# Docker
export DOCKER_CONFIG="${DOCKER_CONFIG:-$HOME/.docker}"

# Android SDK
export ANDROID_HOME="${HOME}/Android/Sdk"

# Rust
[ -s "${HOME}/.cargo/env" ] && source "${HOME}/.cargo/env"

# ------------------------------------------------------------------------------
# ALIASES
# ------------------------------------------------------------------------------
alias vi='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'
alias dc='docker compose'
alias yeet='git push'
alias yoink='git pull'
alias ze='zellij'

# ------------------------------------------------------------------------------
# TOOL INITIALIZATIONS
# ------------------------------------------------------------------------------
# mise (replaces direnv, nvm, etc.)
eval "$(mise activate zsh)"

# zoxide (smarter cd)
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# bun completions
[ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/share/sbt/bin:$PATH"

# ------------------------------------------------------------------------------
# ZELLIJ TAB NAME (dir: command)
# ------------------------------------------------------------------------------
if [[ -n "$ZELLIJ" ]]; then
  _zellij_short_pwd() {
    local dir="${PWD/#$HOME/~}"
    local parts=("${(@s:/:)dir}")
    local n=${#parts}
    local result=""
    for (( i=1; i<=n; i++ )); do
      if (( i > 1 )); then result+="/"; fi
      local p="${parts[$i]}"
      if [[ "$p" == "~" ]] || (( ${#p} <= 7 )); then
        result+="$p"
      else
        result+="${p:0:3}..${p: -3}"
      fi
    done
    echo "$result"
  }

  _zellij_precmd() {
    zellij action rename-tab "$(_zellij_short_pwd)" 2>/dev/null
  }

  _zellij_preexec() {
    local cmd="${1%% *}"
    zellij action rename-tab "$(_zellij_short_pwd): $cmd" 2>/dev/null
  }

  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _zellij_precmd
  add-zsh-hook preexec _zellij_preexec
fi
