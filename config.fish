alias vi nvim
alias vim nvim

set -x EDITOR vi 
set -x PATH ~/Documents/erlang/otp/bin $PATH
set -x PATH ~/Documents/erlang/elixir/bin $PATH
set -x PATH /usr/local/bin $PATH
set -x PATH (yarn global bin) $PATH

set -x ERL_AFLAGS "-kernel shell_history enabled"

# Asdf
source $HOME/.asdf/asdf.fish
source $HOME/.asdf/completions/asdf.fish

function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end
