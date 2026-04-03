#!/bin/bash
count=$(swaync-client -c 2>/dev/null || echo "0")
dnd=$(swaync-client -D 2>/dev/null || echo "false")
echo "{\"count\":${count},\"dnd\":${dnd}}"
