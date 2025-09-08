
# Project Documents (--- IN PROGRESS ----)

This repository contains a small collection of personal documentation and utility scripts, structured as a simple single-page application (SPA).

## Contents

* `index.html`: The main entry point. This is a self-contained documentation hub that lists all other documents and notes. Open this file in a browser to get started.

* `postgresSetup.html`: An interactive guide for installing and configuring a new PostgreSQL server instance. It provides OS-specific commands and allows you to generate personalized command snippets.

* `postgresSetupServer.sh`: A shell script that automates the entire PostgreSQL setup process described in the interactive guide.

## Usage

### Documentation Hub

Because this project loads content dynamically using JavaScript's `fetch` API, you must run it from a local web server to avoid browser security errors (CORS policy).

1. Open your terminal and navigate to the project directory:

    ```bash
    cd /path/to/project-documents
    ```

2. Start a simple web server using Python:

    ```bash
    python3 -m http.server 8000
    ```

3. Open your browser and navigate to `http://localhost:8000`.

### PostgreSQL Automation Script

The `postgresSetupServer.sh` script can be run to quickly create a new PostgreSQL instance.

```bash
# Make the script executable
chmod +x postgresSetupServer.sh

# Run with default settings (data in /tmp/postgres_data, port 5433)
./postgresSetupServer.sh

# Run with custom parameters
./postgresSetupServer.sh /path/to/data 5434 my_database
