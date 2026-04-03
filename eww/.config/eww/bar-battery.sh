#!/bin/bash
cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo "0")
status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo "Unknown")
echo "{\"capacity\":${cap},\"status\":\"${status}\"}"
