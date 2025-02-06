# name                  = "archit"
# allocated_storage     = 30
# storage_type          = "gp3"
# engine                = "mysql"
# engine_version        = "8.0"
# instance_class        = "db.t3.micro"
# db_name               = "archit-iac-training"
# username              = "archit"
# password              = "sourcefuse0987"
# port                  = 3306
# multi_az              = false
# subnet_ids            = ""
# vpc_id                = ""
# sg_ingress = [
#   {
#     from_port   = 3306
#     to_port     = 3306
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# ]