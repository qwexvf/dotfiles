### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
  command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
  command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
    print -P "%F{33} %F{34}Installation successful.%f%b" || \
    print -P "%F{160} The clone has failed.%f%b"
fi

. "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

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
setopt vi

## パスを直接入力してもcdする
setopt AUTO_CD

## 環境変数を補完
setopt AUTO_PARAM_KEYS

zinit light bobsoppe/zsh-ssh-agent
# AUTOSUGGESTIONS, TRIGGER PRECMD HOOK UPON LOAD
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

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
zinit ice lucid wait'0c' as"command" id-as"junegunn/fzf-tmux" pick"bin/fzf-tmux"
zinit light junegunn/fzf

# BIND MULTIPLE WIDGETS USING FZF
zinit ice lucid wait'0c' multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null"
zinit light junegunn/fzf

# FZF-TAB
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab

# NVM
export NVM_AUTO_USE=true
export NVM_LAZY_LOAD=true
zinit ice wait"1" lucid
zinit light lukechilds/zsh-nvm

# BAT
zinit ice from"gh-r" as"program" mv"bat* -> bat" pick"bat/bat" atload"alias cat=bat"
zinit light sharkdp/bat

# BAT-EXTRAS
zinit ice wait"1" as"program" pick"src/batgrep.sh" lucid
zinit ice wait"1" as"program" pick"src/batdiff.sh" lucid
zinit light eth-p/bat-extras

# RIPGREP
zinit ice from"gh-r" as"program" mv"ripgrep* -> ripgrep" pick"ripgrep/rg"
zinit light BurntSushi/ripgrep

# EXA
zinit ice wait"2" lucid from"gh-r" as"program" mv"bin/exa* -> exa"
zinit light ogham/exa
zinit ice wait blockf atpull'zinit creinstall -q .'

# FD
zinit ice as"command" from"gh-r" mv"fd* -> fd" pick"fd/fd"
zinit light sharkdp/fd

zinit ice wait'0'
zinit light zsh-users/zsh-completions

## 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
zstyle ':completion:*:default' menu select=1

# Fzf
[ -f ~/.fzf.zsh ] && . ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# because starship is beign slow
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# MacOS Stuff
if [[ "$OSTYPE" == "darwin"* ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi	

. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

export AWS_SDK_LOAD_CONFIG=1
export EDITOR='nvim'
export VISUAL=$EDITOR
export PAGER='less'

autoload colors && colors

# Golang
alias go-reshim="asdf reshim golang && export GOROOT='$(asdf where golang)/go/'"
export GOROOT="$(asdf where golang)/go/"
export GOOS=$OS
export GOARCH=amd64
export GOBIN=$GOROOT/bin
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# Yarn
# export PATH=$(yarn global bin):$PATH

# :thinking:
export PATH="/usr/local/opt/libpq/bin:$PATH"

# GPG
GPG_TTY=$(tty)
export GPG_TTY
export EDITOR=nvim

# Aliases
alias vimdiff="nvim -d "
alias dc="docker compose"
alias ls=exa
alias vim=nvim
alias vi=nvim

alias rg=batgrep.sh
alias bd=batdiff.sh
alias man=batman.sh

. $HOME/.cargo/env

# Add amplify to path
[ -f ~/.amplify ] && export PATH="$HOME/.amplify/bin:$PATH"

# eval "$(starship init zsh)"
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
  compinit;
else
  compinit -C
fi
