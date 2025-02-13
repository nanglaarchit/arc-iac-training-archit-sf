provider "aws" {
  region = "us-east-1"
}

module "network" {
  source          = "../modules/network"
  name            = "prod-network"
  vpc_cidr        = "10.1.0.0/16"
  public_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnets = ["10.1.3.0/24", "10.1.4.0/24"]
  azs             = ["us-east-1a", "us-east-1b"]
}

output "vpc_id" {
  value = module.network.vpc_id
}
output "public_subnets" {
  value = module.network.public_subnets
}
output "private_subnets" {
  value = module.network.private_subnets
}

module "ec2_instance" {
  source              = "../modules/ec2"
  name                = "archit"
  ami_id              = "ami-0f214d1b3d031dc53"
  instance_type       = "t3.medium"
  subnet_id           = module.network.public_subnets[0]
  vpc_id              = module.network.vpc_id
  associate_public_ip = true

  sg_ingress = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  ebs_volumes = [
    {
      device_name = "/dev/sdb"
      volume_size = 20
      volume_type = "gp3"
    },
    {
      device_name = "/dev/sdc"
      volume_size = 50
      volume_type = "gp3"
    }
  ]

  depends_on = [module.network]
}

resource "random_password" "rds_password" {
  length           = 16
  special          = true
  override_special = "!@#%&*()-_=+[]{}<>?"
}
resource "aws_ssm_parameter" "rds_password" {
  name  = "/rds/password"
  type  = "SecureString"
  value = random_password.rds_password.result
  tags = {
    Name = "Archit"
  }
}
data "aws_ssm_parameter" "rds_password" {
  name            = "/rds/password"
  with_decryption = true
  depends_on      = [aws_ssm_parameter.rds_password]
}

module "rds" {
  source            = "../modules/rds"
  name              = "archit"
  allocated_storage = 30
  storage_type      = "gp3"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  db_name           = "arciactraining"
  username          = "archit"
  password          = data.aws_ssm_parameter.rds_password.value
  port              = 3306
  multi_az          = false
  subnet_ids        = module.network.private_subnets
  vpc_id            = module.network.vpc_id

  sg_ingress = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["10.1.1.0/24"]
    }
  ]
  skip_final_snapshot = true 
  depends_on = [module.network, module.ec2_instance]
}

output "rds_instance_id" {
  value = module.rds.rds_instance_id
}
output "rds_security_group_id" {
  value = module.rds.rds_security_group_id
}
