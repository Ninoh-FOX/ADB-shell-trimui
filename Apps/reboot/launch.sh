#!/bin/sh

# Function to terminate all non-essential processes
task_killer() {
    for pid in /proc/[0-9]*; do
        pid=$(basename "$pid")
        
        # Ignore critical processes and the script's own process
        if [ "$pid" != "1" ] && [ "$pid" != "$$" ]; then
            kill $1 "$pid" 2>/dev/null
        fi
    done
}

# Attempt graceful shutdown of processes
kill_all_processes() {
    echo "Attempting to gracefully shut down processes..."
    task_killer -TERM
    sleep 0.5  # Wait to allow processes to terminate gracefully

    # Forcefully kill any remaining processes
    echo "Forcing termination of remaining processes..."
    task_killer -KILL
}

# Close all possible processes before rebooting
kill_all_processes

# Synchronize data with storage to minimize data corruption risks
sync

# Reboot the system
echo "Rebooting the system..."
reboot
