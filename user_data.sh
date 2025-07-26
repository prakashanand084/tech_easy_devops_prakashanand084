#!/bin/bash
dnf update -y
dnf install java-21-amazon-corretto -y
dnf install maven git -y

# Clone the repo
git clone ${repo_url}
cd test-repo-for-devops

# Build the app
mvn clean package

# Run the app on port 80
nohup java -jar target/hellomvc-0.0.1-SNAPSHOT.jar --server.port=80 > /dev/null 2>&1 &

# Shutdown after X minutes
shutdown -h +${shutdown_after_minutes}
