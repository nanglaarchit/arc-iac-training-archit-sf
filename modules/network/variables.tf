variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "name" {
  description = "Name of the network"
  type        = string
}
variable "private_subnets" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}
variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}
variable "public_subnets" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}