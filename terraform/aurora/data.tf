################################################
## imports
################################################
## vpc
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["arc-poc"] # Correct VPC name
  }
}

## network
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  filter {
    name = "tag:Name"
    values = [
      "arc-poc-us-east-1a-1", 
      "arc-poc-us-east-1b-2"  
    ]
  }
}