#!/bin/bash
SESSION='workspace'

# Example of tmux session setup script. This particular example starts several
# rails servers on a development machine. The session we create is named "my_session".
 
# Tests to see if the session already exists. If it does, just skip everything and reattach.
if [ "$(tmux list-sessions 2> /dev/null | grep -o $SESSION)" != "$SESSION" ]; then
 
  tmux new-session -d -s $SESSION

  # NOTE: We have to call bash (or $SHELL) after every command, or else the window will quit.
  #       This is not necessary if you don't run any commands.

  # tmux send-keys -t slack 'weechat' C-m
  tmux new-window -t $SESSION:1 -n 'slack' "weechat"
  # tmux new-window -t $SESSION:5 -n '(R)app' "cd ~/Code/app; bundle exec rails server -p 3000; $SHELL"
 
  # Gets rid of window 0, which is not accessible right away (hence sleep 1)
  sleep 1
  tmux unlink-window -k -t $SESSION:0
 
else
  tmux attach -t $SESSION
fi
