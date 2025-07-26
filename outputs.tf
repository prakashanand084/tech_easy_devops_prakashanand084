output "public_ip" {
  value = aws_instance.app_instance.public_ip
}

output "app_url" {
  value = "http://${aws_instance.app_instance.public_ip}/hello"
}
