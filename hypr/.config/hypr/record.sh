#!/bin/bash
# Usage: record.sh <mode>
# Modes: area, fullscreen

mode="${1:-area}"

countdown() {
    notify-send -t 1000 "Recording" "🔴 3..."
    sleep 1
    notify-send -t 1000 "Recording" "🔴 2..."
    sleep 1
    notify-send -t 1000 "Recording" "🔴 1..."
    sleep 1
}

f=~/Downloads/rec_$(date +%Y%m%d_%H%M%S).mp4

case "$mode" in
    area)
        geo="$(slurp)"
        countdown
        notify-send -t 5000 "Recording" "🔴 Recording area for 5 seconds..."
        timeout 5 wf-recorder -g "$geo" -f "$f"
        notify-send -t 2000 "Recording" "✅ Saved to $f"
        ;;
    fullscreen)
        secs=$(printf "" | fuzzel --dmenu --prompt "Record seconds (default 5): ")
        [[ -z "$secs" ]] && secs=5
        [[ "$secs" =~ ^[0-9]+$ ]] || exit 0
        countdown
        notify-send -t $((secs * 1000)) "Recording" "🔴 Recording full screen for ${secs} seconds..."
        timeout "$secs" wf-recorder -f "$f"
        notify-send -t 2000 "Recording" "✅ Saved to $f"
        ;;
esac
