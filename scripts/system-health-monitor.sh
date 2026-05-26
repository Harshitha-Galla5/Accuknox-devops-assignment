#!/bin/bash

# Threshold values
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

# Log file
LOG_FILE="system_health.log"

echo "==========================================" >> $LOG_FILE
echo "System Health Report - $(date)" >> $LOG_FILE
echo "==========================================" >> $LOG_FILE

# CPU Usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2)}')

echo "CPU Usage: ${CPU_USAGE}%" >> $LOG_FILE

if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "[ALERT] High CPU Usage Detected!" >> $LOG_FILE
fi

# Memory Usage
MEMORY_USAGE=$(free | awk '/Mem:/ {print int($3/$2 * 100)}')

echo "Memory Usage: ${MEMORY_USAGE}%" >> $LOG_FILE

if [ "$MEMORY_USAGE" -gt "$MEMORY_THRESHOLD" ]; then
    echo "[ALERT] High Memory Usage Detected!" >> $LOG_FILE
fi

# Disk Usage
DISK_USAGE=$(df -h / | awk 'END {print $5}' | sed 's/%//')

echo "Disk Usage: ${DISK_USAGE}%" >> $LOG_FILE

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "[ALERT] High Disk Usage Detected!" >> $LOG_FILE
fi

# Running Processes
echo "" >> $LOG_FILE
echo "Top 5 Running Processes:" >> $LOG_FILE

ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6 >> $LOG_FILE

echo "" >> $LOG_FILE
echo "System health monitoring completed." >> $LOG_FILE
echo "" >> $LOG_FILE

echo "System health monitoring completed successfully."
