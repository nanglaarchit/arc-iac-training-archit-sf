################################################
## defaults
################################################
terraform {
  required_version = ">= 1.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
  backend "s3" {
    bucket         = "archit-nangla-arc-iac"
    key            = "bootstrap/terraform.tfstate"
    region         = "us-east-1"  
  } 
}

provider "aws" {
  region = var.region
}

module "tags" {
  source      = "sourcefuse/arc-tags/aws"
  version     = "1.2.2"
  environment = var.environment
  project     = "arc"

  extra_tags = {
    Repo = "github.com/sourcefuse/terraform-aws-arc-bootstrap"
  }
}

module "bootstrap" {
  source  = "sourcefuse/arc-bootstrap/aws"
  version = "1.1.7"
  bucket_name              = var.bucket_name
  dynamodb_name            = var.dynamodb_name
  dynamo_kms_master_key_id = var.dynamo_kms_master_key_id

  tags = module.tags.tags
}