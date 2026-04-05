#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SYSTEM_LOG="$BASE_DIR/logs/system_health.log"
ALERT_LOG="$BASE_DIR/logs/alerts.log"

echo "===== SYSTEM ANALYSIS ====="

# Total entries
total_entries=$(wc -l < "$SYSTEM_LOG")
echo "Total log entries: $total_entries"

# Total alerts
if [ -f "$ALERT_LOG" ]; then
    total_alerts=$(wc -l < "$ALERT_LOG")
else
    total_alerts=0
fi
echo "Total alerts: $total_alerts"

# Max CPU
max_cpu=$(grep -oP 'CPU: \K[0-9.]+' "$SYSTEM_LOG" | sort -nr | head -1)
echo "Max CPU usage: $max_cpu%"

# Max Memory
max_mem=$(grep -oP 'Memory: \K[0-9.]+' "$SYSTEM_LOG" | sort -nr | head -1)
echo "Max Memory usage: $max_mem%"

# Max Disk
max_disk=$(grep -oP 'Disk: \K[0-9.]+' "$SYSTEM_LOG" | sort -nr | head -1)
echo "Max Disk usage: $max_disk%"