
provider "aws" {
  region = "us-east-1"  
}

module "network" {
  source = "../modules/network" 
  name            = "prod-network"
  vpc_cidr        = "10.1.0.0/16"
  public_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnets = ["10.1.3.0/24", "10.1.4.0/24"]
  azs             = ["us-east-1a", "us-east-1b"]
}
output "vpc_id" {
  value = module.network.vpc_id
}

module "ec2_instance" {
  source              = "../modules/ec2"
  name                = "archit"
  ami_id              = "ami-0f214d1b3d031dc53"
  instance_type       = "t3.medium"
  subnet_id           = "subnet-034f043f1b9b8df90"
  vpc_id              = "vpc-68f96212"
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
}