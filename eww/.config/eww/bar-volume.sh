#!/bin/bash
# Outputs JSON: { "volume": N, "muted": true|false }
print_vol() {
  vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
  num=$(echo "$vol" | awk '{printf "%d", $2 * 100}')
  if echo "$vol" | grep -q MUTED; then
    echo "{\"volume\":${num},\"muted\":true}"
  else
    echo "{\"volume\":${num},\"muted\":false}"
  fi
}

print_vol
pactl subscribe 2>/dev/null | while read -r line; do
  if echo "$line" | grep -q "sink"; then
    print_vol
  fi
done
