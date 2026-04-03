#!/bin/bash
wifi=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2)
if [ -n "$wifi" ]; then
  echo "{\"type\":\"wifi\",\"essid\":\"${wifi}\"}"
elif ip link show | grep -q 'state UP.*ether'; then
  iface=$(ip -o link show | grep 'state UP' | grep -v 'lo:' | head -1 | awk -F': ' '{print $2}')
  echo "{\"type\":\"ethernet\",\"essid\":\"${iface}\"}"
else
  echo "{\"type\":\"disconnected\",\"essid\":\"\"}"
fi
