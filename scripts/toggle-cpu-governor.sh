#!/bin/bash

# Toggle CPU governor between powersave and performance
current_gov=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)

if [ "$current_gov" = "powersave" ]; then
    echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
else
    echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
fi