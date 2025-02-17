variable "name" {
  description = "Name prefix"
  type        = string
}
variable "allocated_storage" {
  description = "Storage"
  type        = number
}
variable "storage_type" {
  description = "Storage type"
  type        = string
}
variable "engine" {
  description = "Database engine"
  type        = string
}
variable "engine_version" {
  description = "Engine version"
  type        = string
}
variable "instance_class" {
  description = "DB instance class"
  type        = string
}
variable "db_name" {
  description = "Database name"
  type        = string
}
variable "username" {
  description = "Username"
  type        = string
}
variable "password" {
  description = "Password"
  type        = string
  sensitive   = true
}
variable "port" {
  description = "Database port"
  type        = number
}
variable "multi_az" {
  description = "Multi-AZ deployment"
  type        = bool
}
variable "subnet_ids" {
  description = "Subnet IDs for DB subnet group"
  type        = list(string)
}
variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "sg_ingress" {
  description = "Ingress rules for security group"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
