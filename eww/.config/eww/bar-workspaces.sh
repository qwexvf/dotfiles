#!/bin/bash
# Outputs JSON: { "active": N, "workspaces": [ { "id": 1, "urgent": false, "windows": [...] }, ... ] }

print_state() {
  active=$(hyprctl activeworkspace -j | jq '.id')
  workspaces=$(hyprctl workspaces -j | jq -c '[.[].id | select(. > 0)] | sort')
  clients=$(hyprctl clients -j | jq -c '[.[] | select(.workspace.id > 0) | {ws: .workspace.id, class: .class, urgent: (.urgencyHint // false)}]')

  echo "${workspaces}" | jq -c --argjson clients "$clients" --argjson active "$active" '{
    active: $active,
    workspaces: [.[] as $id | {
      id: $id,
      urgent: ([$clients[] | select(.ws == $id and .urgent == true)] | length > 0),
      windows: [$clients[] | select(.ws == $id) | .class]
    }]
  }'
}

print_state

socat -U - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
  case "$line" in
    workspace*|createworkspace*|destroyworkspace*|focusedmon*|openwindow*|closewindow*|movewindow*|urgent*)
      print_state
      ;;
  esac
done
