# VARIABLES SECTION
#variable "vpc_id" {
#  type        = string
#  description = "VPC Id to be used in our VMs"
#}

variable "allowed_cidr_blocks" {
  description = "CIDR block Allowed "
  type        = string
  default     = "0.0.0.0/0"
}

variable "ami_id" {
  description = "AMI ID EC2 Instance"
  type        = string
  default     = "ami-01893222c83843146"
}

#variable "lb_zones" {
#  type    = list(string)
#  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
#}
