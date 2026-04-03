#!/bin/bash
# Power menu via rofi

options="󰌾  Lock\n󰗼  Logout\n󰒲  Suspend\n󰜉  Reboot\n󰐥  Shutdown"

chosen=$(echo -e "$options" | rofi -dmenu -theme powermenu -p "" -no-custom)

case "$chosen" in
    *Lock)     hyprlock ;;
    *Logout)   hyprctl dispatch exit ;;
    *Suspend)  systemctl suspend ;;
    *Reboot)   systemctl reboot ;;
    *Shutdown) systemctl poweroff ;;
esac
