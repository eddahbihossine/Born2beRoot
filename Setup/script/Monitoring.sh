# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Monitoring.sh                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: heddahbi <heddahbi@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/04/15 06:30:40 by heddahbi          #+#    #+#              #
#    Updated: 2024/08/15 00:53:01 by heddahbi         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#!/bin/bash

#this is just an example of a script that can be used to monitor the system
#Not for The purpose of this project
#you can make your own script to monitor the system

LOG_FILE="/var/log/system_monitor.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Check if the log file exists, if not create it
if [ ! -f "$LOG_FILE" ]; then
    sudo touch "$LOG_FILE"
fi

# Log system monitoring info
{
    echo "--------------------------------------------------"
    echo "System Monitoring Report - $DATE"
    echo "--------------------------------------------------"

    # Uptime
    echo "System Uptime:"
    uptime
    echo ""

    # CPU Usage
    echo "CPU Usage:"
    top -bn1 | grep "Cpu(s)"
    echo ""

    # Memory Usage
    echo "Memory Usage:"
    free -h
    echo ""

    # Disk Usage
    echo "Disk Usage:"
    df -h
    echo ""

    # Active Processes
    echo "Top 5 Processes by CPU Usage:"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
    echo ""

    # Network Activity
    echo "Network Activity:"
    ifconfig | grep 'inet ' | grep -v '127.0.0.1'
    echo ""

    echo "--------------------------------------------------"
} >> "$LOG_FILE"
