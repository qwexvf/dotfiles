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

# Customize to your needs...
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

alias vi=nvim
alias vim=nvim

export PATH=$(yarn global bin):$PATH
export GPG_TTY=$(tty)

# . ~/.asdf/plugins/java/asdf-java-wrapper.zsh

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

ANDROID_HOME=/Users/qwexvf/Library/Android/sdk
ANDROID_NDK_HOME=/Users/qwexvf/Library/Android/sdk/ndk-bundle
. ~/.asdf/plugins/java/asdf-java-wrapper.zsh
export PATH=/usr/local:$PATH:$NODEBREW_HOME/bin:$ANDROID_HOME:$ANDROID_NDK_HOME:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
