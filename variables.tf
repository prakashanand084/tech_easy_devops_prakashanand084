variable "ami" {
  description = "passing ami value"
  type        = string
  default     = ""

}
variable "instance_type" {
  type    = string
  default = ""

}
variable "key_name" {
  type    = string
  default = ""

}
variable "name" {
  description = "The name of the EC2 instance."
  default     = ""
}

variable "repo_url" {
  type    = string
  default = ""
}

variable "shutdown_after_minutes" {
  type    = number
  default = 20
}