provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "s3_write_role" {
  name = "ec2-s3-write-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "s3_write_policy" {
  name        = "S3WriteOnlyPolicy"
  description = "Policy to allow EC2 to upload logs to S3"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "s3:PutObject"
      ],
      Resource = "arn:aws:s3:::${var.bucket_name}/*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.s3_write_role.name
  policy_arn = aws_iam_policy.s3_write_policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.s3_write_role.name
}

resource "aws_s3_bucket" "logs_bucket" {
  bucket         = var.bucket_name
  force_destroy  = true
}

resource "aws_s3_bucket_lifecycle_configuration" "log_cleanup" {
  bucket = aws_s3_bucket.logs_bucket.id

  rule {
    id     = "delete-old-logs"
    status = "Enabled"

    filter {}

    expiration {
      days = 7
    }
  }
}

resource "aws_instance" "app_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
              #!/bin/bash
              exec > >(tee /var/log/user-data.log|logger -t user-data) 2>&1
              dnf update -y
              dnf install -y java-21-amazon-corretto maven git awscli
              cd /home/ec2-user
              git clone https://github.com/Trainings-TechEazy/test-repo-for-devops
              cd test-repo-for-devops
              mvn clean package
              nohup java -jar target/hellomvc-0.0.1-SNAPSHOT.jar --server.port=80 > /home/ec2-user/app.log 2>&1 &
              cat <<EOL > /home/ec2-user/upload_and_shutdown.sh
              #!/bin/bash
              sleep 480
              aws s3 cp /var/log/cloud-init.log s3://${var.bucket_name}/system/cloud-init.log
              aws s3 cp /home/ec2-user/app.log s3://${var.bucket_name}/app/logs/app.log
              shutdown -h now
              EOL
              chmod +x /home/ec2-user/upload_and_shutdown.sh
              nohup /home/ec2-user/upload_and_shutdown.sh &
              EOF

  tags = {
    Name = "ec2-instance"
  }
}
