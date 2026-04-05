#!/bin/bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SYSTEM_LOG="$BASE_DIR/logs/system_health.log"
ALERT_LOG="$BASE_DIR/logs/alerts.log"

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{print 100 - $4}' | awk '{print $1}')
mem_usage=$(free | awk '/Mem:/ {printf("%.2f", $3/$2 * 100)}')
disk_usage=$(df / | awk 'NR==2 {gsub("%", ""); print $5}')

get_status() {
    local value=$1
    local warn=$2
    local crit=$3

    if (( $(echo "$value >= $crit" | bc -l) )); then
        echo "CRITICAL"
    elif (( $(echo "$value >= $warn" | bc -l) )); then
        echo "WARN"
    else
        echo "OK"
    fi

}

log_alert_if_needed() {
    local metric_name=$1
    local metric_value=$2
    local metric_status=$3
    local timestamp=$4

    if [[ "$metric_status" == "WARN" || "$metric_status" == "CRITICAL" ]]; then
        echo "[$timestamp] ALERT: $metric_name is at ${metric_value}% ($metric_status)" >> "$ALERT_LOG"
    fi
}

cpu_status=$(get_status "$cpu_usage" 70 85)
mem_status=$(get_status "$mem_usage" 70 85)
disk_status=$(get_status "$disk_usage" 80 90)

echo "[$cpu_status] CPU: ${cpu_usage}%"
echo "[$mem_status] Memory: ${mem_usage}%"
echo "[$disk_status] Disk: ${disk_usage}%"

timestamp=$(date '+%Y-%m-%d %H:%M:%S')

log_entry="[$timestamp] CPU: ${cpu_usage}% (${cpu_status}) | Memory: ${mem_usage}% (${mem_status}) | Disk: ${disk_usage}% (${disk_status})"
echo "$log_entry" >> "$SYSTEM_LOG"

log_alert_if_needed "CPU" "$cpu_usage" "$cpu_status" "$timestamp"
log_alert_if_needed "Memory" "$mem_usage" "$mem_status" "$timestamp"
log_alert_if_needed "Disk" "$disk_usage" "$disk_status" "$timestamp"