#!/bin/bash
# A script to start, stop, or check the status of a PostgreSQL server.
#
# Usage: ./service_control.sh [start|stop|status]

# --- Variables ---
# Define the PostgreSQL data directory and log file
PG_DATA="/usr/local/var/postgres_new"
PG_LOG_FILE="logfile"
# Define the port for the new server
PG_PORT="5433"
# Service name for display purposes
SERVICE_NAME="PostgreSQL Server"

# --- Functions ---

# Function to start the PostgreSQL server
start_service() {
    echo "Starting ${SERVICE_NAME} on port ${PG_PORT}..."
    pg_ctl -D "${PG_DATA}" -l "${PG_LOG_FILE}" start -o "-p ${PG_PORT}"
    # Check the exit status of the pg_ctl command
    if [ $? -eq 0 ]; then
        echo "${SERVICE_NAME} started successfully."
    else
        echo "Failed to start ${SERVICE_NAME}."
        exit 1
    fi
}

# Function to stop the PostgreSQL server
stop_service() {
    echo "Stopping ${SERVICE_NAME}..."
    pg_ctl -D "${PG_DATA}" stop
    if [ $? -eq 0 ]; then
        echo "${SERVICE_NAME} stopped."
    else
        echo "Failed to stop ${SERVICE_NAME}."
        exit 1
    fi
}

# Function to check the PostgreSQL server status
status_service() {
    echo "Checking status for ${SERVICE_NAME}..."
    pg_ctl -D "${PG_DATA}" status
    # The pg_ctl status command will output the status and set the exit code accordingly.
}

# --- Main Logic ---

# Check if an argument was provided
if [ -z "$1" ]; then
    echo "Usage: $0 [start|stop|status]"
    exit 1
fi

# Use a case statement to handle different arguments
case "$1" in
    start)
        start_service
        ;;
    stop)
        stop_service
        ;;
    status)
        status_service
        ;;
    *)
        # Default case for invalid arguments
        echo "Invalid command: $1"
        echo "Usage: $0 [start|stop|status]"
        exit 1
        ;;
esac

exit 0
