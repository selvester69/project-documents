#!/bin/bash
# PostgreSQL Service Control Script
# ---------------------------------
# A script to start, stop, or check the status of a PostgreSQL server.
#
# Usage:
#   ./service_control.sh start   -> Start the PostgreSQL server
#   ./service_control.sh stop    -> Stop the PostgreSQL server
#   ./service_control.sh status  -> Check PostgreSQL server status
#
# Author: Your Name
# Version: 1.1
# ---------------------------------

# --- Variables ---
PG_DATA="/usr/local/var/postgres_new"   # PostgreSQL data directory
PG_LOG_FILE="logfile"                   # Log file for PostgreSQL
PG_PORT="5433"                          # Port number
SERVICE_NAME="PostgreSQL Server"        # Display name
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")  # Current timestamp

# --- Colors ---
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m" # No Color

# --- Functions ---

# Function to check if PostgreSQL is already running
is_running() {
    pg_ctl -D "${PG_DATA}" status > /dev/null 2>&1
    return $?
}

# Function to start PostgreSQL
start_service() {
    if is_running; then
        echo -e "${YELLOW}[INFO] ${SERVICE_NAME} is already running on port ${PG_PORT}.${NC}"
        exit 0
    fi

    echo -e "${YELLOW}[INFO] ${TIMESTAMP} - Starting ${SERVICE_NAME} on port ${PG_PORT}...${NC}"
    pg_ctl -D "${PG_DATA}" -l "${PG_LOG_FILE}" start -o "-p ${PG_PORT}"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[SUCCESS] ${SERVICE_NAME} started successfully.${NC}"
    else
        echo -e "${RED}[ERROR] Failed to start ${SERVICE_NAME}.${NC}"
        exit 1
    fi
}

# Function to stop PostgreSQL
stop_service() {
    if ! is_running; then
        echo -e "${YELLOW}[INFO] ${SERVICE_NAME} is not running.${NC}"
        exit 0
    fi

    echo -e "${YELLOW}[INFO] ${TIMESTAMP} - Stopping ${SERVICE_NAME}...${NC}"
    pg_ctl -D "${PG_DATA}" stop
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[SUCCESS] ${SERVICE_NAME} stopped.${NC}"
    else
        echo -e "${RED}[ERROR] Failed to stop ${SERVICE_NAME}.${NC}"
        exit 1
    fi
}

# Function to check PostgreSQL status
status_service() {
    echo -e "${YELLOW}[INFO] Checking status for ${SERVICE_NAME}...${NC}"
    pg_ctl -D "${PG_DATA}" status
    if is_running; then
        PID=$(head -n1 "${PG_DATA}/postmaster.pid")
        UPTIME=$(ps -o etime= -p "$PID")
        echo -e "${GREEN}[RUNNING] PID: ${PID}, Port: ${PG_PORT}, Uptime: ${UPTIME}${NC}"
    else
        echo -e "${RED}[STOPPED] ${SERVICE_NAME} is not running.${NC}"
    fi
}

# --- Main Logic ---

if [ -z "$1" ]; then
    echo -e "${RED}Usage: $0 {start|stop|status}${NC}"
    exit 1
fi

case "$1" in
    start) start_service ;;
    stop) stop_service ;;
    status) status_service ;;
    *)
        echo -e "${RED}Invalid command: $1${NC}"
        echo -e "Usage: $0 {start|stop|status}"
        exit 1
        ;;
esac

exit 0
