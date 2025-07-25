 #!/bin/bash
 dnf update -y
 dnf install java-21-amazon-corretto -y
 dnf install maven git -y
 git clone ${repo_url}
 cd test-repo-for-devops
 mvn clean package
 java -jar target/hellomvc-0.0.1-SNAPSHOT.jar --server.port=80 &
 shutdown -h +${shutdown_after_minutes}