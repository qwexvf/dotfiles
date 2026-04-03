#!/bin/bash
# Outputs JSON array of monitor info on every workspace/monitor change

print_state() {
  hyprctl monitors -j | jq -c '
    sort_by(.x) |
    to_entries |
    map({
      name: .value.name,
      num: (.key + 1),
      ws: .value.activeWorkspace.id,
      focused: .value.focused
    })
  '
}

# Print initial state
print_state

# Listen for relevant Hyprland events and update
socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
  case "$line" in
    workspace*|focusedmon*|moveworkspace*|monitor*)
      print_state
      ;;
  esac
done
