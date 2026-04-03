#!/bin/bash
# Window + zellij switcher using fzf

items=""

# Hyprland windows
items+=$(hyprctl clients -j | jq -r '.[] | select(.workspace.id > 0) | "hypr\t\(.address)\t  \(.class)  ·  ws \(.workspace.id)  ·  \(.title)"')
items+=$'\n'

# Zellij sessions + tabs
while IFS= read -r session; do
  session_name=$(echo "$session" | sed 's/\x1b\[[0-9;]*m//g' | awk '{print $1}')
  status="active"
  echo "$session" | grep -q "EXITED" && status="exited"

  tab_idx=0
  while IFS= read -r tab; do
    [ -z "$tab" ] && continue
    items+="zellij	${session_name}	${tab_idx}	  zellij  ·  ${session_name}  ·  ${tab} (${status})"
    items+=$'\n'
    tab_idx=$((tab_idx + 1))
  done < <(zellij -s "$session_name" action query-tab-names 2>/dev/null)

  # If no tabs (exited session), still show the session
  if [ "$tab_idx" -eq 0 ]; then
    items+="zellij	${session_name}	0	  zellij  ·  ${session_name} (${status})"
    items+=$'\n'
  fi
done < <(zellij list-sessions 2>/dev/null)

selected=$(echo "$items" | grep -v '^$' | \
  fzf --with-nth=4.. --delimiter='\t' \
    --prompt="  " \
    --pointer="▸" \
    --layout=reverse \
    --no-info \
    --no-scrollbar \
    --margin=0,1 \
    --no-separator)

[ -z "$selected" ] && exit 0

type=$(echo "$selected" | cut -f1)

if [ "$type" = "hypr" ]; then
  address=$(echo "$selected" | cut -f2)
  hyprctl dispatch focuswindow "address:${address}"
elif [ "$type" = "zellij" ]; then
  session=$(echo "$selected" | cut -f2)
  tab=$(echo "$selected" | cut -f3)
  alacritty -e zellij attach "$session" &
  sleep 0.3
  zellij -s "$session" action go-to-tab-name "$tab" 2>/dev/null
fi
