#!/bin/bash

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
mem_usage=$(free | awk '/Mem:/ {printf("%.2f"), $3/$2 * 100}')
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

cpu_status=$(get_status "$cpu_usage" 70 85)
mem_status=$(get_status "mem_usage" 70 85)
disk_status=$(get_status "disk_usage" 80 90)

echo "[$cpu_status] CPU: ${cpu_usage}%"
echo "[$mem_status] Memory: $mem_usage}%"
echo "[$disk_status] Disk: ${disk_usage}%"