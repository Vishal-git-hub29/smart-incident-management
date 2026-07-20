variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.small"
}

variable "ami_id" {
  description = "Ubuntu 24.04 LTS AMI"
  type        = string
  default     = "ami-0f918f7e67a3323f0"
}

variable "key_name" {
  description = "EC2 Key Pair Name"
  type        = string
  default     = "Smart IMS"
}

variable "instance_name" {
  description = "EC2 Instance Name"
  type        = string
  default     = "smartims-server"
}
