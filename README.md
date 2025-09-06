
# Project Documents

This repository contains a small collection of personal documentation and utility scripts, structured as a simple single-page application (SPA).

## Contents

* `index.html`: The main entry point. This is a self-contained documentation hub that lists all other documents and notes. Open this file in a browser to get started.

* `postgresSetup.html`: An interactive guide for installing and configuring a new PostgreSQL server instance. It provides OS-specific commands and allows you to generate personalized command snippets.

* `postgresSetupServer.sh`: A shell script that automates the entire PostgreSQL setup process described in the interactive guide.

## Usage

### Documentation Hub

Simply open `index.html` in your web browser to view the documentation portal.

### PostgreSQL Automation Script

The `postgresSetupServer.sh` script can be run to quickly create a new PostgreSQL instance.

```bash
# Make the script executable
chmod +x postgresSetupServer.sh

# Run with default settings (data in /tmp/postgres_data, port 5433)
./postgresSetupServer.sh

# Run with custom parameters
./postgresSetupServer.sh /path/to/data 5434 my_database
