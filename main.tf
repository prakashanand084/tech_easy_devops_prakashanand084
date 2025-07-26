provider "aws" {
  region = var.region
}

resource "aws_security_group" "app_sg" {
  name        = "app-sg-${var.stage}"
  description = "Allow HTTP traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")

  vars = {
    repo_url               = var.repo_url
    shutdown_after_minutes = var.shutdown_delay / 60
  }
}

resource "aws_instance" "app_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  user_data              = data.template_file.user_data.rendered

  tags = {
    Name  = "DevOpsApp-${var.stage}"
    Stage = var.stage
  }
}
