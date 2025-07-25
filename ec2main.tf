# create instance 

resource "aws_instance" "dev" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.dev.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

 user_data = templatefile("${path.module}/install-tools.sh", {
    repo_url               = var.repo_url
    shutdown_after_minutes = var.shutdown_after_minutes
  })

  tags = {
    Name = "dev-anand"
  }
}


