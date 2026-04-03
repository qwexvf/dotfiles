#!/bin/bash
# Outputs the active window title

print_title() {
  hyprctl activewindow -j | jq -r '.title // ""' | cut -c1-60
}

print_title

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
  case "$line" in
    activewindow*|workspace*|focusedmon*)
      print_title
      ;;
  esac
done
