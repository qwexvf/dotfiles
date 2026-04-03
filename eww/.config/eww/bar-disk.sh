#!/bin/bash
pct=$(df / --output=pcent | tail -1 | tr -d ' %')
used=$(df -h / --output=used | tail -1 | tr -d ' ')
echo "{\"percent\":${pct},\"used\":\"${used}\"}"
