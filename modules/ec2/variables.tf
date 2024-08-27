variable "instance-name" {
  type        = string
  description = "The name of the resources."
}
variable "key_name" {
  type        = string
  description = "Key name of the ec2 instance"
}

variable "region" {
  type        = string
  description = "Region name"
}

variable "instance_count" {
  type        = number
  description = "Count of the ec2 instances"
}

variable "subnet_id" { }
variable "vpc_security_group_id" {}
variable "vpc_id" {  }
variable "iam_instance_profile" {}
variable "instance_type" {}