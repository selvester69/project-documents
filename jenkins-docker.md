# 🏗️ Jenkins Persistent Setup with Docker

This repository provides a **simple, persistent, and containerized Jenkins setup** using Docker.  
It ensures all Jenkins data (jobs, plugins, and configurations) is stored on your local machine so you never lose progress even if the container restarts or is removed.

---

## 📦 Project Contents

- **Dockerfile** – Custom Jenkins image definition based on the official LTS version with JDK 17.  
- **start_jenkins.sh** – Helper script to manage the Jenkins container (`start`, `stop`, `status`).  
- **README.md** – This documentation.

---

## 🚀 Getting Started

### 1. Prerequisites
- [Docker](https://docs.docker.com/get-docker/) installed on your machine  
- Basic knowledge of shell commands

---

### 2. Setup

Clone this repository and move into the project directory:

```bash
git clone https://github.com/your-username/jenkins-docker-setup.git
cd jenkins-docker-setup
````

Make sure the script is executable:

```bash
chmod +x start_jenkins.sh
```

---

### 3. Run Jenkins

#### Start Jenkins

```bash
bash start_jenkins.sh start
```

#### Stop Jenkins

```bash
bash start_jenkins.sh stop
```

#### Check Status

```bash
bash start_jenkins.sh status
```

---

### 4. Access Jenkins

Once started, open:

👉 [http://localhost:9090](http://localhost:9090)

For the first run, Jenkins will ask for the **initial admin password**.
You can retrieve it by running:

```bash
docker logs jenkins-server
```

---

## 🗄️ Data Persistence

Jenkins data is mounted to:

* **Host machine:**
  `...path to jenkins`

* **Container:**
  `/var/jenkins_home`

This ensures jobs, plugins, and configurations **survive container restarts/removals**.

---

## 📑 Dockerfile

```dockerfile
# Custom Jenkins image based on official LTS with JDK 17
FROM jenkins/jenkins:lts-jdk17

# Declare Jenkins home as a volume for persistence
VOLUME /var/jenkins_home
```

---

## ⚙️ start\_jenkins.sh Script

```bash
#!/bin/bash

# Container details
CONTAINER_NAME="jenkins-server"
IMAGE_NAME="jenkins/jenkins:lts-jdk17"

# Function to check container status
check_status() {
  if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    echo "Jenkins container is running."
    return 0
  elif [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    echo "Jenkins container exists but is stopped."
    return 1
  else
    echo "Jenkins container does not exist."
    return 2
  fi
}

# Main logic
case "$1" in
  start)
    check_status
    status=$?
    if [ $status -eq 0 ]; then
      echo "Jenkins container is already running."
    elif [ $status -eq 1 ]; then
      echo "Starting existing Jenkins container..."
      docker start $CONTAINER_NAME
    else
      echo "Creating and starting new Jenkins container..."
      docker run \
        -d \
        -p 9090:8080 \
        -p 50000:50000 \
        -v <localpath_placeHOlder>:/var/jenkins_home \
        --name $CONTAINER_NAME \
        $IMAGE_NAME
    fi
    echo "Jenkins is running at http://localhost:9090"
    ;;

  stop)
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
      echo "Stopping Jenkins container..."
      docker stop $CONTAINER_NAME
      echo "Jenkins container stopped."
    else
      echo "Jenkins container is not running."
    fi
    ;;

  status)
    check_status
    ;;

  *)
    echo "Usage: $0 {start|stop|status}"
    exit 1
    ;;
esac
```

---

## 🖥️ System Requirements

* **CPU:** 2+ cores recommended
* **RAM:** 4GB minimum (8GB recommended if multiple jobs/agents)
* **Disk:** At least 10GB free for Jenkins home + Docker images

---

## ✅ Summary

✔️ Uses **Jenkins LTS with JDK 17**
✔️ Persistent data storage mapped to host machine
✔️ Easy management via `start|stop|status` script
✔️ Jenkins UI accessible at **[http://localhost:9090](http://localhost:9090)**

## Next Steps:
fixing port conflicts, Docker permission issues, resetting Jenkins home) so anyone using your README won’t get stuck
