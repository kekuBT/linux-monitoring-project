Let's format this better for readme

# Linux System Monitoring & Alerting Tool

A lightweight Linux monitoring system built using Bash that tracks CPU, memory, and disk usage, logs system health over time, and generates alerts based on predefined thresholds.

---

## Features

- Real-time monitoring of:
  - CPU usage
  - Memory usage
  - Disk usage
- Health status classification:
  - OK
  - WARN
  - CRITICAL
- Persistent logging of system metrics
- Alert logging for abnormal conditions
- Automated execution using cron
- Log analysis tool for extracting system insights

---

## Tech Stack

- Bash scripting
- Linux CLI tools (`top`, `free`, `df`, `awk`, `grep`)
- Cron (job scheduling)

---

## Project Structure
linux-monitoring-project/
├── scripts/
│ ├── monitor.sh
│ └── analyze_logs.sh
├── logs/
│ ├── system_health.log
│ ├── alerts.log
│ └── cron_debug.log
└── README.md


---

## How It Works

### Monitoring Script (`monitor.sh`)
- Collects CPU, memory, and disk usage
- Evaluates each metric against thresholds
- Logs system health to `system_health.log`
- Logs warnings and critical events to `alerts.log`

### Automation
- Uses cron to run the monitoring script every minute

### Analysis Script (`analyze_logs.sh`)
- Counts total log entries
- Counts total alerts
- Extracts maximum CPU, memory, and disk usage from logs

---

## Setup & Usage

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd linux-monitoring-project

2. Make scripts executable
chmod +x scripts/monitor.sh
chmod +x scripts/analyze_logs.sh

3. Run manually
./scripts/monitor.sh
4. Set up cron job
crontab -e

Add:

* * * * * /bin/bash /path-to-project/scripts/monitor.sh
5. View logs
cat logs/system_health.log
cat logs/alerts.log

6. Analyze logs
./scripts/analyze_logs.sh

Example Output
[OK] CPU: 1.1%
[OK] Memory: 14.41%
[OK] Disk: 9%

===== SYSTEM ANALYSIS =====
Total log entries: 56
Total alerts: 1
Max CPU usage: 100%
Max Memory usage: 16.98%
Max Disk usage: 9%

What I Learned
Writing reliable Bash scripts for system monitoring
Automating tasks using cron jobs
Parsing and analyzing log data using awk and grep
Handling real-world issues like path resolution and environment differences in cron