#!/bin/bash
read -r total avail <<< "$(awk '/MemTotal/{t=$2} /MemAvailable/{a=$2} END{print t, a}' /proc/meminfo)"
used=$(awk "BEGIN{printf \"%.1f\", ($total - $avail) / 1048576}")
totalg=$(awk "BEGIN{printf \"%.1f\", $total / 1048576}")
pct=$(awk "BEGIN{printf \"%d\", 100 * ($total - $avail) / $total}")
echo "{\"used\":\"${used}\",\"total\":\"${totalg}\",\"percent\":${pct}}"
