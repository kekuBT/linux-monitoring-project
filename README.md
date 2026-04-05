Gemini said
Linux System Monitoring & Alerting Tool
A lightweight Linux monitoring system built using Bash that tracks CPU, memory, and disk usage, logs system health over time, and generates alerts based on predefined thresholds.

Features
Real-time Monitoring: Tracks CPU usage, Memory availability, and Disk consumption.

Health Status Classification:

OK: System within normal limits.

WARN: Metrics exceed 70% usage.

CRITICAL: Metrics exceed 90% usage.

Data Persistence: Records all system metrics to system_health.log.

Alert Logging: Segregates abnormal conditions into alerts.log for quick review.

Automation: Designed for seamless execution via cron jobs.

Analysis Tool: Includes a script to extract peak performance metrics and total incident counts.

Tech Stack
Language: Bash Scripting

Core Utilities: awk, grep, top, free, df

Automation: Cron (Job Scheduling)

Project Structure
Plaintext
linux-monitoring-project/
├── scripts/
│   ├── monitor.sh        # Resource collection and threshold logic
│   └── analyze_logs.sh   # Log parser for system insights
├── logs/
│   ├── system_health.log # Historical data
│   ├── alerts.log        # Warnings and critical events
│   └── cron_debug.log    # Cron execution logs
└── README.md
Setup and Usage
1. Clone the Repository
Bash
git clone <your-repo-url>
cd linux-monitoring-project
2. Make Scripts Executable
Bash
chmod +x scripts/*.sh
3. Manual Execution
To run a single check immediately:

Bash
./scripts/monitor.sh
4. Set Up Automation
To run the monitor every minute, add it to your crontab:

Open the editor: crontab -e

Add the following line (use the absolute path to your project):

Bash
* * * * * /bin/bash /absolute/path/to/scripts/monitor.sh
5. View System Logs
Bash
tail -f logs/system_health.log
cat logs/alerts.log
6. Analyze Captured Data
Run the analysis script to see peak usage:

Bash
./scripts/analyze_logs.sh
Example Output
Log Format:

Plaintext
[OK] CPU: 1.1%
[OK] Memory: 14.41%
[OK] Disk: 9%
Analysis Summary:

Plaintext
===== SYSTEM ANALYSIS =====
Total log entries: 56
Total alerts: 1
Max CPU usage: 85%
Max Memory usage: 16.98%
Max Disk usage: 9%
Lessons Learned
Bash Scripting: Developing logic for resource tracking and conditional alerting.

Automation: Configuring cron jobs and handling absolute vs. relative pathing in headless environments.

Data Parsing: Using awk and grep to transform raw CLI output into structured log data.

Environment Stability: Managing permissions and directory structures for reliable background execution.
