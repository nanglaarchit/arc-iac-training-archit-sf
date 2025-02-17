variable "name" {
  description = "Prefix for naming resources"
  type        = string
}
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}
variable "subnet_id" {
  description = "Subnet ID to launch the instance in"
  type        = string
}
variable "vpc_id" {
  description = "VPC ID where the EC2 instance is deployed"
  type        = string
}
variable "associate_public_ip" {
  description = "Assign a public IP to the instance"
  type        = bool
  default     = false
}
variable "sg_ingress" {
  description = "List of ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "ebs_volumes" {
  description = "List of additional EBS volumes"
  type = list(object({
    device_name = string
    volume_size = number
    volume_type = string
  }))
  default = []
}