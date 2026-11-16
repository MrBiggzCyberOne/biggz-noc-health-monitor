# NOC Health Monitor

This Bash script records the current timestamp, one-minute system load,
available RAM, and free space and usage on the root filesystem. It flags root
disk usage at 80% or higher and appends each check to `system_health.log`
in the script directory.

A NOC can use this monitor to spot rising disk usage before it disrupts services and review the log when troubleshooting.

## Prerequisites

Ubuntu Linux or Ubuntu under WSL, Bash, and the standard `date`, `free`,
`df`, and `awk` commands. The script directory must be writable by the
user running the monitor. Hourly scheduling requires a running cron service.

## Run manually

From the project directory, run:

```bash
chmod +x health_check.sh
./health_check.sh
tail -n 5 system_health.log
```

## Run hourly with cron

Open your user crontab with `crontab -e` and add this entry to run the check
at the start of every hour:

```cron
0 * * * * /home/mrbig/IT_Class/noc-health-monitor/health_check.sh
```

This path matches my Ubuntu WSL setup. If the project is cloned somewhere
else, update the entry to use the script's new absolute path.
