#!/bin/bash
# Battery low alert script

BATTERY_PATH="/sys/class/power_supply/BAT0"
LOW_THRESHOLD=20
CRITICAL_THRESHOLD=10

# Get battery level and status
battery_level=$(cat "$BATTERY_PATH/capacity")
battery_status=$(cat "$BATTERY_PATH/status")

# Only alert if discharging
if [ "$battery_status" = "Discharging" ]; then
    if [ "$battery_level" -le "$CRITICAL_THRESHOLD" ]; then
        notify-send -u critical "Battery Critical" "Battery at ${battery_level}% - Plug in now!"
    elif [ "$battery_level" -le "$LOW_THRESHOLD" ]; then
        notify-send -u critical "Battery Low" "Battery at ${battery_level}%"
    fi
fi
