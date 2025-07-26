variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "key_name" {
  type        = string
  description = "EC2 Key pair name"
}

variable "repo_url" {
  type        = string
  description = "GitHub repository URL"
  default     = "https://github.com/Trainings-TechEazy/test-repo-for-devops"
}

variable "shutdown_delay" {
  type        = number
  description = "Shutdown delay in seconds"
  default     = 480  # 8 minutes
}

variable "stage" {
  type        = string
  description = "Stage (dev/prod)"
}

variable "ami_id" {
  type        = string
  description = "AMI ID (e.g., Amazon Linux 2023)"
}
