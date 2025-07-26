
variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
  default     = "ami-0c02fb55956c7d316" # Amazon Linux 2
}

variable "key_name" {
  description = "Name of existing EC2 key pair"
  type        = string
}

variable "repo_url" {
  description = "GitHub repo to clone"
  type        = string
  default     = "https://github.com/Trainings-TechEazy/test-repo-for-devops"
}