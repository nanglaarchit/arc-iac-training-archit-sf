
output "rds_instance_id" {
  description = "RDS Instance ID"
  value       = aws_db_instance.rds.id
}
output "rds_security_group_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.rds_sg.id
}