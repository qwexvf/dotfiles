#!/bin/bash
usage=$(top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%* id.*/\1/' | awk '{print int(100 - $1)}')
gov=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo "unknown")
case "$gov" in
  performance) mode="PERF" ;;
  powersave)   mode="SAVE" ;;
  *)           mode="$gov" ;;
esac
tp_hwmon=$(grep -l thinkpad /sys/class/hwmon/hwmon*/name 2>/dev/null | head -1 | xargs dirname 2>/dev/null)
fan=$(cat "$tp_hwmon/fan1_input" 2>/dev/null || echo "0")
temp=$(awk '{print int($1/1000)}' "$tp_hwmon/temp1_input" 2>/dev/null || echo "0")
echo "{\"usage\":${usage},\"governor\":\"${mode}\",\"fan\":${fan},\"temp\":${temp}}"
