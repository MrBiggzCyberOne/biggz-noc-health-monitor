#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
log_file="$script_dir/system_health.log"

timestamp="$(date '+%Y-%m-%d %H:%M:%S %z')"
read -r load_1m _ < /proc/loadavg
available_ram="$(LC_ALL=C free -m | awk '/^Mem:/ {print $7}')"
read -r disk_free disk_used < <(
    LC_ALL=C df -h --output=avail,pcent / | awk 'NR == 2 {print $1, $2}'
)

if (( ${disk_used%\%} >= 80 )); then
    status="WARNING: Root disk usage is at or above 80%"
else
    status="OK: Root disk usage is below 80%"
fi

printf '[%s] Load (1 min): %s | Available RAM: %s MiB | Root disk free: %s | Root disk used: %s | %s\n' \
    "$timestamp" "$load_1m" "$available_ram" "$disk_free" "$disk_used" "$status" \
    >> "$log_file"
