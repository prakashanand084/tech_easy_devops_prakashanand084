# #!/bin/bash
# set -e
# exec > >(tee /var/log/user-data.log|logger -t user-data) 2>&1

# dnf update -y
# dnf install -y java-21-amazon-corretto maven git awscli

# repo_url="${repo_url:-https://github.com/Trainings-TechEazy/test-repo-for-devops}"
# git clone $repo_url
# cd test-repo-for-devops

# mvn clean package
# nohup java -jar target/hellomvc-0.0.1-SNAPSHOT.jar --server.port=80 > app.log 2>&1 &

# (
#   sleep 480
#   aws s3 cp /var/log/cloud-init.log s3://${bucket_name}/system/cloud-init.log || echo "cloud-init upload failed"
#   aws s3 cp app.log s3://${bucket_name}/app/logs/app.log || echo "app.log upload failed"
#   shutdown -h now
# ) &
