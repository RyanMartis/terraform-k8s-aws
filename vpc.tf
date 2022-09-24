# Terraform Provider Config
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  profile       = var.aws_profile_name
  region        = var.aws_region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr_block

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Terraform = var.tag_terraform
    Environment = var.tag_environment
    Name = var.tag_name
  }
}

output "vpc_id" {
	value = module.vpc.vpc_id
}
