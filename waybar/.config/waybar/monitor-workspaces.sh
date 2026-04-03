#!/bin/bash
# Clean monitor-workspace indicator with pango markup
# Focused monitor is bright, others are dimmed
# Format: "1:WS  2:WS" sorted left-to-right

hyprctl monitors -j | jq -c '
  sort_by(.x) |
  to_entries |
  map(
    .value as $m |
    (.key + 1 | tostring) as $num |
    if $m.focused then
      "<span color=\u0027#7aa2b3\u0027><b>" + $num + ":" + ($m.activeWorkspace.id | tostring) + "</b></span>"
    else
      "<span color=\u0027#555555\u0027>" + $num + ":" + ($m.activeWorkspace.id | tostring) + "</span>"
    end
  ) |
  join("  ") |
  { text: . }
'
