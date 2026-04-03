#!/bin/bash
# Usage: screenshot.sh <mode>
# Modes: clip, clip-delay, save, save-delay

mode="${1:-clip}"

case "$mode" in
    clip)
        grim -g "$(slurp -d)" - | wl-copy \
            && notify-send -t 2000 "Screenshot" "📷 Copied to clipboard"
        ;;
    clip-delay)
        geo="$(slurp)"
        notify-send -t 5000 "Screenshot" "📷 Capturing in 5 seconds..."
        sleep 5
        grim -g "$geo" - | wl-copy \
            && notify-send -t 2000 "Screenshot" "📷 Copied to clipboard"
        ;;
    save)
        f=~/Downloads/shot_$(date +%Y%m%d_%H%M%S).png
        grim -g "$(slurp)" "$f" \
            && notify-send -t 2000 "Screenshot" "📷 Saved to $f"
        ;;
    save-delay)
        geo="$(slurp)"
        f=~/Downloads/shot_$(date +%Y%m%d_%H%M%S).png
        notify-send -t 5000 "Screenshot" "📷 Capturing in 5 seconds..."
        sleep 5
        grim -g "$geo" "$f" \
            && notify-send -t 2000 "Screenshot" "📷 Saved to $f"
        ;;
esac
