#!/bin/bash

CPU_THRESHOLD=75
MEM_THRESHOLD=82
DISK_THRESHOLD=83

REMOTE_SERVER="10.2.0.10"
REMOTE_PORT=514

cpu_load=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
mem_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
disk_usage=$(df / | grep / | awk '{print $5}' | sed 's/%//g')

if (( $(echo "$cpu_load >= $CPU_THRESHOLD" |bc -l) )); then
    logger -n $REMOTE_SERVER -P $REMOTE_PORT -p local0.warning "CPU load is above $CPU_THRESHOLD%: Current load is $cpu_load%"
fi

if (( $(echo "$mem_usage >= $MEM_THRESHOLD" |bc -l) )); then
    logger -n $REMOTE_SERVER -P $REMOTE_PORT -p local0.warning "Memory usage is above $MEM_THRESHOLD%: Current usage is $mem_usage%"
fi

if (( $(echo "$disk_usage >= $DISK_THRESHOLD" |bc -l) )); then
    logger -n $REMOTE_SERVER -P $REMOTE_PORT -p local0.warning "Disk usage is above $DISK_THRESHOLD%: Current usage is $disk_usage%"
fi
