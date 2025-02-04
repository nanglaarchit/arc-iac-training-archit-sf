
# name = "archit"

# ami_id              = "ami-0abcdef1234567890"
# instance_type       = "t3.medium"
# subnet_id           = ""
# vpc_id              = ""
# associate_public_ip = true

# sg_ingress = [
#   {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   },
#   {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# ]

# ebs_volumes = [
#   {
#     device_name = "/dev/sdb"
#     volume_size = 20
#     volume_type = "gp3"
#   },
#   {
#     device_name = "/dev/sdc"
#     volume_size = 50
#     volume_type = "gp3"
#   }
# ]