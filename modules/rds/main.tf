resource "aws_db_instance" "rds" {
  allocated_storage      = var.allocated_storage
  storage_type           = var.storage_type
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  port                   = var.port
  multi_az               = var.multi_az
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  tags = {
    Name = "${var.name}-rds"
  }
}
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "${var.name}-db-subnet-group"
  }
}
resource "aws_security_group" "rds_sg" {
  name        = "${var.name}-rds-sg"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.name}-rds-sg"
  }
}
