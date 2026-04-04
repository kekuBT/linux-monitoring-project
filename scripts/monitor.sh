#!/bin/bash

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
mem_usage=$(free | awk '/Mem:/ {printf("%.2f"), $3/$2 * 100}')
disk_usage=$(df / | awk 'NR==2 {gsub("%", ""); print $5}')

echo "[OK] CPU: ${cpu_usage}%"
echo "[OK] Memory: $mem_usage}%"
echo "[OK] Disk: ${disk_usage}%"